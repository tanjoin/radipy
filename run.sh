#!/bin/zsh

# タイムスタンプ付きログ出力
LOGFILE="log/output-$(date '+%Y%m%d').log"
readonly PROCNAME=${0##*/}
log() {
  echo -e "$(date '+%Y-%m-%dT%H:%M:%S') ${PROCNAME} $@" | tee -a ${LOGFILE}
}

# 既ダウンロードURL管理ログ
DOWNLOAD_LOG="${DOWNLOAD_LOG:-download.log}"
# ログファイルが無ければ作成
[ -f "$DOWNLOAD_LOG" ] || : > "$DOWNLOAD_LOG"

WEBHOOK_URL=""
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
  WEBHOOK_URL="$SLACK_WEBHOOK_URL"
fi

# downalod_from_list <station> <file> <pattern1> [<pattern2> ...]
download_from_list() {

  local station="$1"
  local file="$2"
  shift 2

  # URLロック管理: 同時重複ダウンロードを防止
  LOCK_DIR="${LOCK_DIR:-tmp/downloading}"
  mkdir -p "$LOCK_DIR"

  acquire_url_lock() {
    local url="$1"
    local lock_id
    lock_id=$(echo -n "$url" | shasum | awk '{print $1}')
    local lock_path="$LOCK_DIR/$lock_id.lock"
    # mkdir は原子的に成功/失敗するためロックに使用
    if mkdir "$lock_path" 2>/dev/null; then
      # メタ情報を記録（任意）
      echo "$(date +%Y-%m-%dT%H:%M:%S%z) $$" > "$lock_path/info"
      return 0
    else
      return 1
    fi
  }

  release_url_lock() {
    local url="$1"
    local lock_id
    lock_id=$(echo -n "$url" | shasum | awk '{print $1}')
    local lock_path="$LOCK_DIR/$lock_id.lock"
    # ロック解除
    [ -d "$lock_path" ] && rm -rf "$lock_path"
  }

  # 指定日時(YYYYMMDDHHMMSS)から曜日ラベルを返す
  weekday_label() {
    local d="$1"
    local w
    w=$(date -j -f "%Y%m%d%H%M%S" "$d" "+%w" 2>/dev/null) || w=""
    case "$w" in
      0) echo "(日)" ;;
      1) echo "(月)" ;;
      2) echo "(火)" ;;
      3) echo "(水)" ;;
      4) echo "(木)" ;;
      5) echo "(金)" ;;
      6) echo "(土)" ;;
      *) echo "" ;;
    esac
  }

  # ファイル名サニタイズ（全角スペースを半角に置換し、禁則文字を置換）
  sanitize_filename() {
    local s="$1"
    # # 全角スペースを半角スペースに
    # s="${s//　/ }"
    # # 置換可能な記号は全角へ変換（ファイル名安全化）
    # # s="${s//&/＆}"
    # s="${s//\? /？}"
    # s="${s//\?/？}"
    # s="${s//\"/＂}"
    # s="${s//\*/＊}"
    # s="${s//</＜}"
    # s="${s//>/＞}"
    # s="${s//|/｜}"
    # s="${s//:/：}"
    # s="${s//\\/＼}"
    # s="${s//\//／}"
    echo "$s"
  }

  for pattern in "$@"; do
    (
      grep "$pattern" "$file" | while IFS= read -r line; do
        date="${line:0:14}"
        title="${line:15}"
        title="${title%%::*}"
        title_out="$(sanitize_filename "$title")"
        url="https://radiko.jp/#!/ts/${station}/${date}"

        (
          # 既にダウンロード済みならスキップ
          if grep -Fxq "$url" "$DOWNLOAD_LOG"; then
            log "[SKIP] Already downloaded: ${title_out}[${station}-${date}]"
            exit 0
          fi
          if acquire_url_lock "$url"; then
            dow_label="$(weekday_label "$date")"
            log "[START] ${title_out}[${station}-${date}] ${dow_label}"
            if yt-dlp -q "$url" -o "${title_out}[${station}-${date}].%(ext)s"; then
              log "[END] ${title_out}[${station}-${date}]"
              # ダウンロード成功時にURLを記録
              if ! grep -Fxq "$url" "$DOWNLOAD_LOG"; then
                printf "%s\n" "$url" >> "$DOWNLOAD_LOG"
              fi
              if [ -n "$WEBHOOK_URL" ]; then
                curl -s -o /dev/null -X POST -H 'Content-type: application/json' --data "{\"attachments\":[{\"fallback\":\"ダウンロード: ${title_out}[${station}-${date}]\",\"color\":\"good\",\"fields\":[{\"title\":\"ダウンロード\",\"value\":\"<${url}|${title_out}[${station}-${date}]>\"}]}]}" "$WEBHOOK_URL"
              fi
              release_url_lock "$url"
            else
              exit_code=$?
              log "[ERROR] ${title_out}[${station}-${date}] (exit ${exit_code})"
              if [ -n "$WEBHOOK_URL" ]; then
                curl -s -o /dev/null -X POST -H 'Content-type: application/json' --data "{\"attachments\":[{\"fallback\":\"エラー: ${title_out}[${station}-${date}]\",\"color\":\"danger\",\"fields\":[{\"title\":\"エラー\",\"value\":\"<${url}|${title_out}[${station}-${date}]>\"}]}]}" "$WEBHOOK_URL"
              fi
              release_url_lock "$url"
            fi
          else
            log "[SKIP] Duplicate in-progress: ${title_out}[${station}-${date}]"
          fi
        ) &
        
      done
      wait
    ) &
  done

  wait
}

echo "--------------------------------------------"
echo "[ラジオデータの保存　　　] `date`"
echo ''

# QRR (文化放送)
download_from_list "QRR" "list/QRR.data" \
  "A&Gメディアステーション" \
  "MOMO・SORA・SHIINA" \
  "MSSP" \
  "エジソン" \
  "キミまち" \
  "こむちゃっと" \
  "芹澤優" \
  "小原好美" \
  "小松未可子" \
  "小倉唯" \
  "上坂すみれ" \
  "上田麗奈" \
  "水樹奈々" \
  "水瀬いのり" \
  "浅野真澄" \
  "早見沙織" \
  "田村ゆかり" \
  "東山奈央" \
  "楠木ともり" \
  "白石晴香" \
  "堀江由衣" \
  "本渡楓" \
  "羊宮妃那" \
  "魔法少女まどか☆マギカ" \
  "前橋ウィッチーズ" &

# JORF (ラジオ日本)
download_from_list "JORF" "list/JORF.data" \
  "芹澤優" \
  "大原優乃" \
  "やっぱりＳが好き" &

# FMT (TOKYO FM)
download_from_list "FMT" "list/FMT.data" \
  "水樹奈々" \
  "古賀葵" \
  "長谷川育美" \
  "Memories＆Discoveries" \
  "逢田梨香子" &

# YFM (ＦＭヨコハマ)
download_from_list "YFM" "list/YFM.data" \
  "笑顔モリモリらじお" \
  "Share the Night" &

# NACK5 (NACK5)
download_from_list "NACK5" "list/NACK5.data" \
  "七転八起～Never give up～" \
  "Voice Actors" &

# JOAK (NHKラジオ第1（東京）)
download_from_list "JOAK" "list/JOAK.data" \
  "マジカル・ポップ・ツアー" &

# BAYFM78 (BAYFM78)
download_from_list "BAYFM78" "list/BAYFM78.data" \
  "からかい上手の高木さん" &

# LFR (ニッポン放送)
download_from_list "LFR" "list/LFR.data" \
  "キン肉マン" \
  "上坂すみれ" &

# IBS (LuckyFM 茨城放送)
download_from_list "IBS" "list/IBS.data" \
  "佐咲紗花" &

# TBS (TBSラジオ)
download_from_list "TBS" "list/TBS.data" \
  "佐倉綾音" &

# INT (interfm)
download_from_list "INT" "list/INT.data" \
  "上坂すみれ" &

# RN1 (NHKラジオ第1（東京）)
download_from_list "RN1" "list/RN1.data" \
  "りん競馬" &

wait

echo ''
echo "--------------------------------------------"
echo "[ラジオデータの保存　完了] `date`"

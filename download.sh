#!/bin/zsh

# タイムスタンプ付きログ出力（標準のlogコマンドとの衝突を防ぐため my_log に変更）
LOGFILE="log/output-$(date '+%Y%m%d').log"
readonly PROCNAME=${0##*/}
my_log() {
  echo -e "$(date '+%Y-%m-%dT%H:%M:%S') ${PROCNAME} $@" | tee -a ${LOGFILE}
}

# 既ダウンロードURL管理ログ
DOWNLOAD_LOG="${DOWNLOAD_LOG:-download.log}"
[ -f "$DOWNLOAD_LOG" ] || : > "$DOWNLOAD_LOG"

WEBHOOK_URL=""
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
  WEBHOOK_URL="$SLACK_WEBHOOK_URL"
fi

create_radiko_dir() {
  # 【完全復元】1番最初に成功した、一番シンプルで確実な切り出しロジック
  station=$(echo "$1" | cut -d'/' -f6)
  date=$(echo "$1" | cut -d'/' -f7 | cut -c1-8)

  # 2. 最初と全く同じ1行のラインでタイトルを取得
  title_out=$(curl -s "https://radiko.jp/v3/program/station/date/${date}/${station}.xml" | grep -A 5 "ft=\"$(echo "$1" | cut -d'/' -f7)\"" | grep -o -E '<title>.*</title>' | sed -e 's/<title>//' -e 's/<\/title>//' | tr '/' '／')    

  # 3. 万が一タイトルが空だった場合のフォールバック（局名-日時に設定）
  if [ -z "$title_out" ]; then
    title_out="${station}-$(echo "$1" | cut -d'/' -f7)"
  fi
}

# URLロック管理
LOCK_DIR="${LOCK_DIR:-tmp/downloading}"
mkdir -p "$LOCK_DIR"

acquire_url_lock() {
  local url="$1"
  local lock_id
  lock_id=$(echo -n "$url" | shasum | awk '{print $1}')
  local lock_path="$LOCK_DIR/$lock_id.lock"
  if mkdir "$lock_path" 2>/dev/null; then
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

# 中断・終了時のシグナルハンドラ関数
cleanup_on_exit() {
  if [ -n "$1" ]; then
    release_url_lock "$1"
  fi
  exit 1
}

download_radio() {
  local url="$1"

  # トラップを設定: 中断時にURLを渡してロックを自動クリーンアップ
  trap 'cleanup_on_exit "$url"' INT TERM

  create_radiko_dir "$url"

  if acquire_url_lock "$url"; then
    # 14桁の日時文字列を取得して曜日関数へ渡す
    local datetime_str=$(echo "$url" | cut -d'/' -f7)
    dow_label="$(weekday_label "$datetime_str")"
    
    my_log "[START] ${title_out}[${station}-${date}] ${dow_label}"
    if yt-dlp -q "$url" -o "${title_out}[${station}-${date}].%(ext)s"; then
      my_log "[END] ${title_out}[${station}-${date}]"
      if ! grep -Fxq "$url" "$DOWNLOAD_LOG"; then
        printf "%s\n" "$url" >> "$DOWNLOAD_LOG"
      fi
      if [ -n "$WEBHOOK_URL" ]; then
        curl -s -o /dev/null -X POST -H 'Content-type: application/json' --data "{\"attachments\":[{\"fallback\":\"ダウンロード: ${title_out}[${station}-${date}]\",\"color\":\"good\",\"fields\":[{\"title\":\"ダウンロード\",\"value\":\"<${url}|${title_out}[${station}-${date}]>\"}]}]}" "$WEBHOOK_URL"
      fi
      release_url_lock "$url"
      trap - INT TERM
    else
      exit_code=$?
      my_log "[ERROR] ${title_out}[${station}-${date}] (exit ${exit_code})"
      if [ -n "$WEBHOOK_URL" ]; then
        curl -s -o /dev/null -X POST -H 'Content-type: application/json' --data "{\"attachments\":[{\"fallback\":\"エラー: ${title_out}[${station}-${date}]\",\"color\":\"danger\",\"fields\":[{\"title\":\"エラー\",\"value\":\"<${url}|${title_out}[${station}-${date}]>\"}]}]}" "$WEBHOOK_URL"
      fi
      release_url_lock "$url"
      trap - INT TERM
    fi
  else
    my_log "[SKIP] Duplicate in-progress: ${title_out}[${station}-${date}]"
    trap - INT TERM
  fi
}

# --- 引数の解析とメイン処理の実行 ---

FORCE_RELEASE=false
TARGET_URL=""

# 引数をチェックして、-f または --force があればフラグを立てる
for arg in "$@"; do
  if [[ "$arg" == "-f" || "$arg" == "--force" ]]; then
    FORCE_RELEASE=true
  else
    TARGET_URL="$arg"
  fi
done

if [ -z "$TARGET_URL" ]; then
  echo "エラー: radikoのURLを指定してください。" >&2
  exit 1
fi

# 強制解除フラグが立っている場合、先にロックを削除する
if [ "$FORCE_RELEASE" = true ]; then
  my_log "[FORCE] 既存のロックを強制解除します: $TARGET_URL"
  release_url_lock "$TARGET_URL"
fi

# ダウンロード処理を実行
download_radio "$TARGET_URL"
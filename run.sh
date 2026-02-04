#!/bin/zsh

# downalod_from_list <station> <file> <pattern1> [<pattern2> ...]
download_from_list() {
	local station="$1"
	local file="$2"
	shift 2
	for pattern in "$@"; do
		grep "$pattern" "$file" | while IFS= read -r line; do
			date="${line:0:14}"
			title="${line:15}"
			title="${title%%::*}"
			echo "[START] ${title}[${station}-${date}]"
			yt-dlp -q "https://radiko.jp/#!/ts/${station}/${date}" -o "${title}[${station}-${date}].%(ext)s"
			echo "[END] ${title}[${station}-${date}]"
		done &
	done
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
  "前橋ウィッチーズ"

# JORF (ラジオ日本)
download_from_list "JORF" "list/JORF.data" \
  "芹澤優" \
  "大原優乃" \
  "やっぱりＳが好き"

# FMT (TOKYO FM)
download_from_list "FMT" "list/FMT.data" \
  "水樹奈々" \
  "古賀葵" \
  "長谷川育美" \
  "Memories＆Discoveries" \
  "逢田梨香子"

# YFM (ＦＭヨコハマ)
download_from_list "YFM" "list/YFM.data" \
  "笑顔モリモリらじお" \
  "Share the Night"

# NACK5 (NACK5)
download_from_list "NACK5" "list/NACK5.data" \
  "七転八起～Never give up～" \
  "Voice Actors"

# JOAK (NHKラジオ第1（東京）)
download_from_list "JOAK" "list/JOAK.data" \
  "マジカル・ポップ・ツアー"

# BAYFM78 (BAYFM78)
download_from_list "BAYFM78" "list/BAYFM78.data" \
  "からかい上手の高木さん"

# LFR (ニッポン放送)
download_from_list "LFR" "list/LFR.data" \
  "キン肉マン" \
  "上坂すみれ"

# IBS (LuckyFM 茨城放送)
download_from_list "IBS" "list/IBS.data" \
  "佐咲紗花"

# TBS (TBSラジオ)
download_from_list "TBS" "list/TBS.data" \
  "佐倉綾音"

# INT (interfm)
download_from_list "INT" "list/INT.data" \
  "上坂すみれ"

# RN1 (NHKラジオ第1（東京）)
download_from_list "RN1" "list/RN1.data" \
  "りん競馬"

wait

echo ''
echo "--------------------------------------------"
echo "[ラジオデータの保存　完了] `date`"

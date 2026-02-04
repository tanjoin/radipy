echo "--------------------------------------------"
echo "[ラジオデータの保存　　　] `date`"
echo ''

# QRR (文化放送)
# grep "MOMO・SORA・SHIINA" list/QRR.data | cut -c 1-14 | xargs -I @ sh -c "yt-dlp 'https://radiko.jp/#!/ts/QRR/@'" &
station_id="QRR"
grep "A&Gメディアステーション" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "MOMO・SORA・SHIINA" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "MSSP" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "エジソン" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "キミまち" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "こむちゃっと" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "芹澤優" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "小原好美" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "小松未可子" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "小倉唯" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "上坂すみれ" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "上田麗奈" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "水樹奈々" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "水瀬いのり" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "浅野真澄" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "早見沙織" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "田村ゆかり" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "東山奈央" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "楠木ともり" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "白石晴香" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "堀江由衣" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "本渡楓" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "羊宮妃那" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "魔法少女まどか☆マギカ" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "前橋ウィッチーズ" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
# JORF (ラジオ日本)
station_id="JORF"
grep "芹澤優" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "大原優乃" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "やっぱりＳが好き" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
# FMT (TOKYO FM)
station_id="FMT"
grep "水樹奈々" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "古賀葵" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "長谷川育美" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "Memories＆Discoveries" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "逢田梨香子" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
# YFM (ＦＭヨコハマ)
station_id="YFM"
grep "笑顔モリモリらじお" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "Share the Night" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
# NACK5 (NACK5)
station_id="NACK5"
grep "七転八起～Never give up～" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "Voice Actors" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
# JOAK (NHKラジオ第1（東京）)
station_id="JOAK"
grep "マジカル・ポップ・ツアー" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
# BAYFM78 (BAYFM78)
station_id="BAYFM78"
grep "からかい上手の高木さん" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
# LFR (ニッポン放送)
station_id="LFR"
grep "キン肉マン" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
grep "上坂すみれ" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
# IBS (LuckyFM 茨城放送)
station_id="IBS"
grep "佐咲紗花" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
# TBS (TBSラジオ)
station_id="TBS"
grep "佐倉綾音" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
# INT (interfm)
station_id="INT"
grep "上坂すみれ" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &
# RN1 (NHKラジオ第1（東京）)
station_id="RN1"
grep "りん競馬" list/${station_id}.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; echo "[START] ${title}[${station_id}-${date}]"; yt-dlp -q "https://radiko.jp/#!/ts/${station_id}/${date}" -o "${title}[${station_id}-${date}].%(ext)s"; echo "[END] ${title}[${station_id}-${date}]"; done &

wait

echo ''
echo "--------------------------------------------"
echo "[ラジオデータの保存　完了] `date`"

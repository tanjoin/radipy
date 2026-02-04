echo "--------------------------------------------"
echo "[ラジオデータの保存　　　] `date`"
echo ''

# QRR (文化放送)
# grep "MOMO・SORA・SHIINA" list/QRR.data | cut -c 1-14 | xargs -I @ sh -c "yt-dlp 'https://radiko.jp/#!/ts/QRR/@'" &
grep "A&Gメディアステーション" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "MOMO・SORA・SHIINA" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "MSSP" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "エジソン" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "キミまち" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "こむちゃっと" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "芹澤優" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "小原好美" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "小松未可子" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "小倉唯" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "上坂すみれ" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "上田麗奈" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "水樹奈々" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "水瀬いのり" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "浅野真澄" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "早見沙織" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "田村ゆかり" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "東山奈央" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "楠木ともり" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "白石晴香" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "堀江由衣" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "本渡楓" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "羊宮妃那" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "魔法少女まどか☆マギカ" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
grep "前橋ウィッチーズ" list/QRR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[QRR-${date}].%(ext)s"; done &
# JORF (ラジオ日本)
grep "芹澤優" list/JORF.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[JORF-${date}].%(ext)s"; done &
grep "大原優乃" list/JORF.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[JORF-${date}].%(ext)s"; done &
grep "やっぱりＳが好き" list/JORF.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[JORF-${date}].%(ext)s"; done &
# FMT (TOKYO FM)
grep "水樹奈々" list/FMT.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[FMT-${date}].%(ext)s"; done &
grep "古賀葵" list/FMT.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[FMT-${date}].%(ext)s"; done &
grep "長谷川育美" list/FMT.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[FMT-${date}].%(ext)s"; done &
grep "Memories＆Discoveries" list/FMT.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[FMT-${date}].%(ext)s"; done &
grep "逢田梨香子" list/FMT.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[FMT-${date}].%(ext)s"; done &
# YFM (ＦＭヨコハマ)
grep "笑顔モリモリらじお" list/YFM.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[YFM-${date}].%(ext)s"; done &
grep "Share the Night" list/YFM.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[YFM-${date}].%(ext)s"; done &
# NACK5 (NACK5)
grep "七転八起～Never give up～" list/NACK5.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[NACK5-${date}].%(ext)s"; done &
grep "Voice Actors" list/NACK5.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[NACK5-${date}].%(ext)s"; done &
# JOAK (NHKラジオ第1（東京）)
grep "マジカル・ポップ・ツアー" list/JOAK.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[JOAK-${date}].%(ext)s"; done &
# BAYFM78 (BAYFM78)
grep "からかい上手の高木さん" list/BAYFM78.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[BAYFM78-${date}].%(ext)s"; done &
# LFR (ニッポン放送)
grep "キン肉マン" list/LFR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[LFR-${date}].%(ext)s"; done &
grep "上坂すみれ" list/LFR.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[LFR-${date}].%(ext)s"; done &
# IBS (LuckyFM 茨城放送)
grep "佐咲紗花" list/IBS.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[IBS-${date}].%(ext)s"; done &
# TBS (TBSラジオ)
grep "佐倉綾音" list/TBS.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[TBS-${date}].%(ext)s"; done &
# INT (interfm)
grep "上坂すみれ" list/INT.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[INT-${date}].%(ext)s"; done &
# RN1 (NHKラジオ第1（東京）)
grep "りん競馬" list/RN1.data | while IFS= read -r line; do date="${line:0:14}"; title="${line:15}"; title="${title%%::*}"; yt-dlp "https://radiko.jp/#!/ts/QRR/${date}" -o "${title}[RN1-${date}].%(ext)s"; done &

wait

echo ''
echo "--------------------------------------------"
echo "[ラジオデータの保存　完了] `date`"

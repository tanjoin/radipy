echo "--------------------------------------------"
echo "[過去データの保存　　　] `date`"

cat list/QRR.data >> list/old/QRR.data
cat list/JORF.data >> list/old/JORF.data
cat list/FMT.data >> list/old/FMT.data
cat list/YFM.data >> list/old/YFM.data
cat list/NACK5.data >> list/old/NACK5.data
cat list/JOAK.data >> list/old/JOAK.data
cat list/BAYFM78.data >> list/old/BAYFM78.data
cat list/LFR.data >> list/old/LFR.data
cat list/IBS.data >> list/old/IBS.data
cat list/TBS.data >> list/old/TBS.data
cat list/INT.data >> list/old/INT.data

echo "--------------------------------------------"
echo "[過去データの保存　完了] `date`"

export PIPENV_IGNORE_VIRTUALENVS=1
export PIPENV_DONT_LOAD_ENV=1

# 取得日付のオフセット（日）— この値を編集して一括変更
DAYS_BACK=${1:-1}

echo "--------------------------------------------"
echo "[番組表の取得　　　] `date`"

pipenv run radipy -id=QRR -ls -dt=`date -v -${DAYS_BACK}d "+%Y-%m-%d"` > list/QRR.data
pipenv run radipy -id=JORF -ls -dt=`date -v -${DAYS_BACK}d "+%Y-%m-%d"` > list/JORF.data
pipenv run radipy -id=FMT -ls -dt=`date -v -${DAYS_BACK}d "+%Y-%m-%d"` > list/FMT.data
pipenv run radipy -id=YFM -ls -dt=`date -v -${DAYS_BACK}d "+%Y-%m-%d"` > list/YFM.data
pipenv run radipy -id=NACK5 -ls -dt=`date -v -${DAYS_BACK}d "+%Y-%m-%d"` > list/NACK5.data
pipenv run radipy -id=JOAK -ls -dt=`date -v -${DAYS_BACK}d "+%Y-%m-%d"` > list/JOAK.data 
pipenv run radipy -id=BAYFM78 -ls -dt=`date -v -${DAYS_BACK}d "+%Y-%m-%d"` > list/BAYFM78.data
pipenv run radipy -id=LFR -ls -dt=`date -v -${DAYS_BACK}d "+%Y-%m-%d"` > list/LFR.data
pipenv run radipy -id=IBS -ls -dt=`date -v -${DAYS_BACK}d "+%Y-%m-%d"` > list/IBS.data
pipenv run radipy -id=TBS -ls -dt=`date -v -${DAYS_BACK}d "+%Y-%m-%d"` > list/TBS.data
pipenv run radipy -id=INT -ls -dt=`date -v -${DAYS_BACK}d "+%Y-%m-%d"` > list/INT.data
pipenv run radipy -id=RN1 -ls -dt=`date -v -${DAYS_BACK}d "+%Y-%m-%d"` > list/RN1.data

echo "--------------------------------------------"
echo "[番組表の取得　完了] `date`"

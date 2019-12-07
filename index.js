const CronJob = require('cron').CronJob;
const exec = require('child_process').exec;

new CronJob('30 9 * * *', async () => {
  console.log('get list!');
  exec('./list.sh', (err, stdout, stderr) => {
    if (err) {
      console.error(err);
      return;
    }
    console.log(stdout);
  });
}, null, true, 'Asia/Tokyo');

new CronJob('30 7 * * *', async () => {
  console.log('cron start!' + new Date().toLocaleString('ja-JP'));
  exec('./run.sh', (err, stdout, stderr) => {
    if (err) {
      console.error(err);
      return;
    }
    console.log(stdout);
  });
}, null, true, 'Asia/Tokyo');

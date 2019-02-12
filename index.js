const CronJob = require('cron').CronJob;
const exec = require('child_process').exec;

new CronJob('00 */3 * * *', async () => {
  console.log('cron start!');
  exec('./run.sh', (err, stdout, stderr) => {
    if (err) {
      console.error(err);
      return;
    }
    console.log(stdout);
  });
}, null, true, 'Asia/Tokyo');

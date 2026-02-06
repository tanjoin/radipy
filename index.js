const CronJob = require('cron').CronJob;
const spawn = require('child_process').spawn;

function spawnPromise(command, args, options) {
  return new Promise((resolve, reject) => {
    const child = spawn(command, args, options);
    child.on('close', (code) => {
      if (code === 0) {
        resolve();
      } else {
        reject(new Error(`Process exited with code: ${code}`));
      }
    });
  });
};

async function cron() {
  new CronJob('30 7 * * *', async () => {
    console.log('get list!');
    // Use explicit shell interpreter to avoid shell:true
    await spawnPromise('/bin/zsh', ['list.sh'], { stdio: 'inherit' });
  }, null, true, 'Asia/Tokyo');

  new CronJob('30 8 * * *', async () => {
    console.log('cron start!' + new Date().toLocaleString('ja-JP'));
    // run.sh has a shebang; call directly without shell
    await spawnPromise('/bin/zsh', ['run.sh'], { stdio: 'inherit' });
  }, null, true, 'Asia/Tokyo');

  new CronJob('0 6 * * *', async () => {
    console.log('organize files!');
    // Call pipenv directly with args; no shell needed
    await spawnPromise('pipenv', ['run', 'org'], { stdio: 'inherit', env: {
      ...process.env,
      PIPENV_DONT_LOAD_ENV: 1,
    } });
  }, null, true, 'Asia/Tokyo');
}

async function main() {
  await spawnPromise('pipenv', ['run', 'org'], { stdio: 'inherit', env: {
    ...process.env,
    PIPENV_DONT_LOAD_ENV: 1,
  } });
  const dayBack = (() => {
    const dIndex = process.argv.indexOf('-d');
    if (dIndex !== -1 && process.argv.length > dIndex + 1) {
      return process.argv[dIndex + 1];
    }
    const dbIndex = process.argv.indexOf('--day-back');
    if (dbIndex !== -1 && process.argv.length > dbIndex + 1) {
      return process.argv[dbIndex + 1];
    }
    return undefined;
  })();
  await spawnPromise('/bin/zsh', ['list.sh', dayBack], { stdio: 'inherit' });
  await spawnPromise('/bin/zsh', ['run.sh'], { stdio: 'inherit' });
}

if (require.main === module) (async () => {
  if (process.argv.includes('--cron')) {
    await cron();
  } else {
    await main();
  }
})();

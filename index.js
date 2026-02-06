const CronJob = require("cron").CronJob;
const spawn = require("child_process").spawn;

class Radipy {
  constructor({ timezone = "Asia/Tokyo", shell = "/bin/zsh" } = {}) {
    this.timezone = timezone;
    this.shell = shell;
  }

  spawn(command, args, options) {
    return new Promise((resolve, reject) => {
      const child = spawn(command, args, options);
      child.on("close", (code) => {
        if (code === 0) {
          resolve();
        } else {
          reject(new Error(`Process exited with code: ${code}`));
        }
      });
      child.on("error", reject);
    });
  }

  async organize() {
    await this.spawn("pipenv", ["run", "org"], {
      stdio: "inherit",
      env: { ...process.env, PIPENV_DONT_LOAD_ENV: 1 },
    });
  }

  async list(dayBack) {
    const args = ["list.sh"];
    if (dayBack !== undefined) args.push(dayBack);
    await this.spawn(this.shell, args, { stdio: "inherit" });
  }

  async run() {
    await this.spawn(this.shell, ["run.sh"], { stdio: "inherit" });
  }

  startCron() {
    new CronJob("30 7 * * *", async () => {
      console.log("get list!");
      await this.list();
    }, null, true, this.timezone);

    new CronJob("30 8 * * *", async () => {
      console.log("cron start!" + new Date().toLocaleString("ja-JP"));
      await this.run();
    }, null, true, this.timezone);

    new CronJob("0 6 * * *", async () => {
      console.log("organize files!");
      await this.organize();
    }, null, true, this.timezone);
  }

  static parseDayBack(argv) {
    // support: -d 1, -d=1, --day-back 1, --day-back=1
    const aliases = new Set(["-d", "--day-back"]);
    for (let i = 0; i < argv.length; i++) {
      const token = argv[i];
      const eq = token.indexOf("=");
      if (eq !== -1) {
        const key = token.slice(0, eq);
        const val = token.slice(eq + 1);
        if (aliases.has(key)) return val;
      } else if (aliases.has(token) && i + 1 < argv.length) {
        return argv[i + 1];
      }
    }
    return undefined;
  }

  async runOnce(argv = process.argv) {
    await this.organize();
    const dayBack = Radipy.parseDayBack(argv);
    await this.list(dayBack);
    await this.run();
  }
}

module.exports = { Radipy };

if (require.main === module) (async () => {
  const radipy = new Radipy();
  if (process.argv.includes("--cron")) {
    radipy.startCron();
  } else {
    await radipy.runOnce(process.argv);
  }
})();

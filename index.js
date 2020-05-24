const core = require('@actions/core');
const github = require('@actions/github');
const { exec } = require("child_process");

const execCmd = async (cmd) => {
  const runningCmd = exec(cmd);

  runningCmd.stdout.on('data', (data) => {
    console.log(data.toString());
  });

  runningCmd.stderr.on('data', (data) => {
    console.log(data.toString());
  });

  return new Promise((resolve, reject) => {
    runningCmd.on('err', (err) => {
      console.log(err);
    })

    runningCmd.on('exit', (code) => {
      if (code === 0) {
        resolve()
      } else {
        reject(code)
      }
    })
  })
}

const main = async () => {
  console.log("===Preparing for build===")
  await execCmd('./scripts/prep.sh')
  
  const template = core.getInput('template')
  console.log(`===Building template ${template}===`)
  await execCmd('./scripts/build.sh')

  const time = (new Date()).toTimeString()
  core.setOutput("time", time)

  // Get the JSON webhook payload for the event that triggered the workflow
  // const payload = JSON.stringify(github.context.payload, undefined, 2)
  // console.log(`The event payload: ${payload}`);
}

main()
  .catch((error) => {
    core.setFailed(error.message)
  })
const core = require('@actions/core');
const github = require('@actions/github');
const { execSync } = require("child_process");

try {
  console.log(execSync('sudo apt-get -y install build-essential').toString())
  
  const template = core.getInput('template');
  console.log(`Building template ${template}...`);

  const time = (new Date()).toTimeString();
  core.setOutput("time", time);

  // Get the JSON webhook payload for the event that triggered the workflow
  const payload = JSON.stringify(github.context.payload, undefined, 2)
  console.log(`The event payload: ${payload}`);
} catch (error) {
  core.setFailed(error.message);
}
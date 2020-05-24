const core = require('@actions/core');
const github = require('@actions/github');
const { execSync } = require("child_process");

try {
  console.log("===Preparing for build===")
  console.log(execSync('./scripts/prep.sh').toString())
  
  const template = core.getInput('template');
  console.log(`===Building template ${template}===`);
  console.log(execSync('./scripts/build.sh').toString())

  const time = (new Date()).toTimeString();
  core.setOutput("time", time);

  // Get the JSON webhook payload for the event that triggered the workflow
  // const payload = JSON.stringify(github.context.payload, undefined, 2)
  // console.log(`The event payload: ${payload}`);
} catch (error) {
  core.setFailed(error.message);
}
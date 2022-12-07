# Docker for Amazon Web Services (AWS) Management

## Usage

* Add the function below to your `.zshrc` file And Modify `THIS_REPO_LOCATION` to your own location.

```shell
function ops {
    cd THIS_REPO_LOCATION && make bash PROFILE=${1:-default}
}
```

* Clone your `playbook` repo into `work` directory.
* Use command `ops` to enter container and then do what you want with Ansible and Aws CLI

## Useful AWS CLI command shortcuts

* AWS CLI command shortcuts located in the file `home/.mybashrc`, and you can modify freely.
* command shortcut `ec2` list all running ec2 instances in current location.
* command shortcut `ssm` with ec2 instance id as parameter to connect to ec2 instance.

## How to Change Profile (if you have multiple profiles)

* use internal command `senv YOUR_PROFILE_NAME` to change profile.
* `senv --region SPECIFIED_REGION ` to change current region.
* [Named profiles for the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) are located in `~/.aws`.

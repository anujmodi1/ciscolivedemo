#This section will provide you guidance to run the common Appdyanmics API Tasks. 

Understand that the Instructor has already generated an AppD Access API key from the GUI and entered it into the vault.

To run these tasks, make sure you are in the input directory:
$cd ciscolivedemo/Section08_appd_api_tasks/input

Login via fly with the username and password shared with you in the lab guide
$fly --target=target login --concourse-url=http://dev-ci.ciscolivedemo2022.com:8080 -n main --username=ci --password=cisco@2022

Run the task and verify you can authenticate to and get a valid json response from the AppD API:
$fly -t target e -c appd_get_token_task.yml

This authenticates to the AppD Api and generates a temporary oath token and writes it to the vault

$fly -t target e -c appd_use_token_task.yml
This uses the temp oath token you generated that was written to the vault and uses it to perform an API call that returns list of business transactions from Supercar Trader App from the AppD API


What happens when you excute a task?
- the task first instructs the Concourse CI to deploy an ephemeral build container using the docker image specified in the task yaml file.
  (the build container is deployed from a docker image that is curated to have all libraries, modules, etc installed to operate with the API)
- the Concouse CI is integrated with Vault in the backend, so that the variable values including the API token and SSH key are passed into the build container
  as environmental variables so they can be utilized by python code
- the input directory is copied up to the build container
- the commands in the task yaml are executed on the build container
- the commands execute against the api and return the requested json data - in this case our output is a list of devices returned by the  AppD api
- if successful, the build container disappears - it is garbage collected.

In this lab, we use vault not only for our tokens, api keys, rsa keys, passwords, but also for config files, CIDR ranges and as a general artifactory
for anything that is output we want to retain so we can lifecyle that in the future or utilize it as a input.

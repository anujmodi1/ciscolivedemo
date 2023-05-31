#This section will provide you guidance to run the common ThousandEyes API Tasks. 

The Instructor has already generated an TE OAuth API key from the GUI and entered it into the vault.

To run these tasks, make sure you are in the input directory:
cd ciscolivedemo/Section07_te_api_tasks/input

Login via fly with the username and password shared with you in the lab guide
fly --target=target login --concourse-url=http://dev-ci.ciscolivedemo2022.com:8080 -n main --username=ci --password=xxxxx

Run the task and verify you can authenticate to and get a valid json response from the AppD API:
fly -t target e -c te_api_task_1.yml


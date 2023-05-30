#This section will provide you guidance to run the common ThousandEyes API Tasks. 

The Instructor has already generated an TE OAuth API key from the GUI and entered it into the vault.

To run these tasks, make sure you are in the input directory:
cd ciscolivedemo/Section07_te_api_tasks/input

Login via fly with the username and password shared with you in the lab guide
fly --target=target login --concourse-url=http://dev-ci.ciscolivedemo2022.com:8080 -n main --username=ci --password=xxxxx


Run the task and verify you can authenticate to and get a valid json response from the AppD API:
fly -t target e -c te_api_task.yml


First Step....
=======

It will try to create a test with a name that already exists - and will return a 404 API error.
The automation task will be successful however, as the code itself executed without errors


Second Step...
================
To make the task run successfully, rename the test - it must be a unique test name so perhaps use your 
first initial and last name - 1

Run the tasks again and you will get a <Response 201> and the task will say succeeded, which means the code
executed correctly without error.

First Step....
=======

It will try to create a test with a name that already exists - and will return a 404 API error.
The automation task will be successful however, as the code itself executed without errors.
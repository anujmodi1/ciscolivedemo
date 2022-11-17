What this task does...
====================

<<<<<<< HEAD
This task, will fail the first time by design. As Devops Engineers, Software Developers, or Network Developers,
regardless of your Title, the best practise when writing code is to write it in small chunks,
and write it to first fail. 

Iterate quickly and test immediately - fix the code and ensure it runs successfully.

This is the standard software development process of "Red Green Refactor"
https://www.codecademy.com/article/tdd-red-green-refactor
=======
This task, will fail the first time by design.
>>>>>>> 08cdad69cba2e561cf1308f4beabd8068ae0fe57

This task will create a new test, and it will then add all the enterprise agents to the test.

You may only add the enterprise agents via the api to the test by using the agent id's

Therefore, the first step in the code, queries the api for a list of all agents, 
and then filters out just the enterprise agents. The agents api initially returns all cloud and enterprise agents.
Therefore, in the python, we filter out just the enterprise agents.

We create a dictionary, with key value pairs and post this to the api so that all enterprise agents are added to the test.


First Step....
=======

It will try to create a test with a name that already exists - and will return a 404 API error.
The automation task will be successful however, as the code itself executed without errors.


Second Step...
================
To make the task run successfully, rename the test - it must be a unique test name so perhaps use your 
first initial and last name - 1

Run the tasks again and you will get a <Response 201> and the task will say succeeded, which means the code
executed correctly without error.
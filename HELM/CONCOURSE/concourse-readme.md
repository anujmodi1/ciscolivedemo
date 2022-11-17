Current Release - October 17, 2022 by Sherri Conrod

Helm Install/Upgrade of Concourse 
===========
Current Release
==========
- [] New install make sure the image tag and chart:
  imageTag: "7.8.1" chart: "concourse-17.0.15"
  https://github.com/concourse/concourse-chart/releases/

Concourse keeps adding in new features and integrations on a weekly cadence. 
If you wish to upgrade the image tag or chart version, you should first test it with a new deploy in a separate environment

## pipeline-specific template for SSM parameters, defaults to: /concourse/{{.Team}}/{{.Pipeline}}/{{.Secret}}
      ##
      pipelineSecretTemplate: /concourse/{{.Team}}/{{.Pipeline}}/{{.Secret}}

- [] Before installing, update the ci user password in the values file on line 2788 from $PASSWORD to something new
  - line 2789:localUsers: "ci:cisco@2022,ap-south-1a:ap-south-1a!"
- [] Update your vault url and also your concourse web external url
  - line 250: externalUrl: http://dev-ci.ciscolivedemo2022.com:8080
  - line 568: url: http://dev-vault.ciscolivedemo2022.com:8200url: http://dev-vault.ciscolivedemo2022.com:8200
- [] Generate an approle_id and secret_id in vault and update the values file - there are two place to update this, search on "vaultAuthParam"
  - line 607: vaultAuthParam: "role_id:504cc747-f759-f26b-f477-d0de7c1b5bdb,secret_id:c81036b8-c7e1-0681-f427-9872f80d7020"
- [] Test out your approle_id and secret_id :

curl -k -XPOST -d '{"role_id":"c5b11052-e660-1615-2d99-4337dea60166","secret_id":"00d19ad5-8a45-ab8e-0ae3-d27bb5493914"}' http://prod-vault.devops-ontap.com:8200/v1/auth/approle/login | jq


Helm Upgrades
======

Before doing a helm upgrade of concourse you must generate a new secret_id
After doing a Helm upgrade of concourse you must re-create teams and assign appropriate roles

fly -t cisco-fso-labs set-team --team-name cisco-fso-labs --local-user us-west-1a -c roles/owner.yml

Login
====

fly --target=prod login --concourse-url=http://prod-ci.devops-ontap.com:8080 -n main --username=ci --password=""

fly --target=dev login --concourse-url=http://dev-ci.ciscolivedemo2022.com:8080 -n main --username=ci --password=cisco@2022

Set-Pipeline Example:
========
fly -t dev set-pipeline -p development e -c pipeline-v3.yml -l /Users/sconrod/dev/cisco-fso-lab-gen/params/main-us-west-2a.yml -v aws.region=us-west-2 -v az.name=us-west-2a -v vault.addr=http://prod-vault.devops-ontap.com:8200

fly -t dev set-pipeline -p development -c /Users/anmodi/dev/ciscolivedemo/pipelines/pipeline-v4.yml -l /Users/anmodi/dev/notes-ciscolive/ciscolive-params.yml -v aws.region=us-west-1 -v az.name=us-west-1a -v vault.addr=http://dev-vault.ciscolivedemo2022.com:8200


(you can also put the variables passed to this command in your parameters file)

Setup Teams and Roles
==========

fly -t cisco-fso-labs set-team --team-name cisco-fso-labs --local-user us-west-1a -c roles/owner.yml
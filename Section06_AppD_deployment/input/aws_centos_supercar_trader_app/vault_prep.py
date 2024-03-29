#!/usr/bin/env python
import json, re, sys, os, json, time, logging, requests, urllib3
urllib3.disable_warnings()
from requests.structures import CaseInsensitiveDict
import subprocess
from subprocess import call, check_output

VAULT_ADDR = os.getenv('VAULT_ADDRR')
VAULT_TOKEN = os.getenv('SSH_TOKEN')
NAME = os.getenv('NAME')

#Write the lab vars to the vault under the name which is the az name

url = "http://dev-vault.ciscolivedemo2022.com:8200/v1/concourse/main/" + name + "/" + "region"

headers = CaseInsensitiveDict()
headers["X-Vault-Token"] = VAULT_TOKEN
headers["Content-Type"] = "application/json"

#data = f'{{"token": "{TOKEN}"}}'
data_json = {"region": region }

resp = requests.post(url, headers=headers, json=data_json)
print(resp.status_code)


url = "http://dev-vault.ciscolivedemo2022.com:8200/v1/concourse/main/" + name + "/" + "az"

headers = CaseInsensitiveDict()
headers["X-Vault-Token"] = VAULT_TOKEN
headers["Content-Type"] = "application/json"

#data = f'{{"token": "{TOKEN}"}}'
data_json = {"az": az }

resp = requests.post(url, headers=headers, json=data_json)
print(resp.status_code)

url = "http://dev-vault.ciscolivedemo2022.com:8200/v1/concourse/main/" + name + "/" + "centos_ami_id"

headers = CaseInsensitiveDict()
headers["X-Vault-Token"] = VAULT_TOKEN
headers["Content-Type"] = "application/json"

#data = f'{{"token": "{TOKEN}"}}'
data_json = {"centos_ami_id": centos_ami_id }

resp = requests.post(url, headers=headers, json=data_json)
print(resp.status_code)

url = "http://dev-vault.ciscolivedemo2022.com:8200/v1/concourse/main/" + name + "/" + "centos_ami_id"

headers = CaseInsensitiveDict()
headers["X-Vault-Token"] = VAULT_TOKEN
headers["Content-Type"] = "application/json"

#data = f'{{"token": "{TOKEN}"}}'
data_json = {"centos_ami_id": centos_ami_id }

resp = requests.post(url, headers=headers, json=data_json)
print(resp.status_code)

url = "http://dev-vault.ciscolivedemo2022.com:8200/v1/concourse/main/" + name + "/" + "vault_addr"

headers = CaseInsensitiveDict()
headers["X-Vault-Token"] = VAULT_TOKEN
headers["Content-Type"] = "application/json"

#data = f'{{"token": "{TOKEN}"}}'
data_json = {"vaut_addr": vault_addr }

resp = requests.post(url, headers=headers, json=data_json)
print(resp.status_code)

url = "http://dev-vault.ciscolivedemo2022.com:8200/v1/concourse/main/" + name + "/" + "name"

headers = CaseInsensitiveDict()
headers["X-Vault-Token"] = VAULT_TOKEN
headers["Content-Type"] = "application/json"

#data = f'{{"token": "{TOKEN}"}}'
data_json = {"name": name}

resp = requests.post(url, headers=headers, json=data_json)
print(resp.status_code)
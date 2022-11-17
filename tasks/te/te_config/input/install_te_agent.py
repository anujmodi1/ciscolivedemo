#!/usr/bin/env python
import json, re, sys, os, json, subprocess, time, logging, requests, paramiko
from subprocess import call, check_output
from requests.structures import CaseInsensitiveDict

os.environ.get('ip')
print(ip)
ip=ip
subprocess.call(['bash','./install-script.sh',ip])
import userinfo
import json
import requests

request = requests.get('http://api.open-notify.org')
print(request.text)
import requests
import json
from dotenv import load_dotenv
import os

load_dotenv()
API_KEY = os.getenv('VT_API_KEY')
HEADERS = {'x-apikey': API_KEY}
# - API Key in .env file

def save_to_file(data, label):
    filename = f'virustotal_results_{label}.json'
    with open(filename, 'w') as f:
        json.dump(data, f, indent=2)
    print(f"✅ Results saved to {filename}")

def get_ip_info(ip):
    url = f'https://www.virustotal.com/api/v3/ip_addresses/{ip}'
    response = requests.get(url, headers=HEADERS)
    data = response.json()
    save_to_file(data, ip)
    return data

def get_domain_info(domain):
    url = f'https://www.virustotal.com/api/v3/domains/{domain}'
    response = requests.get(url, headers=HEADERS)
    data = response.json()
    save_to_file(data, domain)
    return data

def get_file_info(file_id):
    url = f'https://www.virustotal.com/api/v3/files/{file_id}'
    response = requests.get(url, headers=HEADERS)
    data = response.json()
    save_to_file(data, file_id)
    return data

def get_file_behavior(file_id):
    url = f'https://www.virustotal.com/api/v3/files/{file_id}/behaviour_summary'
    response = requests.get(url, headers=HEADERS)
    data = response.json()
    save_to_file(data, f"{file_id}_behavior")
    return data

def submit_url(url_to_scan):
    url = 'https://www.virustotal.com/api/v3/urls'
    data = {'url': url_to_scan}
    response = requests.post(url, headers=HEADERS, data=data)
    result = response.json()
    save_to_file(result, f"{url_to_scan.replace('://','_').replace('/','_')}_submit")
    return result

def get_url_report(scan_id):
    url = f'https://www.virustotal.com/api/v3/urls/{scan_id}'
    response = requests.get(url, headers=HEADERS)
    data = response.json()
    save_to_file(data, f"{scan_id}_report")
    return data

# Example usage
if __name__ == '__main__':
    # ip = '103.27.186.11'
    # # domain = 'example.com'
    file_id = '4c7dab2b02e95713227c4d42a450fb49611abc565f18fd986b80bd4f9c83d693'
    # # url_to_scan = 'http://example.com'

    # get_ip_info(ip)
    # get_domain_info(domain)
    get_file_info(file_id)
    get_file_behavior(file_id)

    # url_response = submit_url(url_to_scan)
    # scan_id = url_response['data']['id']
    # get_url_report(scan_id)
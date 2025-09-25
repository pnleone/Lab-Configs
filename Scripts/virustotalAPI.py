import requests
from dotenv import load_dotenv
import os

load_dotenv()
API_KEY = os.getenv('VT_API_KEY')
HEADERS = {'x-apikey': API_KEY}
# - API Key in .env file
# - For file lookups, use a known hash (MD5, SHA1, or SHA256).
# - For URLs, the submit_url function returns a scan ID which you then use to retrieve the report.



def get_ip_info(ip):
    url = f'https://www.virustotal.com/api/v3/ip_addresses/{ip}'
    response = requests.get(url, headers=HEADERS)
    return response.json()

def get_domain_info(domain):
    url = f'https://www.virustotal.com/api/v3/domains/{domain}'
    response = requests.get(url, headers=HEADERS)
    return response.json()

def get_file_info(file_id):
    url = f'https://www.virustotal.com/api/v3/files/{file_id}'
    response = requests.get(url, headers=HEADERS)
    return response.json()

def get_file_behavior(file_id):
    url = f'https://www.virustotal.com/api/v3/files/{file_id}/behaviour_summary'
    response = requests.get(url, headers=HEADERS)
    return response.json()

def submit_url(url_to_scan):
    url = 'https://www.virustotal.com/api/v3/urls'
    data = {'url': url_to_scan}
    response = requests.post(url, headers=HEADERS, data=data)
    return response.json()

def get_url_report(scan_id):
    url = f'https://www.virustotal.com/api/v3/urls/{scan_id}'
    response = requests.get(url, headers=HEADERS)
    return response.json()

# Example usage
if __name__ == '__main__':
    ip = '44.9.148.120'
#     domain = 'example.com'
#     file_id = '44d88612fea8a8f36de82e1278abb02f'  # MD5 or SHA256
#     url_to_scan = 'http://example.com'

    print("🔍 IP Info:", get_ip_info(ip))
#     print("🌐 Domain Info:", get_domain_info(domain))
#     print("📦 File Info:", get_file_info(file_id))
#     print("🧠 File Behavior:", get_file_behavior(file_id))

#     url_response = submit_url(url_to_scan)
#     scan_id = url_response['data']['id']
#     print("🔗 URL Report:", get_url_report(scan_id))
{
  "subject": {
    "commonName": {{ toJson .Subject.CommonName }},
    "organization": "Homelab",
    "organizationalUnit": "DevSecOps",
    "country": "US",
    "locality": "Yorktown Heights",
    "province": "New York"
  },
  "sans": {{ toJson .SANs }},
  "keyUsage": [
    "digitalSignature",
    "keyEncipherment"
  ],
  "extKeyUsage": [
    "serverAuth",
    "clientAuth"
  ],
  "key": {
    "kty": "EC",
    "crv": "P-256"
  }
}
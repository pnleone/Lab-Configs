{
  "subject": {
    "commonName": {{ toJson .Insecure.CR.Subject.CommonName }}
  },
  "sans": {{ toJson .Insecure.CR.DNSNames }},
  "keyUsage": ["digitalSignature", "keyEncipherment"],
  "extKeyUsage": ["serverAuth", "clientAuth"],
  "notBefore": "0s",
  "notAfter": "720h"
}

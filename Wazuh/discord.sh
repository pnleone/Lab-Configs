#!/bin/bash
WEBHOOK_URL="https://discord.com/api/webhooks/1418221255097847818/ip7ue9i1hcFAU_DmDX-2fyHcIJ0zVH4u3eAdswwo8OObfEpAmrz3PVXgEYawbbAfkoaN"

 # Arguments passed from Wazuh active response
 ALERT_JSON=$(cat)

 # Extract useful fields from the alert JSON
 RULE_NAME=$(echo "$ALERT_JSON" | jq -r '.rule.description')
 RULE_GROUP=$(echo "$ALERT_JSON" | jq -r '.rule.groups[0]')
 HOSTNAME=$(echo "$ALERT_JSON" | jq -r '.agent.name')

 # Build Discord webhook payload

 PAYLOAD=$(jq -n \
   --arg rule "$RULE_NAME" \
   --arg group "$RULE_GROUP" \
   --arg host "$HOSTNAME" \
   '{
     "username": "Wazuh Alert",
     "embeds": [
       {
         "title": "🚨 Wazuh Active Response Triggered",
         "fields": [
           {"name": "Rule", "value": $rule, "inline": true},
           {"name": "Group", "value": $group, "inline": true},
           {"name": "Host", "value": $host, "inline": true}
         ],
         "color": 15158332
       }
     ]
   }')

 # Send to Discord
 curl -H "Content-Type: application/json" -d "$PAYLOAD" "$WEBHOOK_URL"
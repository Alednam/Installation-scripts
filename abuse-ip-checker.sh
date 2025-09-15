#!/bin/bash
API_KEY="PUTINDERA_API_KEY"
INPUT_FILE="ipsmal.txt"
OUTPUT_FILE="abuse_report_detailed_nssf_mal_2025.txt"

# Create a formatted header for the output file
echo -e "IP Address\tAbuse Score\tTotal Reports\tLast Reported\tReporter\tComments\tCategories" > $OUTPUT_FILE
echo -e "------------------------------------------------------------------------------------------------------------" >
while read ip; do
      echo "Checking $ip..."
    response=$(curl -s -G https://api.abuseipdb.com/api/v2/check \
        --data-urlencode "ipAddress=$ip" \
        -d maxAgeInDays=90 \
        -H "Key: $API_KEY" \
        -H "Accept: application/json")

    abuse_score=$(echo $response | jq '.data.abuseConfidenceScore // 0')
    total_reports=$(echo $response | jq '.data.totalReports // 0')
    last_reported=$(echo $response | jq -r '.data.lastReportedAt // "N/A"')
#    reporter=$(echo $response | jq -r '.data.reports[0].reportedBy // "Anonymous"')
#    comments=$(echo $response | jq -r '.data.reports[0].comment // "N/A"')
#    categories=$(echo $response | jq -r '.data.reports[0].categories[] // "Unknown"' | paste -sd "," -)
    country_code=$(echo $response | jq -r '.data.countryCode // "N/A"')
    domain=$(echo $response | jq -r '.data.domain // "N/A"')

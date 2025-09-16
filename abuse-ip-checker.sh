#!/bin/bash
API_KEY="PUTINDERA_API_KEY"
INPUT_FILE="ipsmal.txt"
OUTPUT_FILE="abuse_report_detailed_nssf_mal_2025.txt"

# Create a formatted header for the output file
echo -e "IP Address\tAbuse Score\tTotal Reports\tLast Reported\tReporter\tComments\tcountry_code\tdomain\tCategories" > $OUTPUT_FILE
echo -e "------------------------------------------------------------------------------------------------------------" >> $OUTPUT_FILE

while read ip; do
    echo "Checking $ip..."
    # Query AbuseIPDB API
    response=$(curl -s -G https://api.abuseipdb.com/api/v2/check \
        --data-urlencode "ipAddress=$ip" \
        -d maxAgeInDays=90 \
        -H "Key: $API_KEY" \
        -H "Accept: application/json")

    # Handling null values safely with default fallbacks
    abuse_score=$(echo $response | jq '.data.abuseConfidenceScore // 0')
    total_reports=$(echo $response | jq '.data.totalReports // 0')
    last_reported=$(echo $response | jq -r '.data.lastReportedAt // "N/A"')
   # reporter=$(echo $response | jq -r '.data.reports[0].reportedBy // "Anonymous"')
   # comments=$(echo $response | jq -r '.data.reports[0].comment // "N/A"')
    country_code=$(echo $response | jq -r '.data.countryCode // "N/A"')
    domain=$(echo $response | jq -r '.data.domain // "N/A"')
   # categories=$(echo $response | jq -r '.data.reports[0].categories[] // "Unknown"' | paste -sd "," -)

    # Append the formatted output to the file
    echo -e "$ip\t$abuse_score\t$total_reports\t$last_reported\t$reporter\t$comments\t$country_code\t$domain\t$categories" >> $OUTPUT_FILE
done < $INPUT_FILE

echo "Detailed abuse report saved to $OUTPUT_FILE"

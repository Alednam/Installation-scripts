How to Run WAZUH install script

Copy the script into your VM:

nano install_wazuh.sh


(paste everything inside, then save with CTRL+O, CTRL+X).

Make it executable:

chmod +x install_wazuh.sh


Run it:

sudo ./install_wazuh.sh


Once done, access Wazuh in your browser:
👉 https://

Use the credentials printed at the end (admin / <password>).

What’s New

Auto-detects VM IP → no need to hardcode 10.0.2.15, it prints whatever IP the VM got (hostname -I | awk '{print $1}').

Optional AWS ingestion setup → during install, script asks if you want to configure CloudWatch + GuardDuty right away.

If yes, it appends the proper <wodle> configs into ossec.conf.

If no, you can set it up later manually.

Credentials auto-print → shows where the admin password is stored.

⚠️ Before Running

Make sure the VM has internet access.

For AWS ingestion, the VM must have either:

An IAM role with logs:GetLogEvents + s3:GetObject access, or

AWS credentials in /var/ossec/.aws/credentials.

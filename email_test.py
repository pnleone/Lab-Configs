import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# SMTP relay details
smtp_server = "192.168.200.38"
smtp_port = 25

# Email addresses
from_addr = "pnleone17@gmail.com"
to_addr = "pnleone17@gmail.com"

# Create the message container
msg = MIMEMultipart("alternative")
msg["From"] = from_addr
msg["To"] = to_addr
msg["Subject"] = "Homelab: active-response notification"

# Plain text fallback
text_body = "This is a test email from the Security Operations Center."

# HTML body with images
html_body = """
<html>
  <head></head>
  <body style="font-family: Arial, sans-serif; color: #333;">
    <h2 style="color: #2E86C1;">Security Operations Center Alert</h2>

    <p><b>From:</b> Paul Leone, SOC Analyst</p>
    <p><b>To:</b> Security Team</p>
    <p><b>Subject:</b> SSH scan from 139.182.45.23</p>

    <hr/>

    <h3>Summary</h3>
    <p>139.182.45.23 initiated an SSH scan targeting nearly 18,000 university addresses this morning.</p>

    <h3>Details</h3>
    <ul>
      <li><b>Timestamp:</b> 2025-12-04 08:15 EST</li>
      <li><b>Activity:</b> Multiple failed SSH login attempts detected across 12 hosts.</li>
      <li><b>Log excerpt:</b> <code>sshd[2456]: Failed password for root from 139.182.45.23 port 51432</code></li>
    </ul>

    <h3>Action</h3>
    <p>
      Firewall rule implemented to block traffic from 139.182.45.23.<br/>
      User accounts reviewed for compromise.<br/>
      Recommended: Continue monitoring for related activity and update IOC blocklists.
    </p>

    <hr/>
    <p style="font-size: 12px; color: #888;">-- End of alert --</p>
  </body>
 <img src="https://cyberhoot.com/wp-content/uploads/2019/12/image-2-1024x382.png" alt="SOC Test Image" />   
    
    <p style="font-size: 12px; color: #888;">-- End of message --</p>
 
</html>
"""

# Attach both plain text and HTML
msg.attach(MIMEText(text_body, "plain"))
msg.attach(MIMEText(html_body, "html"))

# Send the email
try:
    with smtplib.SMTP(smtp_server, smtp_port) as server:
        server.set_debuglevel(1)  # show SMTP conversation
        server.sendmail(from_addr, [to_addr], msg.as_string())
    print("Email sent successfully.")
except Exception as e:
    print(f"Failed to send email: {e}")

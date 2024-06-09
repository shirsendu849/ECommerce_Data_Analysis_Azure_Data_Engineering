import requests
import json

# Replace these variables with your details
databricks_instance = ""
token = ""
job_id = ""

# Headers for authentication
headers = {
    "Authorization": f"Bearer {token}",
    "Content-Type": "application/json"
}

# API endpoint to run a job
run_job_url = f"{databricks_instance}/api/2.1/jobs/run-now"

# Payload with the job ID
payload = {
    "job_id": job_id
}

# Make the API request to run the job
response = requests.post(run_job_url, headers=headers, data=json.dumps(payload))

# Check the response
if response.status_code == 200:
    print("Job triggered successfully.")
    print("Response:", response.json())
else:
    print("Failed to trigger job.")
    print("Status Code:", response.status_code)
    print("Response:", response.text)
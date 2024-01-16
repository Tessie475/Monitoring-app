import google.auth
from google.cloud import monitoring_v3
import base64
import datetime

# Use the default credentials
credentials, _ = google.auth.default()

# Create a Monitoring client
client = monitoring_v3.MetricServiceClient(credentials=credentials)

# Define the project ID
project_id = "learning-397907"

def auto_scale_function(event, context):
    # Handle Pub/Sub message and extract information
    pubsub_message = event["data"]

    try:
        # Decode the base64-encoded message and convert it to an integer
        decoded_message = base64.b64decode(pubsub_message).decode("utf-8")
        num_user_visits = int(decoded_message)
    except (ValueError, UnicodeDecodeError) as e:
        # Handle the case where decoding or conversion to integer fails
        print(f"Error processing message: {e}")
        return

    # Log the number of user visits
    print(f"Number of user visits: {num_user_visits}")

    # Log the autoscaling decision based on the number of user visits
    if num_user_visits > 5:
        print(f"Auto-scaling triggered: {num_user_visits}")
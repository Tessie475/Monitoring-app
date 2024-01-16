import os
import time
from google.cloud import pubsub_v1

project_id = "learning-397907"
topic_name = "user-visits-topic"

# Create a Publisher client
publisher = pubsub_v1.PublisherClient()

def publish_message(message):
    topic_path = publisher.topic_path(project_id, topic_name)

    # Publish a message to the Pub/Sub topic
    future = publisher.publish(topic_path, str(message).encode("utf-8"))
    print(f"Published message: {message}")

# Run a loop that iterates 10 times
def run_loop():
    for i in range(1, 11):
        publish_message(f"{i}")
        time.sleep(1)  # Pause for 1 second

if __name__ == "__main__":
    run_loop()

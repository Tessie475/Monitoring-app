# Monitoring Application Documentation

## Overview

This documentation provides detailed information on deploying and managing the monitoring application, including infrastructure setup, deployment of Cloud Function, and simulation of user visits to trigger autoscaling.

## Table of Contents

1. [Cloud Platform Deployment](#1-cloud-platform-deployment)
2. [Infrastructure as Code (IaC)](#2-infrastructure-as-code-iac)
3. [Cloud Function Deployment](#3-cloud-function-deployment)
4. [User Visit Simulation](#4-user-visit-simulation)
5. [Requirements](#5-requirements)
6. [Usage Guide](#6-usage-guide)
7. [Contribution Guidelines](#7-contribution-guidelines)

---

## 1. Cloud Platform Deployment

In deploying this application, Google Cloud Platform (GCP) is the chosen cloud platform. Before proceeding, ensure that you have a valid GCP account and the necessary credentials configured.

### Terraform Setup

1. Install Terraform.
2. Navigate to the directory containing the Terraform script (`main.tf`).
3. Run `terraform init` to initialize the project.
4. Run `terraform apply` to create the necessary resources.

### Ansible Setup

1. Ensure Ansible is installed.
2. Run the Ansible playbook (`ansible-cloud-function.yml`) for deploying the Cloud Function.

---

## 2. Infrastructure as Code (IaC)

Infrastructure is provisioned using Terraform. The script (`main.tf`) sets up the following:

- Google Cloud Storage bucket
- Pub/Sub topic for user visits
- Metric descriptor for Cloud Function execution count
- Email notification channel
- Monitoring alert policy based on execution count

---

## 3. Cloud Function Deployment

Ansible is used for Cloud Function deployment. The playbook (`ansible-cloud-function.yml`) installs required Python libraries and deploys the Cloud Function with specific configurations. The function is packaged into a zip file and uploaded to the cloud storage bucket created using terraform. Run this command to deploy the Cloud Function:

```bash
ansible-playbook -i localhost, cloud_function_deployment.yaml
```

## 4. User Visit Simulation

The Python script (`simulate_user_visits.py`) simulates user visits to trigger the Cloud Function. Modify the `project_id` and `topic_name` variables as needed.

Run the script using this command:

```bash
python simulate_user_visits.py
```

to simulate user visits and publish messages to the Pub/Sub topic.

---

## 5. Requirements

Ensure the required Python libraries are installed. You can use the provided `requirements.txt` file:

```plaintext
# requirements.txt
google-auth
google-cloud
google-cloud-monitoring
google-cloud-logging
google-cloud-pubsub
```

---

## 6. Usage Guide

After the infrastructure is deployed and the resources are provisioned, the user should run the script `simulate_user_visits.py` to publish a message to Pub/Sub. This Pub/Sub message triggers the Cloud Function, which is being monitored. A threshold and duration are defined in the Terraform script, and if this threshold is crossed, a notification is sent to the provided channel.

## 7. Contribution Guidelines

Contributions to the monitoring application are welcome. Follow these guidelines:

1. Fork the repository.
2. Create a new branch for your changes.
3. Make your changes and test thoroughly.
4. Submit a pull request with a detailed description of the changes.

---

Feel free to modify this documentation according to your specific needs. If you encounter any issues or have questions, refer to the provided scripts and resources or reach out to the project maintainers.
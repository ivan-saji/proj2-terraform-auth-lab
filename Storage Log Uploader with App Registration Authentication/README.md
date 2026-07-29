# Azure Storage Log Uploader using Service Principal Authentication

## Overview

This project demonstrates how to securely upload application logs from an Azure Linux Virtual Machine to Azure Blob Storage using **Azure Service Principal Authentication**.

The entire Azure infrastructure is provisioned using **Terraform**, while the application is developed in **Python**. Authentication is performed using an Azure App Registration, Service Principal, Azure Key Vault, and Azure Role-Based Access Control (RBAC).

This implementation represents the traditional enterprise approach where applications authenticate using a Service Principal and retrieve secrets from Azure Key Vault.

---

# Project Objectives

* Provision Azure infrastructure using Terraform
* Create Azure App Registration automatically
* Create Azure Service Principal automatically
* Generate Client Secret automatically
* Store Storage Account Connection String securely in Azure Key Vault
* Generate logs using Python
* Authenticate securely with Azure
* Retrieve secrets from Azure Key Vault
* Upload logs to Azure Blob Storage
* Automate VM bootstrap using cloud-init
* Schedule log uploads using systemd timers

---

# Architecture

```text
                           Terraform
                                │
                                ▼
                 ┌──────────────────────────────┐
                 │ Azure Resource Group         │
                 └──────────────────────────────┘
                                │
          ┌─────────────────────┼──────────────────────┐
          ▼                     ▼                      ▼
 Azure Storage Account     Azure Key Vault      Linux Virtual Machine
          │                     ▲                      │
          │                     │                      │
          │              Stores Connection String      │
          │                     │                      │
          │              Azure RBAC                    │
          │                     ▲                      │
          │                     │                      ▼
          │              Service Principal      Python Application
          │                     ▲                      │
          │                     │                      ▼
          └────────────── Azure Active Directory ──────┘
```

---

# Infrastructure Provisioned

Terraform provisions the following Azure resources:

## Core Infrastructure

* Azure Resource Group
* Azure Virtual Network
* Azure Subnet
* Azure Network Interface
* Azure Linux Virtual Machine

## Storage

* Azure Storage Account
* Azure Blob Container

## Identity

* Azure App Registration
* Azure Service Principal
* Azure Service Principal Client Secret

## Secrets

* Azure Key Vault
* Storage Connection String Secret

## Authorization

Azure RBAC Role Assignments

* Storage Account Contributor
* Key Vault Administrator
* Key Vault Secrets User

---

# Authentication Flow

The authentication process follows these steps:

```text
Python Application
        │
        ▼
Read Client ID
Read Client Secret
Read Tenant ID
        │
        ▼
Authenticate with Azure AD
        │
        ▼
Receive Access Token
        │
        ▼
Access Azure Key Vault
        │
        ▼
Read Storage Connection String
        │
        ▼
Connect to Azure Blob Storage
        │
        ▼
Upload Log File
```

---

# Security Design

Sensitive information is never hardcoded inside the application.

Instead:

* Azure App Registration is created using Terraform.
* Azure Service Principal is created automatically.
* Client Secret is generated automatically.
* Storage Account Connection String is stored securely in Azure Key Vault.
* Python authenticates using Azure Active Directory.
* The connection string is retrieved only at runtime.

---

# Linux Automation

The Linux Virtual Machine is configured automatically using **cloud-init**.

During deployment:

* Python is installed
* pip is installed
* Azure SDK dependencies are installed
* Python scripts are copied
* Configuration files are copied
* systemd service is created
* systemd timer is created
* Timer is enabled

No manual VM configuration is required.

---

# Log Generation

The application generates log files locally using the following naming convention:

```text
hostname_log_DDMMYYYY_HHMMSS.log
```

Example:

```text
vm01_log_22072026_153000.log
```

Logs are stored locally before being uploaded to Azure Blob Storage.

---

# Automatic Log Upload

The project uses **systemd timers** instead of cron jobs.

Every five minutes:

1. Generate log
2. Authenticate with Azure AD
3. Read Storage Connection String from Key Vault
4. Upload log to Azure Blob Storage

This simulates a production-style background service.

---

# Project Structure

```text
Service-Principal/

│
├── terraform/
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── app_registration.tf
│   ├── keyvault.tf
│   ├── keyvault_secret.tf
│   ├── storage.tf
│   ├── network.tf
│   ├── linux_vm.tf
│   ├── rbac.tf
│   └── cloud_init.tftpl
│
├── scripts/
│   ├── upload_logs.py
│   ├── config.py
│   ├── requirements.txt
│   └── logs/
│
└── README.md
```

---

# Technologies Used

## Infrastructure

* Terraform
* AzureRM Provider
* AzureAD Provider

## Azure Services

* Azure Resource Group
* Azure Storage Account
* Azure Blob Storage
* Azure Linux Virtual Machine
* Azure App Registration
* Azure Service Principal
* Azure Key Vault
* Azure RBAC

## Programming

* Python
* Azure Identity SDK
* Azure Key Vault SDK
* Azure Storage Blob SDK

## Linux

* Ubuntu Server
* cloud-init
* systemd
* systemd Timer

---

# Skills Demonstrated

* Infrastructure as Code
* Azure Identity Management
* Azure App Registration
* Azure Service Principal
* Azure Key Vault
* Azure RBAC
* Azure Storage
* Azure Virtual Machines
* Secure Secret Management
* Python Automation
* Linux Administration
* cloud-init
* systemd
* Production Infrastructure Design

---

# Challenges Encountered

During implementation, several real-world Azure scenarios were encountered and resolved:

* Azure RBAC propagation delays
* Key Vault authorization (403 Forbidden)
* Terraform state backend locking
* Blob Storage authentication
* Service Principal permission configuration
* cloud-init troubleshooting
* Python dependency installation on Linux
* systemd service debugging

These issues provided valuable hands-on experience with Azure administration and troubleshooting.

---

# Limitations of Service Principal Authentication

Although this implementation is secure, it still relies on long-lived credentials.

It requires:

* Client ID
* Client Secret
* Tenant ID
* Secret rotation
* Credential management

Modern Azure workloads increasingly avoid these requirements by using **Managed Identity**, which eliminates credentials entirely.

---

# Next Evolution

A second implementation of this project demonstrates the same functionality using **Azure Managed Identity**, removing the need for:

* Azure App Registration
* Service Principal
* Client Secret
* Storage Connection String
* Credential management

See:

```text
../Managed-Identity/README.md
```

---

# Conclusion

This project demonstrates a complete production-style Azure authentication workflow using Service Principal authentication.

It showcases Infrastructure as Code, secure secret management through Azure Key Vault, Linux automation, Python integration with Azure SDKs, and automated log uploads to Azure Blob Storage.

It also serves as the foundation for understanding why Azure Managed Identity has become the recommended authentication mechanism for Azure-hosted applications.

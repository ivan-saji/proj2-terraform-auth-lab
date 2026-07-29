# Azure Storage Log Uploader using Managed Identity Authentication

## Overview

This project demonstrates how to securely upload application logs from an Azure Linux Virtual Machine to Azure Blob Storage using **Azure Managed Identity**.

The complete infrastructure is provisioned using **Terraform**, while the application is developed in **Python**. Unlike the Service Principal implementation, this solution uses **System Assigned Managed Identity**, eliminating the need for client secrets, connection strings, Azure Key Vault, or any credentials inside the application.

This represents Microsoft's recommended authentication approach for Azure-hosted workloads.

---

# Project Objectives

* Provision Azure infrastructure using Terraform
* Enable System Assigned Managed Identity on the Virtual Machine
* Authenticate securely without credentials
* Upload logs directly to Azure Blob Storage
* Implement Azure Role-Based Access Control (RBAC)
* Automate VM provisioning using cloud-init
* Schedule automatic log uploads using systemd timers
* Demonstrate a secretless authentication architecture

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
          ┌─────────────────────┴─────────────────────┐
          ▼                                           ▼
 Azure Storage Account                        Linux Virtual Machine
          │                                           │
          │                                           │
          ▼                                           ▼
 Blob Storage Container                  System Assigned Managed Identity
                                                      │
                                                      ▼
                                            Azure Active Directory
                                                      │
                                                      ▼
                                                 Azure RBAC
                                                      │
                                                      ▼
                                             Python Application
                                                      │
                                                      ▼
                                            Upload Log to Storage
```

---

# Infrastructure Provisioned

Terraform provisions the following Azure resources.

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

* System Assigned Managed Identity

## Authorization

Azure RBAC Role Assignments

* Storage Blob Data Contributor (Managed Identity)

---

# Authentication Flow

Unlike traditional authentication methods, no credentials are stored anywhere.

Authentication flow:

```text
Python Application
        │
        ▼
ManagedIdentityCredential()
        │
        ▼
Request Access Token
        │
        ▼
Azure Active Directory
        │
        ▼
Azure RBAC Authorization
        │
        ▼
Azure Blob Storage
        │
        ▼
Upload Log File
```

The Azure SDK automatically requests an OAuth access token using the VM's Managed Identity.

---

# Security Design

This implementation follows Microsoft's recommended security practices.

There are **no credentials stored inside the application**.

No:

* Client ID
* Client Secret
* Tenant ID
* Storage Connection String
* Azure Key Vault
* Passwords

Authentication is completely handled by Azure.

Authorization is enforced through Azure RBAC.

---

# Managed Identity

The Linux Virtual Machine is configured with a **System Assigned Managed Identity**.

Terraform enables the identity during VM creation:

```hcl
identity {
  type = "SystemAssigned"
}
```

Azure automatically:

* Creates the identity
* Registers it in Azure AD
* Manages token issuance
* Rotates credentials
* Deletes the identity when the VM is deleted

No manual identity management is required.

---

# Linux Automation

The Virtual Machine is fully configured using **cloud-init**.

During deployment:

* Python is installed
* pip is installed
* Azure SDK dependencies are installed
* Python scripts are copied
* Configuration files are copied
* systemd service is created
* systemd timer is created
* Timer is enabled

The VM is ready immediately after deployment.

---

# Log Generation

The application generates log files using the following naming convention:

```text
hostname_log_DDMMYYYY_HHMMSS.log
```

Example:

```text
vm01_log_22072026_153000.log
```

Each execution creates a uniquely named log file before uploading it to Azure Blob Storage.

---

# Automatic Log Upload

The project uses **systemd timers** instead of cron jobs.

Every five minutes:

1. Generate a log file
2. Authenticate using Managed Identity
3. Obtain an Azure AD access token
4. Connect to Azure Blob Storage
5. Upload the log file

No manual intervention is required.

---

# Project Structure

```text
Managed-Identity/

│
├── terraform/
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
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

## Azure Services

* Azure Resource Group
* Azure Storage Account
* Azure Blob Storage
* Azure Linux Virtual Machine
* Azure Managed Identity
* Azure RBAC

## Programming

* Python
* Azure Identity SDK
* Azure Storage Blob SDK

## Linux

* Ubuntu Server
* cloud-init
* systemd
* systemd Timer

---

# Skills Demonstrated

* Infrastructure as Code
* Azure Managed Identity
* Azure RBAC
* Azure Storage
* Azure Virtual Machines
* Secure Authentication
* Secretless Architecture
* Python Automation
* Linux Administration
* cloud-init
* systemd
* Production Infrastructure Design

---

# Benefits of Managed Identity

Compared to Service Principal authentication, Managed Identity provides significant security and operational improvements.

| Service Principal            | Managed Identity       |
| ---------------------------- | ---------------------- |
| Requires Client Secret       | No Client Secret       |
| Requires Secret Rotation     | Automatic              |
| Requires App Registration    | Not Required           |
| Requires Connection String   | Not Required           |
| Requires Key Vault           | Not Required           |
| Credentials stored somewhere | No credentials stored  |
| Manual identity lifecycle    | Fully managed by Azure |

---

# Challenges Encountered

During implementation, several real-world Azure scenarios were encountered and resolved:

* Azure RBAC propagation delays
* Storage Blob authorization failures (403 Forbidden)
* Managed Identity configuration
* cloud-init troubleshooting
* Python dependency installation
* systemd service debugging
* Terraform state management

These scenarios closely resemble issues encountered in production Azure environments.

---

# Why Managed Identity?

The goal of this implementation was to eliminate every secret from the application.

Instead of authenticating with credentials, the Virtual Machine itself becomes the identity.

Benefits include:

* Improved security
* Simplified operations
* Automatic credential rotation
* Reduced attack surface
* No secret management
* Azure-native authentication

This is the recommended authentication mechanism for applications running on Azure Virtual Machines, Azure App Services, Azure Functions, Azure Kubernetes Service (AKS), and other Azure-hosted services.

---

# Conclusion

This project demonstrates a complete production-style Azure solution using **Managed Identity** for authentication.

It showcases Infrastructure as Code, Linux automation, Azure RBAC, Python integration with Azure SDKs, and secure secretless authentication for uploading application logs to Azure Blob Storage.

By eliminating all credentials from the application, this implementation follows modern Azure security best practices and represents the preferred authentication model for cloud-native applications.

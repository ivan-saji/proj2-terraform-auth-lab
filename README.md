# Azure Storage Log Uploader using Terraform

## Overview

This repository demonstrates two secure approaches for uploading application logs from an Azure Linux Virtual Machine to Azure Blob Storage using Terraform and Python.

The project was built as a learning journey to understand Azure authentication mechanisms, Infrastructure as Code, Linux automation, and secure cloud-native application design.

Rather than presenting only the final solution, this repository preserves the evolution from **Service Principal authentication** to **Managed Identity authentication**, allowing readers to compare both implementations.

---

# Project Objectives

* Provision Azure infrastructure using Terraform
* Generate application logs using Python
* Upload logs automatically to Azure Blob Storage
* Automate VM configuration using cloud-init
* Schedule log uploads using systemd timers
* Implement secure Azure authentication
* Understand the evolution of Azure authentication methods

---

# Repository Structure

```text
Azure-Storage-Log-Uploader/

│
├── README.md
│
├── Service-Principal/
│   ├── terraform/
│   ├── scripts/
│   └── README.md
│
└── Managed-Identity/
    ├── terraform/
    ├── scripts/
    └── README.md
```

---

# Infrastructure

Both implementations provision similar Azure infrastructure using Terraform.

Resources created include:

* Azure Resource Group
* Azure Virtual Network
* Subnet
* Network Interface
* Linux Virtual Machine
* Azure Storage Account
* Azure Blob Container
* Role Assignments (RBAC)

Additional resources vary depending on the authentication method.

---

# Authentication Implementations

## 1. Service Principal Authentication

This implementation authenticates using an Azure App Registration and Service Principal.

Flow:

```text
Python
    │
    ▼
Client ID
Client Secret
Tenant ID
    │
    ▼
Azure Active Directory
    │
    ▼
Azure Key Vault
    │
    ▼
Storage Connection String
    │
    ▼
Azure Blob Storage
```

Resources created:

* Azure App Registration
* Azure Service Principal
* Client Secret
* Azure Key Vault
* Key Vault Secret
* RBAC Assignments

This approach demonstrates how applications traditionally authenticate with Azure services.

See:

```text
Service-Principal/README.md
```

---

## 2. Managed Identity Authentication

This implementation removes all credentials and uses Azure Managed Identity.

Flow:

```text
Linux VM
      │
      ▼
Managed Identity
      │
      ▼
Azure Active Directory
      │
      ▼
Azure RBAC
      │
      ▼
Azure Blob Storage
```

Resources created:

* System Assigned Managed Identity
* Azure RBAC Role Assignments

No App Registration.

No Client Secret.

No Connection String.

No credentials stored inside the application.

This represents Microsoft's recommended authentication approach for Azure-hosted workloads.

See:

```text
Managed-Identity/README.md
```

---

# Features

* Infrastructure as Code using Terraform
* Azure Linux Virtual Machine deployment
* Azure Storage Account deployment
* Python log generation
* Automatic log upload
* cloud-init bootstrapping
* systemd Service
* systemd Timer
* Azure RBAC
* Secure authentication
* Production-style architecture

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
* Azure Virtual Machine
* Azure Key Vault
* Azure Managed Identity
* Azure RBAC

## Programming

* Python
* Azure SDK for Python

## Linux

* Ubuntu Server
* cloud-init
* systemd
* systemd Timer

---

# Learning Outcomes

This project demonstrates practical experience with:

* Terraform
* Infrastructure as Code
* Azure Storage
* Azure Virtual Machines
* Azure Identity
* Azure RBAC
* Azure Key Vault
* Azure Managed Identity
* Python Automation
* Linux Administration
* cloud-init
* systemd
* Secure Authentication
* Cloud Security Best Practices

---

# Authentication Evolution

This repository intentionally preserves both authentication methods to demonstrate the migration path from traditional secret-based authentication to modern secretless authentication.

```text
Storage Connection String
            │
            ▼
Azure Key Vault
            │
            ▼
Service Principal
            │
            ▼
Managed Identity
```

Each implementation solves the same business problem while improving security and reducing credential management.

---

# Future Enhancements

Potential improvements include:

* Log rotation
* Log compression
* Azure Monitor integration
* Log Analytics Workspace
* Azure Monitor Agent
* GitHub Actions CI/CD
* Azure DevOps Pipeline
* Terraform modules
* Diagnostic Settings
* Private Endpoints
* Storage Lifecycle Policies

---

# Author

This project was built as part of a personal cloud engineering learning journey with the objective of gaining hands-on experience in Azure Infrastructure as Code, secure authentication, Linux automation, and production-ready cloud architectures.

# WhatNext Vision Motors

## 🚗 Salesforce Automotive Dealership Management System

WhatNext Vision Motors is a Salesforce-based automotive dealership management system designed to manage vehicles, customers, dealers, test drives, service requests, and vehicle orders.

## 🎯 Key Features

- Vehicle inventory management
- Vehicle customer management
- Dealer management with location details
- Vehicle order management
- Test drive scheduling
- Service request management
- Automated customer email notifications
- Automatic nearest-dealer assignment
- Vehicle stock validation

## 🗂️ Salesforce Objects

The project contains six custom objects:

- Dealer
- Vehicle
- Vehicle Customer
- Vehicle Order
- Test Drive
- Service Request

## ⚙️ Automation

### Test Drive Reminder
Automatically sends a reminder email to the customer one day before the scheduled test drive.

### Service Request Acknowledgement
Automatically sends an acknowledgement email when a service request is created.

### Vehicle Order Confirmation
Automatically sends a confirmation email when a vehicle order is changed to Confirmed.

## 💻 Apex

### Vehicle Order Trigger

The `VehicleOrderTrigger` validates vehicle stock before an order is created or updated.

The associated handler:

- Validates available vehicle stock
- Assigns the nearest dealer based on location

## 🛠️ Technologies Used

- Salesforce
- Apex
- Salesforce Flow
- Salesforce DX
- Visual Studio Code
- Salesforce CLI
- Git
- GitHub

## 📁 Project Structure

```text
force-app/
└── main/
    └── default/
        ├── classes/
        ├── flows/
        ├── objects/
        ├── tabs/
        └── triggers/

config/
scripts/
sfdx-project.json
README.md

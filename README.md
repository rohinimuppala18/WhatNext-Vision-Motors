# WhatNext Vision Motors

## Salesforce Platform Developer Project

## Project Overview

WhatNext Vision Motors is a Salesforce-based automotive dealership management system designed to manage vehicles, customers, dealers, test drives, service requests, and vehicle orders.

## Project Objectives

- Manage vehicle inventory efficiently
- Manage vehicle customers and dealer information
- Handle vehicle orders and stock validation
- Manage test drive schedules
- Manage customer service requests
- Automate customer communication using Salesforce Flows
- Automatically assign the nearest dealer based on location

## Salesforce Objects

- Dealer
- Vehicle
- Vehicle Customer
- Vehicle Order
- Test Drive
- Service Request

## Key Features

- Vehicle inventory management
- Vehicle stock validation
- Nearest dealer assignment
- Vehicle order management
- Test drive management
- Service request management
- Automated customer email notifications

## Automation

### Test Drive Reminder

Automatically sends a reminder email to the customer one day before the scheduled test drive.

### Service Request Acknowledgement

Automatically sends an acknowledgement email when a service request is created.

### Vehicle Order Confirmation

Automatically sends a confirmation email when a vehicle order is changed to Confirmed.

## Apex Components

### VehicleOrderTrigger

A before-insert and before-update trigger that validates vehicle stock and processes vehicle order logic.

### VehicleOrderTriggerHandler

Contains the business logic for:

- Vehicle stock validation
- Nearest dealer assignment

## Salesforce Architecture

```text
Vehicle Customer
       |
       +---- Test Drive
       |
       +---- Service Request
       |
       +---- Vehicle Order
                    |
                    +---- Vehicle
                    |
                    +---- Dealer

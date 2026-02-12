# Car Service Center POS / Management System Blueprint

A practical blueprint for building an **offline-first C# desktop system** for car service centers.

## 1) Vision and Scope

This system manages end-to-end operations:

- Vehicle servicing workflow
- Customer and vehicle records
- Spare parts sales and stock control
- Technician assignment and performance tracking
- Billing, receipts, and management reports

## 2) Recommended Technology Stack

- **Language:** C# (.NET 8)
- **UI:** WPF (MVVM)
- **Database:** SQLite
- **PDF/Printing:** iText7 or .NET printing APIs
- **Packaging:** Single-file executable publish profile

## 3) Core Functional Modules

### 3.1 Customer Management
- Add/update customer profile
- Track phone and email
- Search by name/phone
- View full service history

### 3.2 Vehicle Management
- Register vehicle (plate, model, year, VIN/chassis, engine no.)
- Link vehicle to a customer
- Search by plate number
- View service history per vehicle

### 3.3 Service Job Card (Operational Core)
Each customer visit opens a job card containing:
- Customer and vehicle
- Service type (major service / oil change / diagnostics / custom)
- Complaint and inspection notes
- Assigned technician
- Status tracking:
  - Pending
  - In Progress
  - Waiting for Parts
  - Completed
  - Delivered

### 3.4 Standard Service Checklist
Template + per-job checklist items such as:
- Oil level check
- Brake inspection
- Battery test
- Tyre pressure
- Engine diagnostics

### 3.5 Spare Parts Inventory + POS
- Parts master database
- Real-time stock quantity
- Low stock alerts
- Barcode support (optional v1)
- Automatic deduction when parts are sold or consumed by job cards

### 3.6 Technician Management
- Technician profiles and specialization
- Assign jobs from job card screen
- Labour costing
- Completed jobs and productivity reporting

### 3.7 Billing and Payment
Invoice combines:
- Labour amount
- Parts amount
- Tax (optional)
- Discount
- Net payable and payment status

Supported payment methods:
- Cash
- Card
- Mobile payment

### 3.8 Receipts and Invoices
Printable output includes:
- Company branding/logo
- Job card details
- Parts line items
- Labour breakdown
- Payment summary

### 3.9 Reports Dashboard
- Daily revenue
- Technician performance
- Most serviced vehicle models
- Parts usage report
- Monthly profit snapshot

## 4) Non-Functional Requirements

- Works fully **offline**
- Uses **local SQLite database**
- **Simple authentication** (Admin / Cashier / Advisor)
- One-click **backup/restore**
- Easy deployment for non-technical staff

## 5) Proposed High-Level Architecture

- **Presentation:** WPF views + MVVM viewmodels
- **Application Layer:** Services for workflows (JobCardService, BillingService)
- **Domain Layer:** Entities and business rules
- **Infrastructure Layer:** SQLite repositories, printing, file storage

Suggested project layout:

```text
src/
  CarServiceCenter.App/            # WPF UI
  CarServiceCenter.Application/    # Use cases/services
  CarServiceCenter.Domain/         # Entities/enums/rules
  CarServiceCenter.Infrastructure/ # SQLite, repositories, print adapters
  CarServiceCenter.Reporting/      # Report queries/export
database/
  schema.sql
docs/
  mvp-plan.md
```

## 6) Data Model Summary

Implemented in `database/schema.sql` with relationships and indexes.

Main tables:
- Customers
- Vehicles
- Technicians
- ServiceJobs
- ServiceCheckItems
- Parts
- JobParts
- Payments
- Users
- Backups

## 7) MVP (Version 1) Build Plan

### Must-Have v1
1. Customer + vehicle registration
2. Job card creation and status workflow
3. Parts inventory and stock movement through job usage
4. Billing + printable invoice/receipt
5. Basic dashboard reports

### Nice-to-Have after v1
- Service reminder alerts
- Vehicle condition photos
- Maintenance prediction suggestions
- Technician-focused task-only screen

## 8) Milestone-Based Delivery

### Milestone 1: Foundation
- SQLite schema + seed data
- Basic login and role check
- Customer/Vehicle CRUD

### Milestone 2: Workshop Operations
- Job card lifecycle + technician assignment
- Checklist templates and completion
- Parts usage from job card

### Milestone 3: Commercial Operations
- Billing and payment posting
- Invoice/receipt printing
- Daily revenue reports

### Milestone 4: Stabilization
- Backup/restore
- Audit fields and validation
- Packaging as single executable

## 9) Sample KPIs

- Daily sales amount
- Average ticket value
- Jobs completed per technician/day
- Parts consumption by category
- Vehicles returned within 30 days

---

For implementation details, start with `database/schema.sql` and `docs/mvp-plan.md`.

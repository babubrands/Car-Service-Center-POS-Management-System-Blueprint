# MVP Delivery Plan (Version 1)

## Goal
Ship a usable offline desktop application for a car service center in short, controlled phases.

## Functional Scope

1. Customer & Vehicle Registration
   - Customer CRUD
   - Vehicle CRUD linked to customer
   - Search by customer name/phone and vehicle plate

2. Job Card Lifecycle
   - Create job card from customer + vehicle
   - Assign technician
   - Add complaint + inspection notes
   - Update status flow: Pending → In Progress → Waiting for Parts → Completed → Delivered

3. Parts Inventory
   - Parts CRUD
   - Stock quantity updates
   - Low-stock list
   - Auto-deduct parts from job card usage

4. Billing + Receipt
   - Labour + parts subtotal
   - Optional discount/tax
   - Payment capture (cash/card/mobile)
   - Print invoice/receipt

5. Basic Reports
   - Daily revenue
   - Jobs completed by technician
   - Parts usage summary

## Suggested 4-Week Sprint

### Week 1
- Database schema and repositories
- Login shell and navigation
- Customer/vehicle screens

### Week 2
- Job card create/edit/list
- Technician assignment
- Service checklist component

### Week 3
- Parts inventory module
- JobParts integration and stock deduction
- Billing calculation service

### Week 4
- Payments and invoice print
- Dashboard queries
- Backup/restore and packaging

## Definition of Done
- All v1 modules accessible from main navigation
- Critical workflows covered by service-layer tests
- No unresolved schema constraints
- Installer or publish profile produces single executable output

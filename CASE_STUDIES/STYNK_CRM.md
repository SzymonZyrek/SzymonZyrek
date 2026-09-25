# Stynk CRM — end-to-end product / systems case study

> **Source:** proprietary / private  
> **Role:** solo software engineer / de facto end-to-end IT owner  
> **Domain:** construction services / field sales / contract and job operations

This document intentionally describes architecture, responsibilities and engineering decisions without publishing client source code or operational secrets.

## Problem context

The organization was operating across a mixture of paper, local spreadsheets, Google Drive, email, WhatsApp and verbal process.

That created predictable failure modes:

- information duplicated across channels;
- synchronization mistakes;
- missing contract/job details;
- difficult hand-offs between office, sales and field teams;
- weak visibility into deadlines, settlements and work status;
- business rules living in people's heads rather than in one system.

The CRM was built to turn those workflows into an explicit, auditable system rather than add one more disconnected database.

## Scope

The production system grew to cover areas including:

- employees / users / roles;
- clients, contracts and jobs;
- contract scans, technical photos, notes and documents;
- sales and contractor workflows;
- calendar/planning;
- regions and postal-code assignment;
- pricing catalogs and rule-driven pricing;
- VAT handling;
- settlements and deadlines;
- lead distribution;
- validation of missing/inconsistent data;
- audit/history;
- public website integration and lead/contact flows.

The current architectural direction moves more business behaviour into a dynamic **Studio** model and rule-based pricing instead of hard-coded special cases.

## My responsibility

This is the project where my role expanded furthest beyond "developer".

I have been responsible for:

```text
business conversations / requirements
            ↓
domain modelling
            ↓
architecture
            ↓
UX / workflow design
            ↓
backend + frontend implementation
            ↓
tests / CI
            ↓
deployment / rollback
            ↓
production support / iteration
```

That includes deciding what *not* to build, translating informal business procedures into explicit state/rules, and supporting the users after those decisions hit production.

## Technical shape

### Frontend
- Angular
- Angular Material / SCSS
- PWA-style web application

### Backend
- Python
- Django + Django REST Framework
- PostgreSQL in production

### Runtime / delivery
- Docker Compose
- nginx
- Gunicorn
- Ubuntu VPS
- CI and automated verification around deployment
- staging/preflight checks, backups and rollback-oriented deployment practice

The application and public website are developed as one product surface but remain separable operational concerns.

## Design pressures

### 1. Dynamic business rules

Pricing, job types, operations, variants and regional differences change often enough that encoding every variation directly in application code becomes expensive.

That led toward a dynamic model where the system describes more of its own business structure and pricing behaviour.

### 2. User workflow beats abstract purity

The primary users are not software engineers.

A technically elegant data model is not useful if office staff, salespeople or contractors cannot understand the workflow. UX decisions therefore feed back directly into domain modelling.

### 3. Production changes have to respect the business

A failed deployment is not just a red CI badge; it can block people scheduling work, accessing contract data or preparing field operations.

Deployment work therefore includes preflight verification, rollback thinking, backups and a preference for changes that can be reverted cleanly.

### 4. Auditability matters

When contracts, pricing and assignments change, "what is the current value?" is not always enough. The system needs enough history to explain what happened and support operational debugging.

## What this project demonstrates

For portfolio purposes, the most important point is not any individual framework.

It is the combination of:

- requirements analysis;
- business/domain modelling;
- architecture;
- full-stack implementation;
- UX design;
- testing and verification;
- CI/CD and infrastructure;
- production deployment;
- support and iteration with real users.

This is the project that best represents how I work when I own the whole engineering problem rather than one isolated ticket queue.

## Why the source is not public

The repository contains proprietary domain logic and production-oriented implementation for a real company.

I prefer showing a sanitized architecture/product case study to publishing a toy reconstruction that would look public but would no longer be the actual system.

# Stynk CRM — screenshot plan

The goal is not to make a gallery of every screen.

Each screenshot should support one concrete claim from the [Stynk CRM case study](STYNK_CRM.md).

Use **fixture/test data** wherever possible. Avoid production client names, phone numbers, e-mail addresses, exact addresses, contract values or internal IDs that should not be public.

## Capture conventions

Recommended desktop viewport:

```text
1440 × 900
```

Recommended phone viewport:

```text
390 × 844
```

Keep one theme consistent for the main set. The light/day theme is probably easier to read in GitHub/portfolio screenshots; one dark-theme screenshot can be useful if it shows the theme system intentionally.

Prefer:

- a populated realistic fixture over empty states;
- one clear workflow state over a screen with every modal open;
- enough browser crop to show the application, not bookmarks/devtools;
- PNG;
- no production notification counters or personal avatars unless they are synthetic.

Suggested asset directory once captured:

```text
assets/stynk/
```

---

# Priority A — the six screenshots I would definitely take

## 1. Contract workspace + source documents

**Suggested file:** `assets/stynk/01-contract-workspace.png`  
**Route:** `/contracts/:id` or the equivalent fixture/test Contract

Show:

- Contract header/status;
- structured business fields;
- one or two Jobs/sections if they fit naturally;
- documents/photos/notes area;
- ideally a visible scan thumbnail or document section.

Why this matters:

This single view explains the core product story: a paper contract created in the field becomes a structured operational record while preserving the original evidence next to it.

Avoid using a completely blank "new contract" form.

---

## 2. Contract or Job detail in phone portrait

**Suggested file:** `assets/stynk/02-mobile-field-workflow.png`  
**Viewport:** around `390 × 844`  
**Good routes:** `/contracts/:id` or `/jobs/:id`

Show:

- the flattened phone layout;
- readable label/value sections;
- notes or attachment cards;
- touch-sized actions;
- no horizontal scrolling.

Why this matters:

It proves the responsive claim much better than writing "mobile friendly" in a paragraph.

The best comparison would eventually be the same business object on desktop and phone.

---

## 3. Scheduling calendar

**Suggested file:** `assets/stynk/03-job-scheduling-calendar.png`  
**Route:** `/jobs/calendar`

Show:

- several Jobs spread over dates;
- more than one subcontractor if the view supports it;
- status/type color;
- preferably one natural planning conflict/warning if it is visually clear and does not clutter the shot.

Why this matters:

This demonstrates that the application is an operational planning system rather than only a records database.

Alternative/supporting view:

- `/subcontractors/:id/calendar`
- `/jobs/calendar/subcontractor`

---

## 4. Sales Visit calendar or map

**Suggested file:** `assets/stynk/04-sales-visits.png`

Best candidates:

- `/addresses/calendar` — if month/week view looks strongest;
- `/addresses/map` — if synthetic meeting pins and status colors produce a clearer visual.

Show:

- multiple planned/completed visits;
- different visit statuses/types;
- filters if they fit;
- client/address/time context.

Why this matters:

This is one of the most domain-specific workflows in the application and illustrates mobile field-sales thinking, address reuse, calendar/map integration and actual sales operations.

If both map and calendar are strong, take both and use one as a secondary screenshot.

---

## 5. Config Studio

**Suggested file:** `assets/stynk/05-config-studio.png`  
**Route:** `/studio`

This is probably the most visually distinctive technical screenshot.

Show a non-trivial but understandable resource:

- explorer on the left;
- graph/model editor in the centre;
- inspector on the right;
- a few typed nodes/connections;
- diagnostics/result dock only if it improves the picture.

Good subject:

- a small Job/Operation price calculation;
- a condition plus calculation;
- a Composite with a few meaningful fields.

Do **not** use the most enormous production graph available. The screenshot should make the concept legible at a glance.

Why this matters:

It supports the strongest architectural-evolution claim in the case study: moving from hard-coded pricing/business shapes toward a versioned modelling/runtime layer.

---

## 6. Audit timeline

**Suggested file:** `assets/stynk/06-audit-history.png`  
**Good routes:**

- `/admin/audit/entity/:entityType/:entityId`
- `/admin/audit/user/:id/activity`

Show:

- several changes over time;
- actor;
- action;
- before/after or changed fields;
- synthetic data.

Why this matters:

It provides visible evidence for the "auditable business system" claim and balances the prettier workflow screenshots with a serious operational feature.

---

# Priority B — very useful supporting screenshots

## 7. Office intake / OCR-assisted contract processing

**Suggested file:** `assets/stynk/07-contract-intake-ocr.png`

Good candidates:

- `/office/intake-queue`;
- `/office/contracts/:id/data-entry`;
- Contract OCR result/review area if the current UI exposes it clearly;
- admin OCR status only if there is no better user-facing review screen.

Ideal shot:

source scan on one side / structured suggested fields or office-entry workflow on the other.

Why this matters:

It makes the OCR architecture tangible.

If the UI currently shows only technical job state and no useful review surface yet, skip this screenshot rather than manufacturing a story the current product does not show.

---

## 8. Public inquiry → CRM lead

**Suggested file:** `assets/stynk/08-public-inquiry.png`  
**Route:** `/inquiries/:id`

Use a fully synthetic lead.

Show:

- contact/request context;
- assigned sales representative or unassigned routing state;
- lifecycle/actions such as contact/meeting/client conversion if visible;
- attachments if they make the workflow clearer.

Why this matters:

It proves the integration between the public company website and internal CRM.

A two-image sequence could work particularly well:

```text
public stynk.eu form
        ↓
CRM inquiry detail
```

---

## 9. Payments / settlements

**Suggested file:** `assets/stynk/09-payments.png`  
**Good routes:**

- `/payments`
- `/payments/incoming`
- `/payments/outgoing`
- `/settlements`

Show several different obligation states using synthetic amounts.

Why this matters:

It demonstrates that financial consequences are connected to contract/job lifecycle rather than tracked in an unrelated spreadsheet.

---

## 10. Attachment viewer / gallery

**Suggested file:** `assets/stynk/10-attachments.png`

Good candidates:

- `/contracts/:id/scans`;
- a Contract/Job attachment gallery with image preview;
- note + image context.

Why this matters:

Field photos, scans, drawings and notes are central to the real construction workflow and make the domain immediately understandable.

---

# Priority C — architecture/support screenshots

These are useful later, but I would not let them crowd out the real workflows.

## OCR Preferences

Route: `/preferences`

Potentially show:

- provider choice;
- enabled/disabled state;
- limits;
- mail-workflow settings.

Before publishing, redact:

- project IDs if desired;
- processor IDs;
- mailbox addresses if sensitive;
- credentials/secrets — these should not be readable in the UI anyway.

This works as an architecture illustration next to the OCR section, not as a hero screenshot.

## Datastore Preferences

Route: `/preferences/datastores`

A good populated screen with Local Media + Google Drive can illustrate storage abstraction/capacity/health.

## Marketing analytics

Route: `/analytics`

Use if it looks polished and you want to demonstrate the public-site analytics/SEO side of the product. It is secondary to the core construction workflow.

## User/role management

Useful to show role-aware administration but visually generic; only include if there is room.

---

# Suggested final case-study gallery

If we want the finished case study to stay compact, I would embed **six main images**:

```text
1. Contract workspace
2. Mobile Job/Contract detail
3. Scheduling calendar
4. Sales Visit calendar/map
5. Config Studio
6. Audit history
```

Then use smaller/supporting images inline near their respective sections:

```text
7. OCR intake/review
8. Public inquiry
9. Payments
10. Datastores or attachments
```

The first six already tell a coherent story:

```text
business record
   → field/mobile UX
   → operations planning
   → sales workflow
   → configurable architecture
   → auditability
```

---

# Fixture data suggestion

For screenshots, create one coherent synthetic mini-world instead of unrelated lorem ipsum records.

For example:

- Client: `Anna Nowak` / `Dom Testowy`;
- locality: a generic/test locality;
- Contract: `TEST-2026-001`;
- Jobs: façade + roof;
- Sales Rep: `Jan Kowalski`;
- Subcontractor: `Ekipa Testowa`;
- two or three Sales Visits;
- several synthetic attachments using neutral house/construction images;
- payment amounts that are obviously illustrative.

That lets the screenshots feel like one product walkthrough rather than unrelated test fixtures.

## Before publishing

Check every image for:

- real client names;
- phone/e-mail/address;
- contract numbers copied from production;
- prices/commission rates that are confidential;
- usernames;
- notification text leaking private information;
- browser URL containing internal hostnames or IDs;
- OCR/account configuration secrets.

Synthetic fixture screenshots are preferable to blurring production screenshots everywhere.

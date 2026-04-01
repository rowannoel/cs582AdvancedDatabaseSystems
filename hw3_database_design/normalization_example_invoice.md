# Normalization Example: Invoice System

This example demonstrates step-by-step normalization of an invoice-based dataset to eliminate redundancy and prevent anomalies.

---

## Original Unnormalized Relation

| InvoiceNo | CustomerID | CustomerName | CustomerPhone | ItemsPurchased |
|----------|------------|--------------|---------------|----------------|
| 2001 | C01 | John White | 555-1234 | (Tablet, Charger) |
| 2002 | C02 | Mary Green | 555-5678 | (Printer) |
| 2003 | C01 | John White | 555-1234 | (Mouse, Keyboard) |

---

## Identified Anomalies

- **Insertion Anomaly**  
  Cannot insert a new customer unless they have a purchase.

- **Deletion Anomaly**  
  Deleting an invoice removes all associated customer information.

- **Update Anomaly**  
  Updating customer data (e.g., phone number) requires multiple row updates.

---

## Functional Dependencies

- `InvoiceNo → CustomerID`
- `CustomerID → CustomerName, CustomerPhone`
- `InvoiceNo → ItemsPurchased`

---

## First Normal Form (1NF)

**Goal:** Eliminate multi-valued attributes.

| InvoiceNo | CustomerID | CustomerName | CustomerPhone | Item |
|----------|------------|--------------|---------------|------|
| 2001 | C01 | John White | 555-1234 | Tablet |
| 2001 | C01 | John White | 555-1234 | Charger |
| 2002 | C02 | Mary Green | 555-5678 | Printer |
| 2003 | C01 | John White | 555-1234 | Mouse |
| 2003 | C01 | John White | 555-1234 | Keyboard |

- Each row now contains only a single value per column.
- Multi-valued field `ItemsPurchased` has been flattened.

---

## Second Normal Form (2NF)

**Goal:** Remove partial dependencies.

### Decomposition:

**Invoice**
- InvoiceNo (PK)
- CustomerID
- CustomerName
- CustomerPhone

**InvoiceItems**
- (InvoiceNo, Item) (Composite PK)

- Customer data depends only on `InvoiceNo`, not the full composite key.
- This removes partial dependency.

---

## Third Normal Form (3NF)

**Goal:** Remove transitive dependencies.

### Final Schema:

**Customer**
- CustomerID (PK)
- CustomerName
- CustomerPhone

**Invoice**
- InvoiceNo (PK)
- CustomerID (FK → Customer.CustomerID)

**InvoiceItems**
- (InvoiceNo, Item) (Composite PK)
- FK → Invoice.InvoiceNo

- Customer attributes are separated into their own relation.
- Eliminates dependency: `InvoiceNo → CustomerID → CustomerName, CustomerPhone`

---

## Final Result

The schema is now in **Third Normal Form (3NF)**:
- No partial dependencies
- No transitive dependencies
- Reduced redundancy
- Improved data integrity

---

## Key Insight

Normalization ensures that:
- Each fact is stored in exactly one place
- Updates are consistent and efficient
- The schema scales better for real-world database systems

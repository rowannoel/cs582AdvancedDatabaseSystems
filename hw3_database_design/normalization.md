## Normalization

### Functional Dependencies
OrderID → CustomerName, CustomerAddress, ItemsOrdered

### 1NF
- Removed multi-valued attributes
- Split ItemsOrdered into separate rows

### 2NF
- Removed partial dependencies
- Created:
  - Orders(OrderID, CustomerName, CustomerAddress)
  - OrderItems(OrderID, ItemsOrdered)

### 3NF
- Removed transitive dependency
- Final schema:
  - Customers(CustomerName, CustomerAddress)
  - Orders(OrderID, CustomerName)
  - OrderItems(OrderID, Item)

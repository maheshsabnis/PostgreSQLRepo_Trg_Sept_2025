CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  data JSONB
);

INSERT INTO customers (data)
VALUES (
  '{
    "customerId": "C0001",
    "name": "Customer 1",
    "email": "customer1@example.com",
    "address": {
      "street": "717 Main St",
      "city": "Houston",
      "state": "CA",
      "zip": "92472"
    },
    "orders": [
      {
        "orderId": "O0010",
        "orderDate": "2025-02-27",
        "products": [
          {
            "productName": "Gadget B",
            "manufacturer": "Stark Industries",
            "price": 29.99,
            "quantity": 1
          }
        ]
      },
      {
        "orderId": "O0011",
        "orderDate": "2024-12-18",
        "products": [
          {
            "productName": "Widget A",
            "manufacturer": "Stark Industries",
            "price": 19.99,
            "quantity": 2
          }
        ]
      }
    ]
  }'::jsonb
);

SELECT data->>'name' AS name,
       data->'address'->>'city' AS city
FROM customers;


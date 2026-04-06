# sql-shipments-project
SQL project demonstrating joins, aggregates, CRUD operations, and shipment analysis

Shipment Table

Tracks shipment details and customer information.

• ShipmentID
• Origin
• Destination
• Weight (ItemWeight)
• PalletWeight
• TotalWeight
• ShipmentDate
• CustomerFirstName
• CustomerLastName
• StatusID (Foreign Key)

ShipmentStatus Table

Stores shipment status descriptions.

• StatusID
• StatusDescription

SQL Skills Demonstrated

• Creating databases and tables
• Inserting, updating, and deleting records
• Adding new columns with ALTER TABLE
• Using CASE expressions for conditional updates
• Joining related tables
• Grouping and aggregating data
• Calculating derived metrics
• Ordering and filtering results
• Answering real business questions with SQL

Join Example

SELECT s.ShipmentID, s.CustomerFirstName, s.CustomerLastName,
       s.Origin, s.Destination, s.Weight, s.ShipmentDate,
       ss.StatusDescription
FROM Shipment s
INNER JOIN ShipmentStatus ss ON s.StatusID = ss.StatusID;

Aggregate Example

SELECT ss.StatusDescription, COUNT(*) AS TotalShipments
FROM Shipment s
JOIN ShipmentStatus ss ON s.StatusID = ss.StatusID
GROUP BY ss.StatusDescription;

Project Summary

This project simulates a real‑world logistics workflow by tracking shipments, customers, and shipment statuses. It demonstrates relational database design, data cleaning, joins, aggregates, and analytical SQL queries used to answer operational questions such as shipment delays and weight analysis. It serves as a complete beginner‑friendly SQL portfolio project.

---
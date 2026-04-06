--This query creates a database named "Shipments", a table named "Shipment", and inserts sample records into the table.	
-- Select the database to use
USE Shipments;
GO

-- Create the Shipment table
CREATE TABLE dbo.Shipment
(
	ShipmentID INT PRIMARY KEY,
	Origin VARCHAR(100),
	Destination VARCHAR(100),
	Weight DECIMAL(10, 2),
	ShipmentDate DATE
);
GO

-- Insert a sample record into the Shipment table
INSERT INTO Shipment 
-- Specify the columns to insert values into
VALUES 
(1, 'New York', 'Los Angeles', 500.00, '2024-01-15'),
(2, 'Chicago', 'Houston', 300.00, '2024-02-20'),
(3, 'Miami', 'Atlanta', 200.00, '2024-03-10'),
(4, 'Seattle', 'Denver', 400.00, '2024-04-05'),
(5, 'Boston', 'San Francisco', 600.00, '2024-05-25');
GO

-- Query the Shipment table to verify the inserted records
SELECT * FROM dbo.Shipment;

-- Add customers' first and last name columns
ALTER TABLE dbo.Shipment ADD CustomerFirstName VARCHAR(100);
ALTER TABLE dbo.Shipment ADD CustomerLastName VARCHAR(100);
GO

-- Update the existing records with sample customer names
UPDATE Shipment
SET CustomerFirstName = CASE ShipmentID
	WHEN 1 THEN 'John'
	WHEN 2 THEN 'Jane'
	WHEN 3 THEN 'Michael'
	WHEN 4 THEN 'Emily'
	WHEN 5 THEN 'David'
END;

-- Update customer last names
UPDATE Shipment
SET CustomerLastName = CASE ShipmentID
	WHEN 1 THEN 'Doe'
	WHEN 2 THEN 'Smith'
	WHEN 3 THEN 'Johnson'
	WHEN 4 THEN 'Brown'
	WHEN 5 THEN 'Davis'
END;

-- Query the Shipment table to verify the updated records
SELECT * FROM dbo.Shipment;
GO

--Order the shipments by ShipmentDate
SELECT *
FROM Shipment
ORDER BY ShipmentDate ASC;
GO

--Delete the third shipment record
DELETE FROM Shipment
WHERE ShipmentID = 3;
GO

-- Query the Shipment table to verify the deletion
SELECT * FROM dbo.Shipment;
GO

--It seems that the scales were off by a factor of 10. Update the weights to reflect the correct values.
UPDATE Shipment 
SET Weight = Weight * 10
WHERE ShipmentID IN (1, 2, 4, 5);
GO

-- Query the Shipment table to verify the updated weights
SELECT * FROM dbo.Shipment;
GO

--Create a table for shipment status
CREATE TABLE ShipmentStatus
(
	StatusID INT PRIMARY KEY,
	StatusDescription VARCHAR(100)
);
GO

-- Insert sample records into the ShipmentStatus table
INSERT INTO ShipmentStatus (StatusID, StatusDescription)
VALUES 
(1, 'In Transit'),
(2, 'Delivered'),
(3, 'Delayed'),
(4, 'Cancelled');
GO

-- Query the ShipmentStatus table to verify the inserted records
SELECT * FROM dbo.ShipmentStatus;
GO

--Add a StatusID column to the Shipment table to link it with the ShipmentStatus table
ALTER TABLE Shipment ADD StatusID INT;
GO

-- Update the Shipment table to set the StatusID for each shipment
UPDATE Shipment 
SET StatusID = CASE ShipmentID
	WHEN 1 THEN 1 -- In Transit
	WHEN 2 THEN 2 -- Delivered
	WHEN 4 THEN 3 -- Delayed
	WHEN 5 THEN 4 -- Cancelled
END;

-- Query the Shipment table to verify the updated StatusID
SELECT * FROM dbo.Shipment;
GO

--Join the Shipment and ShipmentStatus tables to display the shipment details along with their status descriptions
SELECT s.ShipmentID,s.CustomerFirstName, s.CustomerLastName, s.Origin, s.Destination, s.Weight, s.ShipmentDate, ss.StatusDescription
FROM Shipment s
INNER JOIN ShipmentStatus ss ON s.StatusID = ss.StatusID
GO	

-- Update the weight column to reflect the weight of the items being shipped, rather than the total weight of the shipment by changing the name to ItemWeight and adjusting the values accordingly.
UPDATE Shipment
SET Weight = CASE ShipmentID
	WHEN 1 THEN 4950.00
	WHEN 2 THEN 2950.00
	WHEN 4 THEN 3950.00
	WHEN 5 THEN 5950.00
END;

--query the Shipment table to verify the updated weights.
SELECT * FROM dbo.Shipment;
GO

--Add a column for the pallet weight to the Shipment table and update it with sample values.
ALTER TABLE Shipment ADD PalletWeight INT;
GO

--Add sample pallet weights for each shipment
UPDATE Shipment 
SET PalletWeight = CASE ShipmentID
	WHEN 1 THEN 50
	WHEN 2 THEN 50
	WHEN 4 THEN 50
	WHEN 5 THEN 50
END;

--query the Shipment table to verify the added pallet weights.
SELECT * FROM dbo.Shipment;
GO

--Calculate the total weight of each shipment by adding the item weight and pallet weight, and display the results in a new column called TotalWeight.
ALTER TABLE Shipment ADD TotalWeight DECIMAL(10, 2);
GO

--Aggregate the total weight for each shipment
SELECT 
ShipmentID,  
SUM(Weight + PalletWeight) AS TotalWeight 
FROM Shipment 
GROUP BY ShipmentID; 
GO

-- Update the shipment table to set the TotalWeight column with the calculated total weight for each shipment.
UPDATE Shipment
SET TotalWeight = Weight + PalletWeight;
GO

-- Query the Shipment table to verify the updated TotalWeight column.
SELECT ShipmentID, Weight, PalletWeight, TotalWeight
FROM Shipment;
GO	

--Highlight the top delayed shipments by ordering the results based on the shipment status and shipment date.
SELECT s.ShipmentID, s.CustomerFirstName, s.CustomerLastName, s.Origin, s.Destination, s.Weight, s.ShipmentDate
FROM Shipment s
ORDER BY CASE 
	WHEN s.StatusID = 3 THEN 1 -- Delayed
	WHEN s.StatusID = 1 THEN 2 -- In Transit
	WHEN s.StatusID = 2 THEN 3 -- Delivered
	WHEN s.StatusID = 4 THEN 4 -- Cancelled
	ELSE 5 -- Other statuses 
END,
s.ShipmentDate ASC;
GO

-- Total shipments per status
SELECT ss.StatusDescription, COUNT(*) AS TotalShipments
FROM Shipment s
JOIN ShipmentStatus ss ON s.StatusID = ss.StatusID
GROUP BY ss.StatusDescription;
GO

-- Which shipments are delayed most often?
-- What is the average shipment weight?

																																																																																		``
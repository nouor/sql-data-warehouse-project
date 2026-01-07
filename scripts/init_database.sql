/* 
  Purpose:
  - (Re)creates the SQL Server database [DataWarehouse] for the project.
  - If the database already exists, it forces single-user mode (kicks active sessions),
    drops the database, then creates it again.
  - Finally, it creates the DWH layers as separate schemas: bronze, silver, gold.
*/

USE MASTER;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
  ALTER DATA DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehoouse;
END;
GO

-- Create Database 'DataWarehouse'
CREATE DATABASE DataWarehouse;

USE DataWarehouse;

-- Create SCHEMAS
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO

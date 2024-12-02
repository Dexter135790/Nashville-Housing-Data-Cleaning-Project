# Nashville-Housing-Data-Cleaning-Project

This project demonstrates the use of SQL to clean and prepare real-world data for analysis. The dataset contains Nashville housing information, including property details, sale records, and owner information. The focus of this project is to showcase advanced SQL data cleaning techniques.

## Table of Contents
- [Overview](#overview)
- [Dataset](#dataset)
- [Steps Performed](#steps-performed)
- [Key SQL Concepts Used](#key-sql-concepts-used)


## Overview
### Objectives:
- Clean and standardize the dataset for analysis.
- Handle missing values and inconsistencies.
- Showcase data transformation using SQL.

## Dataset
### Original Data
The dataset contains fields such as:
- **UniqueID**: Unique identifier for each record.
- **ParcelID**: Property parcel identifier.
- **SaleDate**: Date of property sale (varied formats).
- **PropertyAddress**: Address of the property (some records are missing).
- **SoldAsVacant**: Indicates whether the property was sold as vacant (values include 'Y' and 'N').


### Cleaned Data
The cleaned dataset includes:
- Standardized date formats.
- Populated missing property addresses.
- Split columns for address, city, and state.
- Standardized values for 'SoldAsVacant' to "Yes" and "No."
- Removed duplicates and unnecessary columns.


## Steps Performed
1. **Standardized Date Format**  
   - Converted `SaleDate` to a uniform `YYYY-MM-DD` format.  

2. **Handled Missing Property Addresses**  
   - Populated missing `PropertyAddress` values using `ParcelID`.  

3. **Split Address Data**  
   - Extracted address, city, and state into separate columns for both `PropertyAddress` and `OwnerAddress`.  

4. **Standardized Categorical Data**  
   - Converted `SoldAsVacant` values from `Y/N` to `Yes/No`.  

5. **Removed Duplicates**  
   - Identified and deleted duplicate records using SQL's `ROW_NUMBER()` function.  

6. **Dropped Unnecessary Columns**  
   - Removed unused fields to optimize the dataset.

## Key SQL Concepts Used
- `CONVERT()` and `CAST()` for date formatting.
- `ISNULL()` for handling missing values.
- String manipulation functions: `SUBSTRING()`, `CHARINDEX()`, `PARSENAME()`.
- Joins for cross-referencing data.
- `ROW_NUMBER()` for identifying duplicates.
- `ALTER TABLE` for schema modifications.

## Summary
- Cleaned and standardized dataset ready for analysis.
- Reduced redundancy and improved data quality.



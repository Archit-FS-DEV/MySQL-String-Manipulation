# MySQL-String-Manipulation


# SQL String Functions Demonstration

## Overview

This repository contains SQL scripts demonstrating various string functions in MySQL. The scripts include examples of working with text, manipulating strings, formatting outputs, and performing search operations.

## Tables Used

### 1. `string_functions_demo`
This table is used to showcase different string functions with sample names and descriptions.

### 2. `string_functions_demo2`
An extended version with additional fields like `category`, `binary_value`, and `mail` for further string manipulations.

### 3. `customer_data1`
Contains customer-related data to demonstrate real-world string processing applications like email parsing and phone number formatting.

## Key SQL Functions Demonstrated

- **String Length & Characters**  
  - `CHAR_LENGTH()`, `CHAR()`, `BIT_LENGTH()`
  
- **String Concatenation & Formatting**  
  - `CONCAT()`, `INSERT()`, `REPLACE()`, `RPAD()`

- **String Extraction & Search**  
  - `SUBSTRING_INDEX()`, `RIGHT()`, `SOUNDEX()`, `LIKE`

- **Binary & Phonetic Representation**  
  - `BIN()`, `EXPORT_SET()`, `SOUNDEX()`

- **Sorting & Ranking**  
  - `FIELD()`, `ORDER BY`

## How to Use

1. Import the SQL script into a MySQL database.
2. Run the queries individually to observe results.
3. Modify the data or queries to explore additional use cases.

## Example Queries

1. Extract domain names from emails:
   ```sql
   SELECT name, SUBSTRING_INDEX(mail, '@', -1) AS domain FROM string_functions_demo2;

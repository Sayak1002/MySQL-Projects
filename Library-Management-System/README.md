# Library Management System using SQL

## Project Overview

**Project Title**: Library Management System    
**Database**: `library_db`

This project involves a comprehensive Library Management System designed to handle the management of library branches, employees, books, members, issued statuses, and return statuses. The system allows for tracking book issuance and returns, managing member information, and maintaining branch and employee details.

## Objectives

1. **Set up the Library Management System Database**: Create and populate the library database with tables for branches, employees, members, books, issued_status, and return_status.
2. **CRUD Operations**: Perform Create, Read, Update, and Delete operations on the data.
3. **CTAS (Create Table As Select)**: Utilize CTAS to create new tables based on query results.
4. **Advanced SQL Queries**: Develop complex queries to analyze and retrieve specific data.



## Database Schema

The schema consists of the following tables:

### `branch`

- `branch_id` (VARCHAR(20), Primary Key): Unique identifier for each branch.
- `manager_id` (VARCHAR(20), Not Null): Identifier for the branch manager.
- `branch_address` (VARCHAR(100)): Address of the branch.
- `contact_no` (VARCHAR(20)): Contact number of the branch.

### `employee`

- `emp_id` (VARCHAR(15), Primary Key): Unique identifier for each employee.
- `emp_name` (VARCHAR(50), Not Null): Name of the employee.
- `position` (VARCHAR(30)): Job position of the employee.
- `salary` (INT): Salary of the employee.
- `branch_id` (VARCHAR(20)): Foreign key referencing `branch_id` in the `branch` table.

### `books`

- `isbn` (VARCHAR(30), Primary Key): Unique identifier for each book.
- `book_title` (VARCHAR(100)): Title of the book.
- `category` (VARCHAR(25)): Category of the book.
- `rental_price` (FLOAT): Rental price of the book.
- `status` (VARCHAR(15)): Availability status of the book (e.g., "yes", "no").
- `author` (VARCHAR(100)): Author of the book.
- `publisher` (VARCHAR(100)): Publisher of the book.

### `members`

- `member_id` (VARCHAR(25), Primary Key): Unique identifier for each member.
- `member_name` (VARCHAR(50)): Name of the member.
- `member_address` (VARCHAR(150)): Address of the member.
- `reg_date` (DATE): Registration date of the member.

### `issued_status`

- `issued_id` (VARCHAR(15), Primary Key): Unique identifier for each issued book record.
- `issued_member_id` (VARCHAR(25)): Foreign key referencing `member_id` in the `members` table.
- `issued_book_name` (VARCHAR(100)): Name of the book issued.
- `issued_date` (DATE): Date the book was issued.
- `issued_book_isbn` (VARCHAR(30)): Foreign key referencing `isbn` in the `books` table.
- `issued_emp_id` (VARCHAR(15)): Foreign key referencing `emp_id` in the `employee` table.

### `return_status`

- `return_id` (VARCHAR(30), Primary Key): Unique identifier for each return record.
- `issued_id` (VARCHAR(15)): Foreign key referencing `issued_id` in the `issued_status` table.
- `return_book_name` (VARCHAR(100)): Name of the book returned.
- `return_date` (DATE): Date the book was returned.
- `return_book_isbn` (VARCHAR(30)): ISBN of the returned book.

## Foreign Key Constraints

The database schema includes the following foreign key constraints to establish relationships between tables:

- `issued_status` table:
  - `issued_member_id` references `members(member_id)` (ON DELETE CASCADE)
  - `issued_book_isbn` references `books(isbn)` (ON DELETE SET NULL)
  - `issued_emp_id` references `employee(emp_id)` (ON DELETE SET NULL)

- `employee` table:
  - `branch_id` references `branch(branch_id)` (ON DELETE SET NULL)

- `return_status` table:
  - `issued_id` references `issued_status(issued_id)` (ON DELETE CASCADE)




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


The Entity-Relationship Diagram (ERD) for the Library Management System is shown below:

![ERD Diagram](/Library-ERD-PNG.png)

## Tasks

Here is a list of tasks that will be accomplished in the project:

1. **Create a New Book Record**
   - **Objective:** Insert a new book record into the books table.
   - **Example:** `978-1-60129-456-2, 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'`

2. **Update an Existing Member's Address**
   - **Objective:** Update the address of an existing member.

3. **Delete a Record from the Issued Status Table**
   - **Objective:** Delete the record with `issued_id = 'IS121'` from the `issued_status` table.

4. **Retrieve All Books Issued by a Specific Employee**
   - **Objective:** Select all books issued by the employee with `emp_id = 'E101'`.

5. **List Members Who Have Issued More Than One Book**
   - **Objective:** Use `GROUP BY` to find members who have issued more than one book.

6. **Create Summary Tables**
   - **Objective:** Use CTAS (CREATE TABLE AS) to generate new tables based on query results, such as the count of books issued for each book.

7. **Retrieve All Books in the Classic Category**
   - **Objective:** List all books categorized as 'Classic'.

8. **Find Total Rental Income by Category**
   - **Objective:** Calculate the total rental income for each category of books.

9. **List Members Who Registered in the Last 180 Days**
   - **Objective:** Find all members who registered within the last 180 days.

10. **List Employees with Their Branch Manager's Name and Branch Details**
    - **Objective:** Retrieve details of employees along with their branch manager's name and branch information.

11. **Create a Table of Books with Rental Price Above 7.00**
    - **Objective:** Create a table that lists books with a rental price greater than 7.00.

12. **Retrieve the List of Books Not Yet Returned**
    - **Objective:** List all books that have not been returned yet.

13. **Identify Members with Overdue Books**
    - **Objective:** Write a query to identify members with overdue books (assume a 30-day return period). Display member ID, member name, book title, issue date, and days overdue.

14. **Update Book Status on Return**
    - **Objective:** Write a query to update the status of books in the books table to "Yes" when they are returned, based on entries in the `return_status` table.

15. **Branch Performance Report**
    - **Objective:** Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.

16. **CTAS: Create a Table of Active Members**
    - **Objective:** Use the `CREATE TABLE AS` (CTAS) statement to create a new table `active_members` containing members who have issued at least one book in the last 6 months.

17. **Find Employees with the Most Book Issues Processed**
    - **Objective:** Write a query to find the top 3 employees who have processed the most book issues. Display employee name, number of books processed, and their branch.

18. **Stored Procedure Objective**
    - **Objective:** Create a stored procedure to manage the status of books in a library system.
    - **Description:** Write a stored procedure that updates the status of a book based on its issuance. The procedure should:
      - Take `book_id` as an input parameter.
      - Check if the book is available (`status = 'yes'`). If available, issue the book and update the status in the `books` table to 'no'.
      - If not available (`status = 'no'`), return an error message indicating that the book is currently not available.


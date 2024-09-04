-- Project Tasks

-- Task 1. Create a New Book Record 
--  978-1-60129-456-2, 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'

INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

-- Task 2: Update an Existing Member's Address

UPDATE  members
SET member_address = "125 Main St"
WHERE member_id = "C101";

-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM issued_status
WHERE issued_id = 'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT issued_book_name,issued_book_isbn,issued_date FROM issued_status
WHERE issued_emp_id = "E101";

-- Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT
issued_member_id  AS "ID",
member_name AS "NAME",
COUNT(*) AS "Number Of Books"
FROM issued_status a
JOIN members b
ON a.issued_member_id= b.member_id
GROUP BY issued_member_id,member_name
HAVING COUNT(*)>1;

-- Task 6: Create Summary Tables: 
-- Use CTAS to generate new tables based on query results - each book and total book_issued_cnt**
CREATE TABLE  book_isssue_count AS
SELECT b.isbn,
b.book_title,
COUNT(a.issued_id) AS "Number of issue"
FROM books b
JOIN issued_status a
on b.isbn = a.issued_book_isbn
GROUP BY b.book_title, b.isbn;

RENAME TABLE book_isssue_count TO book_issue_count;
SELECT* FROM book_issue_count;

-- Task 7. Retrieve All Books in the Classic Category:

SELECT isbn,
book_title
FROM books
WHERE category = 'Classic';

-- Task 8: Find Total Rental Income by Category:

SELECT b.category,
SUM(b.rental_price) AS "Rental Income",
COUNT(*) AS "Number of issues"
FROM books b
JOIN issued_status a
ON b.isbn = a.issued_book_isbn
GROUP BY 1 
ORDER BY 2 DESC;

-- Task 9 List Members Who Registered in the Last 180 Days:

SELECT * FROM members
WHERE reg_date >= date_sub(curdate(),INTERVAL 180 DAY);

-- Task 10 List Employees with Their Branch Manager's Name and their branch details:

SELECT 
    e1.emp_id,
    e1.emp_name,
    e1.position,
    e1.salary,
    b.*,
    e2.emp_name as manager
FROM employee as e1
JOIN 
branch as b
ON e1.branch_id = b.branch_id    
JOIN
employee as e2
ON e2.emp_id = b.manager_id;

-- Task 11 Create a Table of Books with Rental Price Above 7.00

CREATE TABLE Expensive_books as 
SELECT * FROM books 
WHERE rental_price>7.00;

SELECT*FROM Expensive_books;

-- Task 12 Retrieve the List of Books Not Yet Returned

SELECT  a.issued_member_id,a.issued_book_name,a.issued_date
FROM issued_status a
LEFT JOIN return_status b
ON b.issued_id = a.issued_id
WHERE b.return_id IS NULL;

-- Task 13: Identify Members with Overdue Books
-- Write a query to identify members who have overdue books (assume a 30-day return period). 
-- Display the member's_id, member's name, book title, issue date, and days overdue.

SELECT a.issued_member_id,
b.member_name,
c.book_title,
a.issued_date,
 DATEDIFF(CURRENT_DATE(), a.issued_date) AS "Over due days"
FROM issued_status a
JOIN members b
ON a.issued_member_id = b.member_id
JOIN books c
ON a.issued_book_isbn = c.isbn
LEFT JOIN return_status d
ON a.issued_id = d.issued_id
WHERE d.return_date IS NULL
AND
 DATEDIFF(CURRENT_DATE(), a.issued_date)>30;
 
/*
Task14: Update Book Status on Return
Write a query to update the status of books in the books table to "Yes" when they are returned 
(based on entries in the return_status table).
*/

DELIMITER $$
CREATE PROCEDURE add_return_record(IN p_return_id VARCHAR(20), 
								   IN p_issued_id VARCHAR(20)
								   )
BEGIN

DECLARE v_isbn VARCHAR(50);
DECLARE v_book_name VARCHAR(100);

INSERT INTO return_status(return_id, issued_id, return_date )
VALUES(p_return_id, p_issued_id, CURRENT_DATE());
SELECT issued_book_isbn, issued_book_name
INTO v_isbn, v_book_name
FROM issued_status
WHERE issued_id = p_issued_id;

UPDATE books
SET status = 'yes'
WHERE isbn = v_isbn;
SELECT CONCAT('Thank you for returning the book: ', v_book_name) AS message;
END $$
DELIMITER ;

CALL add_return_record('RS138','IS135');

-- CHECKING THE PROCEDURE
select* from return_status
where issued_id = 'IS135';
SELECT * FROM BOOKS
WHERE isbn = '978-0-307-58837-1';

-- Task 15: Branch Performance Report
/* Create a query that generates a performance report for each branch, showing the number of books issued, 
the number of books returned, and the total revenue generated from book rentals.*/

CREATE TABLE branch_report AS
SELECT
b.branch_id,
b.manager_id,
SUM(bk.rental_price) AS "Total Revenue",
COUNT(ist.issued_id) AS "Number of Book issued",
COUNT(rs.return_id) AS "Number of book return"
FROM issued_status ist
JOIN employee e
ON e.emp_id = ist.issued_emp_id
JOIN branch b
ON e.branch_id  = b.branch_id
LEFT JOIN return_status rs
ON rs.issued_id = ist.issued_id
JOIN books bk
ON bk.isbn = ist.issued_book_isbn
GROUP BY 1,2;

SELECT* FROM branch_report;

/*Task 16: CTAS: Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members 
containing members who have issued at least one book in the last 6 months.*/

CREATE TABLE active_members AS
SELECT * from members where member_id in (
SELECT 
issued_member_id
FROM 
issued_status
WHERE issued_date >= DATE_SUB(curdate(),INTERVAL 6 MONTH));

SELECT * FROM active_members;

/*
Task 17: Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. 
Display the employee name, number of books processed, and their branch.
*/

SELECT
b.emp_name,
COUNT(a.issued_id) AS "Number of Books issued",
c.branch_id,
c.branch_address
FROM issued_status a
JOIN employee b
ON a.issued_emp_id = b.emp_id
JOIN branch c
ON b.branch_id = c.branch_id
GROUP BY b.emp_name,c.branch_id,
c.branch_address
ORDER BY 2 DESC LIMIT 3;

/*Task 18: Stored Procedure Objective: 
Create a stored procedure to manage the status of books in a library system.
Description: Write a stored procedure that updates the status of a book in the library based on its issuance. 
The procedure should function as follows: The stored procedure should take the book_id as an input parameter. 
The procedure should first check if the book is available (status = 'yes'). If the book is available, it should be issued, and the status in the books table should be updated to 'no'. 
If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
*/

DELIMITER $$
CREATE PROCEDURE issue_book(
    IN p_issued_id VARCHAR(10), 
    IN p_issued_member_id VARCHAR(30), 
    IN p_issued_book_isbn VARCHAR(30), 
    IN p_issued_emp_id VARCHAR(10)
)
BEGIN
    DECLARE v_status VARCHAR(10);
    SELECT status INTO v_status
    FROM books
    WHERE isbn = p_issued_book_isbn;

    IF v_status = 'yes' THEN
    
        INSERT INTO issued_status(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
        VALUES (p_issued_id, p_issued_member_id, CURRENT_DATE(), p_issued_book_isbn, p_issued_emp_id);

        UPDATE books
        SET status = 'no'
        WHERE isbn = p_issued_book_isbn;
        SELECT CONCAT('Book record added successfully for the book ISBN ', p_issued_book_isbn) AS message;
    ELSE
        SELECT CONCAT('Sorry to inform you the requested book is not available: ISBN ', p_issued_book_isbn) AS message;
    END IF;

END$$
DELIMITER ;




 
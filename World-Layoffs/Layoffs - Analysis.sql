-- EXPLORATORY ANALYSIS




-- Company details which went under with 100% layoff
SELECT * FROM layoffs_working
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC; 


-- Top five companies with the most layoffs
SELECT company, SUM(total_laid_off) AS 'Total Layoff'
FROM layoffs_working
GROUP BY company
ORDER BY 2 DESC
LIMIT 5; 


-- The date range of the layoffs
SELECT MIN(date) AS 'Starting Date',MAX(date) AS 'End Date'
FROM layoffs_working; 


-- Industries that got the most hits
SELECT industry, SUM(total_laid_off) AS 'Total Layoffs'
FROM layoffs_working
GROUP BY industry
ORDER BY 2 DESC; 


-- Countries that got hit the most
SELECT country, SUM(total_laid_off) AS 'Total Layoffs'
FROM layoffs_working
GROUP BY country
ORDER BY 2 DESC; 


-- Year wise layoffs
SELECT YEAR(date) AS 'Year', SUM(total_laid_off) AS 'Total Layoffs'
FROM layoffs_working
WHERE YEAR(date) IS NOT NULL
GROUP BY YEAR(date)
ORDER BY 1 DESC;


-- ROLLING TOTAL OF THE TOTAL LAYOFFS
WITH cte AS (
SELECT substring(date,1,7) AS 'Month',
sum(total_laid_off) AS "Total_layoff" FROM layoffs_working
WHERE substring(date,1,7) IS NOT NULL
GROUP BY substring(date,1,7)
ORDER BY 1 ASC)
SELECT Month, 
Total_layoff,
SUM(Total_layoff)OVER(order by month) AS "Rolling_total_layoff"
FROM cte; 


-- Year-wise ranking of the top 5 companies in terms of total lay-offs
WITH CTE AS (
SELECT company,YEAR(Date) AS "Years",SUM(total_laid_off) AS "Total_layoff"
FROM layoffs_working
GROUP BY company,YEAR(Date)
ORDER BY 3 DESC),
CTE_2 AS(
SELECT *,
DENSE_RANK()OVER(PARTITION BY years ORDER BY total_layoff DESC) AS Ranking
FROM CTE
WHERE years IS NOT NULL
ORDER BY Ranking ASC)
SELECT * FROM CTE_2
WHERE Ranking <=5; 



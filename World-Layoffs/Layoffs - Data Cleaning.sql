USE world_layoffs;

-- DATA CLEANING

SELECT* FROM layoffs;

-- Creating a staging table so that the RAW Data is not affected
CREATE TABLE layoffs_2 like
layoffs;
INSERT  INTO layoffs_2 SELECT * FROM layoffs;
SELECT *
FROM layoffs_2;


-- Removing the duplicate data from our table
WITH duplicates as(
SELECT *,
ROW_NUMBER()OVER(PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off,date,stage,country,funds_raised_millions) AS rn
FROM layoffs_2)
select * from duplicates
where rn>1;

CREATE TABLE `layoffs_DEL` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
   rn INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_DEL
SELECT *,
ROW_NUMBER()OVER(PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off,date,stage,country,funds_raised_millions) AS rn
FROM layoffs_2;

SELECT*FROM layoffs_DEL
WHERE rn>1;

DELETE from layoffs_DEL
WHERE rn>1;

SELECT *FROM layoffs_DEL;

-- After deleting all the duplicates from the table 
-- The next step is to clean the data, standardizing it 
-- And remove unnecessary null and blank values.



-- Standardizing the Columns
UPDATE layoffs_DEL
SET company= trim(company);
SELECT* FROM layoffs_DEL;

UPDATE layoffs_DEL
SET industry ="Crypto"
WHERE industry LIKE "Crypto%";
SELECT *FROM layoffs_DEL;

UPDATE layoffs_DEL
SET country ="United States"
WHERE industry LIKE "United States%";
SELECT *FROM layoffs_DEL;


UPDATE layoffs_DEL
set date = str_to_date(date,'%m/%d/%Y');
ALTER TABLE layoffs_DEL
MODIFY COLUMN date DATE;
SELECT *FROM layoffs_del;



-- Checking for Nulls and Blank values
SELECT* FROM layoffs_del
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * FROM layoffs_del
WHERE industry IS NULL OR
industry ="";


UPDATE layoffs_del
SET industry = NULL
WHERE industry  = "";

SELECT * FROM layoffs_del
WHERE company = 'Airbnb';

SELECT * FROM layoffs_del a 
JOIN layoffs_del b
ON a.company=b.company AND a.location=b.location
where (a.industry IS NULL )  AND b.industry IS NOT NULL;

UPDATE layoffs_del a 
JOIN layoffs_del b 
ON a.company = b.company
SET a.industry = b.industry
WHERE (a.industry IS NULL OR a.industry = '')  AND b.industry IS NOT NULL;


-- AS we going to be analyzing this data and will be using the Total_laid_off and percentage_laid_off column
-- The instances where both are Null is not needed for our Analysis
DELETE FROM layoffs_del
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * FROM layoffs_del;
ALTER TABLE layoffs_del DROP COLUMN rn;
RENAME TABLE layoffs_del TO layoffs_working; -- Renaming the final data

SELECT * FROM layoffs_working;



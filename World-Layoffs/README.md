# World Layoffs Data Analysis

## Project Overview

This project analyzes layoffs data spanning from November 2020 to March 2023. The data was imported into MySQL from a CSV file using the Table Data Import Wizard. The project is divided into two main parts: Data Cleaning and Exploratory Analysis.

## Data Description

The dataset includes the following columns:
- `company`: Name of the company
- `location`: Location of the company
- `industry`: Industry in which the company operates
- `total_laidoff`: Total number of layoffs
- `percentage_laidoff`: Percentage of layoffs
- `date`: Date of the layoff event
- `stage`: Stage of the company (e.g., Series A, Series B, Series C, Series D, Post-IPO, Acquired)
- `country`: Country where the company is located
- `funds_raised`: Funds raised by the company

## Data Cleaning

Several steps were taken to prepare the data for analysis:

1. **Removing Duplicates**: Identified and removed any duplicate records.
2. **Handling Nulls and Blanks**: Addressed missing values and blanks to ensure data completeness.
3. **Standardizing Columns**: Standardized data formats and column names for consistency.
4. **Trimming and Normalizing**: Trimmed leading/trailing spaces and normalized text data.
5. **Preparing Data for Exploration**: Ensured data is clean and structured for meaningful analysis.

## Exploratory Analysis

The following questions were addressed through exploratory analysis:

1. **Companies with 100% Layoff**: Identified companies where the total layoffs were 100% of the workforce.
2. **Top Five Companies with the Most Layoffs**: Listed the top five companies with the highest number of layoffs.
3. **Industries Most Affected**: Analyzed which industries experienced the most layoffs.
4. **Countries Most Affected**: Determined which countries were hit hardest by layoffs.
5. **Year-Wise Layoffs (2023)**: Analyzed layoffs data for the year 2023, considering only three months of data.
6. **Rolling Total of Layoffs**: Computed the rolling total of layoffs over the available period.
7. **Year-Wise Ranking of Top 5 Companies**: Ranked the top five companies in terms of total layoffs on a yearly basis.

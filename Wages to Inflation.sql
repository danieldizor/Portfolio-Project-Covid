Select *
From PortfolioProject2..USCPI$

Select *
From PortfolioProject2..MinimumWageData$

Select Year, State, State#Minimum#Wage as StateMinimumWage, Federal#Minimum#Wage as FederalMinimumWage, Effective#Minimum#Wage as EffectiveMinimumWage
From PortfolioProject2..MinimumWageData$

-- Ordering data in Alphabetical order

Select Year, State, State#Minimum#Wage as StateMinimumWage, Federal#Minimum#Wage as FederalMinimumWage, Effective#Minimum#Wage as EffectiveMinimumWage
From PortfolioProject2..MinimumWageData$
Order by 2, 3

-- Showing Current Minimum Wage

Select Year, State, State#Minimum#Wage as StateMinimumWage, Federal#Minimum#Wage as FederalMinimumWage, Effective#Minimum#Wage as EffectiveMinimumWage
From PortfolioProject2..MinimumWageData$ 
Where Year = 2020
Order by 2, 3

-- Ordering States in order from Highest to Lowest Minimum Wage

Select Year, State, State#Minimum#Wage as StateMinimumWage, Federal#Minimum#Wage as FederalMinimumWage, Effective#Minimum#Wage as EffectiveMinimumWage
From PortfolioProject2..MinimumWageData$ 
Where Year = 2020
Order by 5 desc


-- Looking at CPI
-- Convert date to remove "00:00:00.000"


Select CAST(Yearmon as Date) as Date, CPI
From PortfolioProject2..USCPI$

-- Setting Year to 1968 to match with Minimum Wage Data
-- Convert date to show only year

Select Year(Yearmon) as Year, CPI
From PortfolioProject2..USCPI$
Where Yearmon >= '1968'

-- Averaging CPI for each year

Select Year(Yearmon) as Year, Avg(CPI) as Avg_CPI
From PortfolioProject2..USCPI$
Where Yearmon between '1968' AND '2020'
Group by Year(Yearmon)
Order by 1, 2

-- Calculating Yearly Percentage Increase of Inflation

Select Year(Yearmon) as Year, Avg(CPI) as AvgCPI, 
((Avg(CPI) - Lag(Avg(CPI), 1) over (ORDER BY Year(Yearmon))) / (LAG(Avg(CPI), 1) over (ORDER BY Year(Yearmon))) *100) as Growth
From PortfolioProject2..USCPI$
Where Yearmon between '1968' AND '2020'
Group by Year(Yearmon)
Order by 1, 2

-- Calculating Yearly Percentage Increase of Federal Minimum Wage

Select Year(Yearmon) as Year, Avg(CPI) as AvgCPI, 
((Avg(CPI) - Lag(Avg(CPI), 1) over (ORDER BY Year(Yearmon))) / (LAG(Avg(CPI), 1) over (ORDER BY Year(Yearmon))) *100) as Growth
From PortfolioProject2..USCPI$
Where Yearmon between '1968' AND '2020'
Group by Year(Yearmon)
Order by 1, 2





-- Queries to use for Tableau --





-- Effective Minimum Wage for States

Create View StateMinimumWage as
Select Year, State, Effective#Minimum#Wage as EffectiveMinimumWage
From PortfolioProject2..MinimumWageData$

-- Effective Minimum Wage for States in 2020

Create View CurrentStateMinimumWage as
Select Year, State, Effective#Minimum#Wage as EffectiveMinimumWage
From PortfolioProject2..MinimumWageData$
Where Year = 2020

-- Federal Minimum Wage

Create View FederalMinimumWage as
Select Distinct Year, Federal#Minimum#Wage as FederalMinimumWage
From PortfolioProject2..MinimumWageData$


-- Average Yearly Inflation

Create View AverageYearlyInflation as
Select Year(Yearmon) as Year, Avg(CPI) as Avg_CPI
From PortfolioProject2..USCPI$
Where Yearmon between '1968' AND '2020'
Group by Year(Yearmon)

-- Average Percentage Growth of Inflation

Create View AveragePercentInflationGrowth as
Select Year(Yearmon) as Year, Avg(CPI) as AvgCPI, 
((Avg(CPI) - Lag(Avg(CPI), 1) over (ORDER BY Year(Yearmon))) / (LAG(Avg(CPI), 1) over (ORDER BY Year(Yearmon))) *100) as Growth
From PortfolioProject2..USCPI$
Where Yearmon between '1968' AND '2020'
Group by Year(Yearmon)
# Standardizing column names

CREATE OR REPLACE TABLE `beyondmeat-project.beyond_data.balance_sheet` AS
SELECT
  `Year` as year,
  `Total Debt` as total_debt,
  `Stockholders Equity` as stakeholder_equity,
  `Retained Earnings` as retained_earnings,
  `Long Term Debt` as long_term_debt,
  `Current Liabilities` as current_liabilities,
  `Current Assets` as current_assets,
  `Total Non Current Assets` as total_non_current_assets,
  `Total Assets` as total_assets
FROM 
  `beyondmeat-project.beyond_data.balance_sheet`;


CREATE OR REPLACE TABLE `beyondmeat-project.beyond_data.income_statement` AS
SELECT
  `Year` as year,
  `EBIT` as EBIT,
  `EPS` as EPS,
  `Net Income` as net_income,
  `Gross Profit` as gross_profit,
  `COGS` as COGS,
  `Total Revenue` as total_revenue
FROM 
  `beyondmeat-project.beyond_data.income_statement`;


CREATE OR REPLACE TABLE `beyondmeat-project.beyond_data.cash_flow` AS
SELECT
  `Year` as year,
  `Net Change in Cash` as net_change_in_cash,
  `Cash Flow from Financing Activities` as cash_flow_from_financing_activities,
  `Cash Flow from Investing Activities` as cash_flow_from_investing_activities,
  `Cash Flow from Operating Activities` as cash_flow_from_operating_activities,
FROM 
  `beyondmeat-project.beyond_data.cash_flow`;


# Deleting NULL values

DELETE FROM `beyondmeat-project.beyond_data.balance_sheet`
WHERE year IS NULL;

# Adding Inventory column to table

ALTER TABLE `beyondmeat-project.beyond_data.balance_sheet`
ADD COLUMN inventory INT64;

UPDATE `beyondmeat-project.beyond_data.balance_sheet`
SET inventory = 241870000
WHERE year = '2021-12-31';



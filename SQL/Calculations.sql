# INCOME STATEMENT

# Revenue growth rate, interest coverage ratio, gross/operating/net margins

SELECT 
    year, 
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY year) as previous_year_revenue,
    ROUND((total_revenue - LAG(total_revenue) OVER (ORDER BY year)) / 
      LAG(total_revenue) OVER (ORDER BY year), 2) AS revenue_growth_rate,
    ROUND((EBIT / NULLIF(interest_expense, 0)), 2) as interest_coverage_ratio,
    ROUND(gross_profit/total_revenue * 100, 2) AS gross_margin,
    ROUND(EBIT/total_revenue * 100, 2) AS operating_margin,
    ROUND(net_income/total_revenue * 100, 2) AS net_margin
FROM `beyondmeat-project.beyond_data.income_statement`
ORDER BY
  year;

#____________________________________________________________________________________
# BALANCE SHEET

# Current, Quick, Debt, Leverage, Debt / Equity Ratios

SELECT
  year,
  ROUND(current_assets/current_liabilities, 2) as current_ratio,
  ROUND((current_assets-inventory)/current_liabilities, 2) as quick_ratio,
  ROUND(total_debt/stakeholder_equity, 2) as debt_to_equity_ratio,
  ROUND(total_debt/total_assets, 2) as debt_ratio,
  ROUND(total_assets/stakeholder_equity, 2) as leverage_ratio
FROM `beyondmeat-project.beyond_data.balance_sheet`
ORDER BY
  year;

#____________________________________________________________________________________
# CASH FLOWS

# FCF (Free Cash Flow)

SELECT
  year,
  COALESCE(cash_flow_from_operating_activities - CapEx, 0) as FCF 
FROM `beyondmeat-project.beyond_data.cash_flow`
ORDER BY
  year;

#____________________________________________________________________________________
# JOINS

# ROA, ROE, DSO, inventory turnover ratio, operating cash flow / net income ratio

SELECT 
    i.year, 
    ROUND(i.net_income/b.total_assets, 2) AS ROA,
    ROUND(i.net_income/b.stakeholder_equity, 2) AS ROE,
    ROUND((b.accounts_receivable / NULLIF(i.total_revenue, 0)) * 365, 2) AS DSO,
    ROUND(i.COGS / NULLIF(((b.inventory + LAG(b.inventory) OVER (ORDER BY i.year)) / 2), 0), 2) as inventory_turnover_ratio,
    ROUND((cf.cash_flow_from_operating_activities/i.net_income), 2) AS operating_cash_flow_to_net_income_ratio
FROM `beyondmeat-project.beyond_data.income_statement` i
JOIN `beyondmeat-project.beyond_data.balance_sheet` b ON i.year = b.year
JOIN `beyondmeat-project.beyond_data.cash_flow` cf ON i.year = cf.year
ORDER BY
  year;










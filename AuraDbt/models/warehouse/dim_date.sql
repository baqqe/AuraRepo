SELECT
  TO_CHAR(d, 'YYYY-MM-DD') AS id,
  d AS full_date,
  EXTRACT(YEAR FROM d) AS year,
  TO_CHAR(d, 'IW') AS year_week,
  EXTRACT(DAY FROM d) AS year_day,
  EXTRACT(YEAR FROM d) AS fiscal_year,
  TO_CHAR(d, 'Q') AS fiscal_qtr,
  EXTRACT(MONTH FROM d) AS month,
  TO_CHAR(d, 'MMMM') AS month_name,
  TO_CHAR(d, 'D') AS week_day,
  TO_CHAR(d, 'DAY') AS day_name,
  IFF(TO_CHAR(d, 'DAY') IN ('SUNDAY', 'SATURDAY'), 0, 1) AS day_is_weekday
FROM (
  SELECT 
    SEQ4() AS index,
    DATEADD('day', index, '2014-01-01'::date) AS d
  FROM TABLE(GENERATOR(ROWCOUNT => 13149))  -- Replace 13149 with the computed number of days if needed
) t

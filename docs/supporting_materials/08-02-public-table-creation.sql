-- This query will create a table consisting of sample training data points for the logistic regression example.
CREATE OR REPLACE TABLE public.ecommerce_training_sample
AS
SELECT * FROM
# features
(SELECT
 fullVisitorId,
 IFNULL(totals.bounces, 0) AS bounces,
 IFNULL(totals.timeOnSite, 0) AS time_on_site
FROM `data-to-insights.ecommerce.web_analytics`
WHERE totals.newVisits = 1
  AND date BETWEEN '20160801' AND '20170430') # train on first 9 months
JOIN
(SELECT
 fullvisitorid,
 IF(COUNTIF(totals.transactions > 0 AND totals.newVisits IS NULL) > 0, 1, 0) AS will_buy_on_return_visit
FROM `data-to-insights.ecommerce.web_analytics`
GROUP BY fullvisitorid)
USING (fullVisitorId);

-- This query will create a table consisting of sample evaluation data points for the logistic regression example.
CREATE OR REPLACE TABLE public.ecommerce_eval_sample
AS
SELECT * FROM
# features
(SELECT
 fullVisitorId,
 IFNULL(totals.bounces, 0) AS bounces,
 IFNULL(totals.timeOnSite, 0) AS time_on_site
FROM `data-to-insights.ecommerce.web_analytics`
WHERE totals.newVisits = 1
  AND date BETWEEN '20170501' AND '20170630') # eval on 2 months
JOIN
(SELECT
 fullvisitorid,
 IF(COUNTIF(totals.transactions > 0 AND totals.newVisits IS NULL) > 0, 1, 0) AS will_buy_on_return_visit
FROM `data-to-insights.ecommerce.web_analytics`
GROUP BY fullvisitorid)
USING (fullVisitorId);

  -- This query will create a table consisting of sample test data points for the logistic regression example.
CREATE OR REPLACE TABLE public.ecommerce_test_sample
AS
SELECT * FROM
# features
(SELECT
 fullVisitorId,
 IFNULL(totals.bounces, 0) AS bounces,
 IFNULL(totals.timeOnSite, 0) AS time_on_site
FROM `data-to-insights.ecommerce.web_analytics`
WHERE totals.newVisits = 1
  AND date BETWEEN '20170701' AND '20170801') # test 1 month
JOIN
(SELECT
 fullvisitorid,
 IF(COUNTIF(totals.transactions > 0 AND totals.newVisits IS NULL) > 0, 1, 0) AS will_buy_on_return_visit
FROM `data-to-insights.ecommerce.web_analytics`
GROUP BY fullvisitorid)
USING (fullVisitorId);

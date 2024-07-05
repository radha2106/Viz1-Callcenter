SELECT *
FROM sharelove.monthly_metric_emails
//////////////////////////////////
SELECT
	CAST(DATE_TRUNC('month',ddate) + INTERVAL '1 month - 1 day' AS DATE) AS eomonth,agent_id,catg_id,
	COUNT(CASE WHEN rate='Yes' THEN 1 ELSE NULL END) AS yes_emails,
	COUNT(CASE WHEN rate='No' THEN 1 ELSE NULL END) AS no_emails
FROM 
	sharelove.emails
GROUP BY
	1,2,3
ORDER BY
	eomonth ASC,catg_id ASC
/////////////////////////////////
SELECT
  CAST(DATE_TRUNC('month',ddate) + INTERVAL '1 month - 1 day' AS DATE) AS eomonth,agent_id,catg_id,
  COUNT(CASE WHEN rating='Yes' THEN 1 ELSE NULL END) AS yes_calls,
  COUNT(CASE WHEN rating='No' THEN 1 ELSE NULL END) AS no_calls,
  AVG(aht) AS avg_time_on_call
FROM sharelove.phone
GROUP BY 1,2,3
ORDER BY 1,3
///////////////////////////////////////
SELECT
  CAST(DATE_TRUNC('month',ddate) + INTERVAL '1 month - 1 day' AS DATE) AS eomonth,agent_id,catg_id,
  COUNT(CASE WHEN rating='Yes' THEN 1 ELSE NULL END) AS yes_chats,
  COUNT(CASE WHEN rating='No' THEN 1 ELSE NULL END) AS no_chats,
  AVG(aht) AS avg_time_on_chat
FROM sharelove.chat
GROUP BY 1,2,3
ORDER BY 1,3
///////////////////////////////////////////////
SELECT ddate, COUNT(*) AS totals_emails
FROM sharelove.emails
GROUP BY 1
ORDER BY ddate ASC
///////////////////////////////////////////
SELECT ddate, COUNT(*) AS totals_emails
FROM sharelove.phone
GROUP BY 1
ORDER BY ddate ASC
/////////////////////////////////////
SELECT ddate, COUNT(*) AS totals_emails
FROM sharelove.chat
GROUP BY 1
ORDER BY ddate ASC
////////////////////////////////////////
SELECT 
CAST(DATE_TRUNC('month',ddate) + INTERVAL '1 month - 1 day' AS DATE) AS eomonth,agent_id,lob,
ROUND(SUM(score1+score2)/COUNT(ddate)/2,0) AS monthly_score
FROM sharelove.qa
GROUP BY 1,2,3
ORDER BY eomonth ASC,lob ASC
/////////////////////////////////////////
SELECT idx, catg
FROM sharelove.modes;
/////////////////////////////
SELECT emp_code, CONCAT_WS(' ',first_name,last_name) AS agent_name, lob,hire_date
FROM sharelove.agents
ORDER BY idx ASC
/////////////////////////////////////////
SELECT *
FROM sharelove.workday_absences_phones
UNION ALL
SELECT *
FROM sharelove.workday_absences_emails
UNION ALL
SELECT *
FROM sharelove.workday_absences_chat

-- DROP VIEW sharelove.monthly_metric_emails;
CREATE OR REPLACE VIEW sharelove.monthly_metric_emails
AS
WITH metric AS (
SELECT to_char(date_trunc('MONTH'::text, emails.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date AS eomonth,
emails.agent_id,
count(*) AS emails_sent,
count(DISTINCT emails.ddate) AS worked_days
FROM sharelove.emails
GROUP BY (to_char(date_trunc('MONTH'::text, emails.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date), emails.agent_id
ORDER BY (to_char(date_trunc('MONTH'::text, emails.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date))
SELECT eomonth,
agent_id,
emails_sent,
CASE
WHEN to_number(agent_id::text, '999'::text) < 86::numeric AND date_part('month'::text, eomonth) < 4::double precision THEN 48 * worked_days
WHEN to_number(agent_id::text, '999'::text) < 86::numeric AND date_part('month'::text, eomonth) < 7::double precision THEN 72 * worked_days
WHEN to_number(agent_id::text, '999'::text) < 86::numeric AND date_part('month'::text, eomonth) > 6::double precision THEN 96 * worked_days
WHEN to_number(agent_id::text, '999'::text) > 85::numeric AND date_part('month'::text, eomonth) < 10::double precision THEN 48 * worked_days
WHEN to_number(agent_id::text, '999'::text) > 85::numeric AND date_part('month'::text, eomonth) > 9::double precision THEN 72 * worked_days
ELSE NULL::bigint
END AS goal
FROM metric;
---------------------------------------------------
-- DROP VIEW sharelove.workday_absences_chat;
CREATE OR REPLACE VIEW sharelove.workday_absences_chat
AS
WITH workdays AS (
SELECT to_char(date_trunc('MONTH'::text, chat.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date AS eomonth,
chat.agent_id,
count(DISTINCT chat.ddate) AS workdays
FROM sharelove.chat
GROUP BY (to_char(date_trunc('MONTH'::text, chat.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date), chat.agent_id
ORDER BY (to_char(date_trunc('MONTH'::text, chat.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date)), 
absences AS (
SELECT to_char(date_trunc('MONTH'::text, absences.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date AS eomonth,
absences.agent_id,
count(DISTINCT absences.ddate) AS absences
FROM sharelove.absences
GROUP BY (to_char(date_trunc('MONTH'::text, absences.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date), absences.agent_id
ORDER BY (to_char(date_trunc('MONTH'::text, absences.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date))
SELECT wk.eomonth,
wk.agent_id,
wk.workdays,
ab.absences
FROM workdays wk
JOIN absences ab ON wk.agent_id::text = ab.agent_id::text AND ab.eomonth = wk.eomonth
GROUP BY wk.eomonth, wk.agent_id, wk.workdays, ab.absences;
--------------------------------------------------------------
-- DROP VIEW sharelove.workday_absences_emails;
CREATE OR REPLACE VIEW sharelove.workday_absences_emails
AS
WITH workdays AS (
SELECT to_char(date_trunc('MONTH'::text, emails.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date AS eomonth,
 emails.agent_id,
count(DISTINCT emails.ddate) AS workdays
FROM sharelove.emails
GROUP BY (to_char(date_trunc('MONTH'::text, emails.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date), emails.agent_id
ORDER BY (to_char(date_trunc('MONTH'::text, emails.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date)), 
absences AS (
SELECT to_char(date_trunc('MONTH'::text, absences.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date AS eomonth,
absences.agent_id,
count(DISTINCT absences.ddate) AS absences
FROM sharelove.absences
GROUP BY (to_char(date_trunc('MONTH'::text, absences.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date), absences.agent_id
ORDER BY (to_char(date_trunc('MONTH'::text, absences.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date))
SELECT wk.eomonth,
wk.agent_id,
wk.workdays,
ab.absences
FROM workdays wk
JOIN absences ab ON wk.agent_id::text = ab.agent_id::text AND ab.eomonth = wk.eomonth
GROUP BY wk.eomonth, wk.agent_id, wk.workdays, ab.absences;
---------------------------------------------------------------
-- DROP VIEW sharelove.workday_absences_phones;
CREATE OR REPLACE VIEW sharelove.workday_absences_phones
AS
WITH workdays AS (
SELECT to_char(date_trunc('MONTH'::text, phone.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date AS eomonth,
phone.agent_id,
count(DISTINCT phone.ddate) AS workdays
FROM sharelove.phone
GROUP BY (to_char(date_trunc('MONTH'::text, phone.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date), phone.agent_id
ORDER BY (to_char(date_trunc('MONTH'::text, phone.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date)), 
absences AS (
SELECT to_char(date_trunc('MONTH'::text, absences.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date AS eomonth,
absences.agent_id,
count(DISTINCT absences.ddate) AS absences
FROM sharelove.absences
GROUP BY (to_char(date_trunc('MONTH'::text, absences.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date), absences.agent_id
ORDER BY (to_char(date_trunc('MONTH'::text, absences.ddate::timestamp with time zone) + '1 mon -1 days'::interval, 'YYYY-MM-DD'::text)::date))
SELECT wk.eomonth,
wk.agent_id,
wk.workdays,
ab.absences
FROM workdays wk
JOIN absences ab ON wk.agent_id::text = ab.agent_id::text AND ab.eomonth = wk.eomonth
GROUP BY wk.eomonth, wk.agent_id, wk.workdays, ab.absences;






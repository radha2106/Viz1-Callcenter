CREATE INDEX IF NOT EXISTS agent_absence
ON sharelove.absences USING btree
(agent_id COLLATE pg_catalog."default" ASC NULLS LAST)
---------------------------------------------
CREATE INDEX IF NOT EXISTS date_absence
ON sharelove.absences USING btree
(ddate ASC NULLS LAST)
----------------------------------------------
CREATE INDEX IF NOT EXISTS departments
ON sharelove.agents USING btree
(lob COLLATE pg_catalog."default" ASC NULLS LAST)
------------------------------------------
CREATE INDEX IF NOT EXISTS fullnames
ON sharelove.agents USING btree
(first_name COLLATE pg_catalog."default" ASC NULLS LAST, 
last_name COLLATE pg_catalog."default" ASC NULLS LAST)
------------------------------------------------
CREATE INDEX IF NOT EXISTS agent_on_chat
ON sharelove.chat USING btree
(agent_id COLLATE pg_catalog."default" ASC NULLS LAST)
------------------------------------------------
CREATE INDEX IF NOT EXISTS category_on_chat
ON sharelove.chat USING btree
(catg_id ASC NULLS LAST)
------------------------------------------------
CREATE INDEX IF NOT EXISTS date_chat
ON sharelove.chat USING btree
(ddate ASC NULLS LAST)
----------------------------------
CREATE INDEX IF NOT EXISTS agent_on_email
ON sharelove.emails USING btree
(agent_id COLLATE pg_catalog."default" ASC NULLS LAST)
---------------------------------
CREATE INDEX IF NOT EXISTS category_on_email
ON sharelove.emails USING btree
(catg_id ASC NULLS LAST)
-----------------------------
CREATE INDEX IF NOT EXISTS date_sent
ON sharelove.emails USING btree
(ddate ASC NULLS LAST)
----------------------------------------
CREATE INDEX IF NOT EXISTS category_name
ON sharelove.modes USING btree
(catg COLLATE pg_catalog."default" ASC NULLS LAST)
---------------------------------------
CREATE INDEX IF NOT EXISTS agent_on_phone
ON sharelove.phone USING btree
(agent_id COLLATE pg_catalog."default" ASC NULLS LAST)
----------------------------------------------
CREATE INDEX IF NOT EXISTS category_on_phone
ON sharelove.phone USING btree
(catg_id ASC NULLS LAST)
------------------------------------------
CREATE INDEX IF NOT EXISTS date_call
ON sharelove.phone USING btree
(ddate ASC NULLS LAST)
---------------------------------------------
CREATE INDEX IF NOT EXISTS agent_scored
ON sharelove.qa USING btree
(agent_id COLLATE pg_catalog."default" ASC NULLS LAST)
---------------------------------------------------------
CREATE INDEX IF NOT EXISTS date_score
ON sharelove.qa USING btree
(ddate ASC NULLS LAST)
//////////////////////////////////////////
CREATE OR REPLACE TRIGGER chat_agents
BEFORE INSERT OR UPDATE 
ON sharelove.chat
FOR EACH ROW
EXECUTE FUNCTION sharelove.checking_chat_agents();
-----------------------------------------------
CREATE OR REPLACE TRIGGER email_agents
BEFORE INSERT OR UPDATE 
ON sharelove.emails
FOR EACH ROW
EXECUTE FUNCTION sharelove.checking_emails_agents();
----------------------------------------------
CREATE OR REPLACE TRIGGER phone_agents
BEFORE INSERT OR UPDATE 
ON sharelove.phone
FOR EACH ROW
EXECUTE FUNCTION sharelove.checking_phone_agents();
/////////////////////////////////////
CREATE OR REPLACE FUNCTION sharelove.checking_chat_agents()
RETURNS trigger
LANGUAGE 'plpgsql'
COST 100
VOLATILE NOT LEAKPROOF
AS
BEGIN
IF NOT EXISTS (
SELECT emp_code
FROM sharelove.agents
WHERE emp_code = NEW.agent_id AND lob = 'chat') 
THEN
RAISE EXCEPTION 'Agent is not in the "chat" department';
END IF;
RETURN NEW;
END;
---------------------------------------------------
CREATE OR REPLACE FUNCTION sharelove.checking_emails_agents()
RETURNS trigger
LANGUAGE 'plpgsql'
COST 100
VOLATILE NOT LEAKPROOF
AS
BEGIN
IF NOT EXISTS (
SELECT emp_code
FROM sharelove.agents
WHERE emp_code = NEW.agent_id AND lob = 'emails') 
THEN
RAISE EXCEPTION 'Agent is not in the "emails" department';
END IF;
RETURN NEW;
END;
---------------------------------------------------
CREATE OR REPLACE FUNCTION sharelove.checking_phone_agents()
RETURNS trigger
LANGUAGE 'plpgsql'
COST 100
VOLATILE NOT LEAKPROOF
AS
BEGIN
IF NOT EXISTS (
SELECT emp_code
FROM sharelove.agents
WHERE emp_code = NEW.agent_id AND lob = 'phone') 
THEN
RAISE EXCEPTION 'Agent is not in the "phone" department';
END IF;
RETURN NEW;
END;

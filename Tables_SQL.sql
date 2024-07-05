CREATE TABLE IF NOT EXISTS sharelove.absences
(
idx bigint NOT NULL DEFAULT nextval('sharelove.absences_idx_seq'::regclass),
ddate date NOT NULL,
agent_id character varying(25) COLLATE pg_catalog."default" NOT NULL,
lob character varying(10) COLLATE pg_catalog."default" NOT NULL,
CONSTRAINT absences_idx_key UNIQUE (idx),
CONSTRAINT fk_agents FOREIGN KEY (agent_id)
REFERENCES sharelove.agents (emp_code) MATCH SIMPLE
ON UPDATE CASCADE
ON DELETE RESTRICT
NOT VALID
)
-------------------------------------------------
CREATE TABLE IF NOT EXISTS sharelove.agents
(
idx bigint NOT NULL DEFAULT nextval('sharelove.absences_idx_seq'::regclass),
emp_code character varying(25) COLLATE pg_catalog."default" NOT NULL GENERATED ALWAYS AS ((((idx)::text || "left"((first_name)::text, 1)) || "left"((last_name)::text, 1))) STORED,
first_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
last_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
lob character varying(10) COLLATE pg_catalog."default",
wave character varying(10) COLLATE pg_catalog."default",
hire_date date,
CONSTRAINT agents2_pkey PRIMARY KEY (emp_code),
CONSTRAINT agents2_idx_key UNIQUE (idx)
)
--------------------------------------------------
CREATE TABLE IF NOT EXISTS sharelove.chat
(
idx integer NOT NULL DEFAULT nextval('sharelove.chat_idx_seq'::regclass),
ddate date NOT NULL,
agent_id character varying(25) COLLATE pg_catalog."default" NOT NULL,
catg_id bigint,
rating character varying(10) COLLATE pg_catalog."default",
aht time without time zone NOT NULL,
CONSTRAINT chat_idx_key UNIQUE (idx),
CONSTRAINT fk_agents FOREIGN KEY (agent_id)
REFERENCES sharelove.agents (emp_code) MATCH SIMPLE
ON UPDATE CASCADE
ON DELETE RESTRICT,
CONSTRAINT fk_modes FOREIGN KEY (catg_id)
REFERENCES sharelove.modes (idx) MATCH SIMPLE
ON UPDATE CASCADE
ON DELETE RESTRICT,
CONSTRAINT rating CHECK (rating::text = ANY (ARRAY['Yes'::character varying::text, 'No'::character varying::text, ' '::character varying::text]))
)
-------------------------------------------
CREATE TABLE IF NOT EXISTS sharelove.emails
(
idx bigint NOT NULL DEFAULT nextval('sharelove.emails_idx_seq'::regclass),
ddate date NOT NULL,
agent_id character varying(25) COLLATE pg_catalog."default" NOT NULL,
catg_id bigint,
rate character varying(10) COLLATE pg_catalog."default",
CONSTRAINT emails_idx_key UNIQUE (idx),
CONSTRAINT fk_agents FOREIGN KEY (agent_id)
REFERENCES sharelove.agents (emp_code) MATCH SIMPLE
ON UPDATE CASCADE
ON DELETE RESTRICT
NOT VALID,
CONSTRAINT fk_modes FOREIGN KEY (catg_id)
REFERENCES sharelove.modes (idx) MATCH SIMPLE
ON UPDATE CASCADE
ON DELETE RESTRICT
NOT VALID,
CONSTRAINT rating CHECK (rate::text = ANY (ARRAY['Yes'::character varying, 'No'::character varying, ' '::character varying]::text[])) NOT VALID
)
--------------------------------------------------------
CREATE TABLE IF NOT EXISTS sharelove.modes
(
idx integer NOT NULL DEFAULT nextval('sharelove.modes_idx_seq'::regclass),
catg character varying(50) COLLATE pg_catalog."default" NOT NULL,
CONSTRAINT modes_pkey PRIMARY KEY (idx),
CONSTRAINT catg_key UNIQUE (catg)
)
---------------------------------------------
CREATE TABLE IF NOT EXISTS sharelove.phone
(
idx integer NOT NULL DEFAULT nextval('sharelove.phone_idx_seq'::regclass),
ddate date NOT NULL,
agent_id character varying(25) COLLATE pg_catalog."default" NOT NULL,
catg_id bigint,
rating character varying(10) COLLATE pg_catalog."default",
aht time without time zone NOT NULL,
CONSTRAINT phone_idx_key UNIQUE (idx),
CONSTRAINT fk_agents FOREIGN KEY (agent_id)
REFERENCES sharelove.agents (emp_code) MATCH SIMPLE
ON UPDATE CASCADE
ON DELETE RESTRICT,
CONSTRAINT fk_modes FOREIGN KEY (catg_id)
REFERENCES sharelove.modes (idx) MATCH SIMPLE
ON UPDATE CASCADE
ON DELETE RESTRICT,
CONSTRAINT rating CHECK (rating::text = ANY (ARRAY['Yes'::character varying::text, 'No'::character varying::text, ' '::character varying::text]))
)
-----------------------------------------------
CREATE TABLE IF NOT EXISTS sharelove.qa
(
idx integer NOT NULL DEFAULT nextval('sharelove.qa_idx_seq'::regclass),
ddate date NOT NULL,
agent_id character varying(50) COLLATE pg_catalog."default" NOT NULL,
lob character varying(10) COLLATE pg_catalog."default",
score1 bigint,
score2 bigint,
CONSTRAINT qa_idx_key UNIQUE (idx),
CONSTRAINT fk_agents FOREIGN KEY (agent_id)
REFERENCES sharelove.agents (emp_code) MATCH SIMPLE
ON UPDATE CASCADE
ON DELETE RESTRICT
NOT VALID,
CONSTRAINT score1 CHECK (score1 >= 70 AND score1 <= 100),
CONSTRAINT score2 CHECK (score2 >= 70 AND score2 <= 100)
)

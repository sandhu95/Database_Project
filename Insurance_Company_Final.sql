/* This line to create the database.
create database INSURANCE_COMPANY */

/* This line to erase the database.
Drop database INSURANCE_COMPANY */

USE INSURANCE_COMPANY;

-- TABLE DEPARTMENT
CREATE TABLE DEPARTMENT
(  -- The departmet_id could be a varchar idetifier
   department_id	INTEGER	        NOT NULL	IDENTITY(1,1),
   department_name	VARCHAR(256)	NOT NULL,
   usr_create       VARCHAR(3)      NOT NULL,
   date_create      DATE            NOT NULL DEFAULT GETDATE(),
   usr_update       VARCHAR(3)      NOT NULL,
   date_update      DATE            NOT NULL  DEFAULT GETDATE() 
);

-- ADD PRIMARY KEY
ALTER TABLE DEPARTMENT 
  ADD CONSTRAINT department_department_id_pk
      PRIMARY KEY( department_id );

-- ADD DATE_UPDATE CONSTRAINT - IT COULD NOT BE BEFORE DATE_CREATE
ALTER TABLE DEPARTMENT
	ADD CONSTRAINT chk_date_update
   CHECK (date_update >= date_create)

-- TABLE CATEGORY
CREATE TABLE CATEGORY
(  category_id	    VARCHAR(3)	    NOT NULL,
   category_name	VARCHAR(256)	NOT NULL,
   monthly_price    NUMERIC(6,2)    NOT NULL,
   coverage         DECIMAL(14,2)   NOT NULL,
   term             INTEGER         NOT NULL,
   usr_create       VARCHAR(3)      NOT NULL,
   date_create      DATE            NOT NULL DEFAULT GETDATE(),
   usr_update       VARCHAR(3)      NOT NULL,
   date_update      DATE            NOT NULL DEFAULT GETDATE()
);

ALTER TABLE CATEGORY 
  ADD CONSTRAINT category_category_id_pk
      PRIMARY KEY( category_id );

-- TABLE SPONSOR
CREATE TABLE SPONSOR
(  sponsor_id		INTEGER	        NOT NULL	IDENTITY(1,1),
   company_name		VARCHAR(256)	NOT NULL,
   email			VARCHAR(256),
   phone			INTEGER	        NOT NULL,
   sales_rep		VARCHAR(256),
   address			VARCHAR(256)	NOT NULL,
   usr_create       VARCHAR(3)      NOT NULL,
   date_create      DATE            NOT NULL DEFAULT GETDATE(),
   usr_update       VARCHAR(3)      NOT NULL,
   date_update      DATE            NOT NULL DEFAULT GETDATE()
);

ALTER TABLE SPONSOR 
  ADD CONSTRAINT sponsor_sponsor_id_pk
      PRIMARY KEY( sponsor_id );

-- TABLE COUNTRY
CREATE TABLE COUNTRY
(  -- the country_id could be a varchar column too.
   country_id	    INTEGER	        NOT NULL    IDENTITY(1,1),
   country_name	    VARCHAR(256)	NOT NULL,
   usr_create       VARCHAR(3)      NOT NULL,
   date_create      DATE            NOT NULL DEFAULT GETDATE(),
   usr_update       VARCHAR(3)      NOT NULL,
   date_update      DATE            NOT NULL DEFAULT GETDATE()
);

ALTER TABLE COUNTRY 
  ADD CONSTRAINT country_country_id_pk
      PRIMARY KEY( country_id );

-- TABLE PROVINCE
CREATE TABLE PROVINCE
(  --The province_id could be a varchar too.
   province_id	    INTEGER	        NOT NULL IDENTITY(1,1),
   province_name	VARCHAR(256)	NOT NULL,
   country_id	    INTEGER	        NOT NULL,
   usr_create       VARCHAR(3)      NOT NULL,
   date_create      DATE            NOT NULL DEFAULT GETDATE(),
   usr_update       VARCHAR(3)      NOT NULL,
   date_update      DATE            NOT NULL DEFAULT GETDATE()
);

ALTER TABLE PROVINCE 
  ADD CONSTRAINT province_province_id_pk
      PRIMARY KEY( province_id );

ALTER TABLE PROVINCE
  ADD CONSTRAINT province_country_id_fk
      FOREIGN KEY( country_id )
      REFERENCES country( country_id );

--TABLE CITY
CREATE TABLE CITY
(  city_id	        INTEGER	        NOT NULL IDENTITY(1,1),
   city_name	    VARCHAR(256)    NOT NULL,
   province_id	    INTEGER	        NOT NULL,
   usr_create       VARCHAR(3)      NOT NULL,
   date_create      DATE            NOT NULL DEFAULT GETDATE(),
   usr_update       VARCHAR(3)      NOT NULL,
   date_update      DATE            NOT NULL DEFAULT GETDATE()
);

ALTER TABLE CITY 
  ADD CONSTRAINT city_city_id_pk
      PRIMARY KEY( city_id );

ALTER TABLE CITY
  ADD CONSTRAINT city_province_id_fk
      FOREIGN KEY( province_id )
      REFERENCES province( province_id );

--TABLE PRODUCT
CREATE TABLE PRODUCT
(  product_id				INTEGER	NOT NULL	IDENTITY(1,1),
   name						VARCHAR(256)	NOT NULL,
   description				VARCHAR(8000)	NOT NULL, 
   definition				VARCHAR(8000)	NOT NULL,
   limits					VARCHAR(8000)	NOT NULL,
   exclusions				VARCHAR(8000)	NOT NULL,
   general_condition		VARCHAR(8000)	NOT NULL,
   indenization_procedure	VARCHAR(8000)	NOT NULL,
   data_protection_advice	VARCHAR(8000)	NOT NULL,
   emergency_procedure		VARCHAR(8000)	NOT NULL,
   available				BIT         	NOT NULL,
   usr_create               VARCHAR(3)      NOT NULL,
   date_create              DATE            NOT NULL DEFAULT GETDATE(),
   usr_update               VARCHAR(3)      NOT NULL,
   date_update              DATE            NOT NULL DEFAULT GETDATE()
);

ALTER TABLE PRODUCT 
  ADD CONSTRAINT product_product_id_pk
      PRIMARY KEY( product_id );

--TABLE STAFF
CREATE TABLE STAFF
(  staff_id			INTEGER	       NOT NULL	IDENTITY(1,1),
   date_of_birth	DATE	       NOT NULL,
   last_name		VARCHAR(256)   NOT NULL,
   first_name		VARCHAR(256)   NOT NULL,
   phone			NUMERIC(10,0)  NOT NULL,
   email			VARCHAR(256),
   address			VARCHAR(256)   NOT NULL,
   zipcode			VARCHAR(7)     NOT NULL,
   termination_date DATE,
   hire_date		DATE	       NOT NULL	DEFAULT getdate(),
   department_id	INTEGER        NOT NULL,
   usr_create       VARCHAR(3)     NOT NULL,
   date_create      DATE           NOT NULL DEFAULT GETDATE(),
   usr_update       VARCHAR(3)     NOT NULL,
   date_update      DATE           NOT NULL DEFAULT GETDATE()
);

ALTER TABLE STAFF 
  ADD CONSTRAINT staff_staff_id_pk
      PRIMARY KEY( staff_id );


--TABLE CUSTOMER
CREATE TABLE CUSTOMER
(  customer_id		INTEGER	        NOT NULL	IDENTITY(1,1),
   last_name		VARCHAR(256)	NOT NULL,
   first_name		VARCHAR(256)	NOT NULL,
   phone			NUMERIC(18)	    NOT NULL,
   email			VARCHAR(256),
   address			VARCHAR(256)	NOT NULL,
   zipcode			VARCHAR(9)      NOT NULL,
   date_of_birth	DATE	        NOT NULL,
   city_id			INTEGER         NOT NULL,
   usr_create       VARCHAR(3)      NOT NULL,
   date_create      DATE            NOT NULL DEFAULT GETDATE(),
   usr_update       VARCHAR(3)      NOT NULL,
   date_update      DATE            NOT NULL DEFAULT GETDATE()
);
	
ALTER TABLE CUSTOMER 
  ADD CONSTRAINT customer_customer_id_pk
      PRIMARY KEY( customer_id );

--TABLE POLICY
CREATE TABLE POLICY
(  policy_id		INTEGER	     NOT NULL	IDENTITY(1,1),
   issue_date		DATE	     NOT NULL	DEFAULT GETDATE(),
   expire_date		DATE	     NOT NULL,              
   previous_policy	INTEGER,
   staff_id			INTEGER	     NOT NULL,
   customer_id		INTEGER	     NOT NULL,
   product_id		INTEGER      NOT NULL,
   category_id      VARCHAR(3)   NOT NULL,
   cause_death_id   INTEGER,
   usr_create       VARCHAR(3)   NOT NULL,
   date_create      DATE         NOT NULL  DEFAULT GETDATE(),
   usr_update       VARCHAR(3)   NOT NULL,
   date_update      DATE         NOT NULL  DEFAULT GETDATE()
);

ALTER TABLE POLICY
ADD CONSTRAINT chkTerm_expire_date
CHECK (expire_date >= issue_date)

ALTER TABLE POLICY 
  ADD CONSTRAINT policy_policy_id_pk
      PRIMARY KEY( policy_id );


ALTER TABLE POLICY
  ADD CONSTRAINT policy_previous_policy_fk
      FOREIGN KEY( previous_policy )
      REFERENCES policy( policy_id );

ALTER TABLE POLICY
  ADD CONSTRAINT policy_staff_id_fk
      FOREIGN KEY( staff_id )
      REFERENCES staff( staff_id );

ALTER TABLE POLICY
  ADD CONSTRAINT policy_customer_id_fk
      FOREIGN KEY( customer_id )
      REFERENCES customer( customer_id );

ALTER TABLE POLICY
  ADD CONSTRAINT policy_product_id_fk
      FOREIGN KEY( product_id )
      REFERENCES product( product_id );

ALTER TABLE POLICY
  ADD CONSTRAINT policy_category_id_fk
      FOREIGN KEY( category_id )
      REFERENCES category( category_id );

ALTER TABLE STAFF
  ADD CONSTRAINT staff_department_id_fk
      FOREIGN KEY( department_id )
      REFERENCES department( department_id );

ALTER TABLE CUSTOMER
  ADD CONSTRAINT customer_city_id_fk
      FOREIGN KEY( city_id )
      REFERENCES city( city_id );

CREATE TABLE BENEFIT
(
	benefit_id           INTEGER       NOT NULL IDENTITY(1,1),
	benefit_name         VARCHAR(250)  NOT NULL,
	benefit_description  VARCHAR(3200) NOT NULL,
	usr_create           VARCHAR(3)    NOT NULL,
    date_create          DATE          NOT NULL,
    usr_update           VARCHAR(3)    NOT NULL,
    date_update          DATE          NOT NULL
);

ALTER TABLE BENEFIT 
  ADD CONSTRAINT benefit_id_pk
      PRIMARY KEY( benefit_id );

CREATE TABLE CATEGORY_BENEFIT
(
	category_ben_id         INTEGER      NOT NULL IDENTITY(1,1),
	category_id             VARCHAR(3)   NOT NULL,
	benefit_id              INTEGER      NOT NULL,
	usr_create              VARCHAR(3)   NOT NULL,
    date_create             DATE         NOT NULL,
    usr_update              VARCHAR(3)   NOT NULL,
    date_update             DATE         NOT NULL
);

ALTER TABLE CATEGORY_BENEFIT 
  ADD CONSTRAINT category_ben_id_pk
      PRIMARY KEY( category_ben_id );

ALTER TABLE CATEGORY_BENEFIT
  ADD CONSTRAINT category_catego_id_fk
      FOREIGN KEY( category_id )
      REFERENCES category ( category_id );

ALTER TABLE CATEGORY_BENEFIT
  ADD CONSTRAINT benefit_catego_id_fk
      FOREIGN KEY( benefit_id )
      REFERENCES benefit ( benefit_id );

/*
 BENEFICIARY Table

 1. add a "BENEFICIARY" and "CAUSE_OF_DEATH" tables
 2. the primary key inside "CAUSE_OF_DEATH" should be a FK inside the POLICY table*/

CREATE TABLE BENEFICIARY
(
	beneficiary_id           INTEGER        NOT NULL  IDENTITY(1,1),
	beneficiary_last_name    VARCHAR(256)   NOT NULL,
	beneficiary_name         VARCHAR(256)   NOT NULL,
	beneficiary_middle_name  VARCHAR(256),
	beneficiary_brith_day    DATE           NOT NULL,
	beneficiary_relation     VARCHAR(100)   NOT NULL,
	beneficiary_percentage   NUMERIC(5,2)   NOT NULL,
	policy_id		         INTEGER	    NOT NULL, --Foreing key with policy
	usr_create               VARCHAR(3)     NOT NULL,
    date_create              DATE           NOT NULL  DEFAULT GETDATE(),
    usr_update               VARCHAR(3)     NOT NULL,
    date_update              DATE           NOT NULL DEFAULT GETDATE()
);

ALTER TABLE BENEFICIARY 
  ADD CONSTRAINT beneficiary_id_pk
      PRIMARY KEY( beneficiary_id );

ALTER TABLE BENEFICIARY
  ADD CONSTRAINT policy_id_fk
      FOREIGN KEY( policy_id )
      REFERENCES policy ( policy_id );

/*
CAUSE_OF_DEATH Table
*/
CREATE TABLE CAUSE_OF_DEATH
(
	cause_death_id            INTEGER         NOT NULL IDENTITY(1,1),
	cause_death_description   VARCHAR(8000)   NOT NULL,
	usr_create                VARCHAR(3)     NOT NULL,
    date_create               DATE           NOT NULL  DEFAULT GETDATE(),
    usr_update                VARCHAR(3)     NOT NULL,
    date_update               DATE           NOT NULL DEFAULT GETDATE(),
	payable					  BIT			 NOT NULL
);

ALTER TABLE CAUSE_OF_DEATH 
  ADD CONSTRAINT cause_death_id_pk
      PRIMARY KEY( cause_death_id );

ALTER TABLE POLICY
  ADD CONSTRAINT cause_death_id_fk
      FOREIGN KEY( cause_death_id )
      REFERENCES CAUSE_OF_DEATH ( cause_death_id );
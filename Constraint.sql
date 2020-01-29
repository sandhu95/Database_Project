/**************************************************************************************
**01 - Constraint to avoid that the user insert an incorrect value as previous policy**
**************************************************************************************/
ALTER TABLE POLICY
  ADD CONSTRAINT policy_previous_policy_fk
      FOREIGN KEY( previous_policy )
      REFERENCES policy( policy_id );

-- TESTING THE CONSTRAINT
INSERT INTO POLICY VALUES 
   ('2019-03-21','2020-03-20',500,3,4,1,'GLD',2,'DPM',DEFAULT,'DAP','03-21-2019');
  
/* RESULT:
Msg 547, Level 16, State 0, Line 10
The INSERT statement conflicted with the FOREIGN KEY SAME TABLE constraint "policy_previous_policy_fk". 
The conflict occurred in database "INSURANCE_COMPANY", table "dbo.POLICY", column 'policy_id'.
The statement has been terminated.*/

/**********************************************************************************************
**02 - Constraint to make valid our business rule that customers need to be 18 years or older**
**Maximum 75 years old																		 **
***********************************************************************************************/
ALTER TABLE CUSTOMER
	ADD CONSTRAINT customer_date_of_birth_ck
		CHECK (date_of_birth<=GETDATE()-6570 AND date_of_birth>GETDATE()-27375)

-- TESTING THE CONSTRAINT
INSERT INTO CUSTOMER VALUES 
	('Mafra', 'Deivid',111-2222,'deividmafra@aol.com', '999, X street', 'M1Q2W3', '1900-04-06', '1','DPM', GETDATE(), 'DPM', GETDATE());

/* RESULT:
Msg 547, Level 16, State 0, Line 27
The INSERT statement conflicted with the CHECK constraint "customer_date_of_birth_ck". 
The conflict occurred in database "INSURANCE_COMPANY", table "dbo.CUSTOMER", column 'date_of_birth'.
The statement has been terminated.*/

/**********************************************************************************************
**03 - Constraint to avoid that the user insert a job ended date previously that hire date   **
***********************************************************************************************/
ALTER TABLE STAFF
	ADD CONSTRAINT staff_job_ended_ck
		CHECK(job_ended>=hire_date OR job_ended IS NULL);

-- TESTING THE CONSTRAINT
INSERT INTO STAFF VALUES 
	('1980-10-16','Walker', 'John',111-2222,'wj@aol.com', '999, X street', 'M1Q2W3', '2015-03-01', 1,'DPM', GETDATE(), 'DPM', GETDATE(), '2015-02-01');

/* RESULT:
Msg 547, Level 16, State 0, Line 44
The INSERT statement conflicted with the CHECK constraint "staff_job_ended_ck". 
The conflict occurred in database "INSURANCE_COMPANY", table "dbo.STAFF".
The statement has been terminated.*/

/**********************************************************************************************
**04 - Constraint to confirm beneficiary percentage greater then 0 and maximum 100%    ********
***********************************************************************************************/
ALTER TABLE BENEFICIARY
	ADD CONSTRAINT beneficiary_beneficiary_percentage_ck
		CHECK(beneficiary_percentage>0 AND beneficiary_percentage<=100);

-- TESTING THE CONSTRAINT
INSERT INTO BENEFICIARY VALUES 
	('Paris','Nathalia', 'Andrea', '1988-04-06', 'Spouse', 101, 14, 'DAP',GETDATE(), 'DAP',GETDATE());

/* RESULT:
Msg 547, Level 16, State 0, Line 61
The INSERT statement conflicted with the CHECK constraint "beneficiary_beneficiary_percentage_ck". 
The conflict occurred in database "INSURANCE_COMPANY", table "dbo.BENEFICIARY", column 'beneficiary_percentage'.
The statement has been terminated.*/

/**********************************************************************************************
**05 - Constraint to confirm the maximum value of coverage to be paid is 4,000,000.00  ********
***********************************************************************************************/
ALTER TABLE CATEGORY
	ADD CONSTRAINT category_coverage_ck
		CHECK(coverage<=4000000);

-- TESTING THE CONSTRAINT
INSERT INTO CATEGORY VALUES
	('DIA', 'DIAMOND', 20, 5000000, 5, 'DPM', GETDATE(), 'DPM', GETDATE());

/* RESULT:
Msg 547, Level 16, State 0, Line 79
The INSERT statement conflicted with the CHECK constraint "category_coverage_ck". 
The conflict occurred in database "INSURANCE_COMPANY", table "dbo.CATEGORY", column 'coverage'.
The statement has been terminated.*/
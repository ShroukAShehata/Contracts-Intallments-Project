set serveroutput on
set serveroutput on size 10000000000

CREATE OR REPLACE TRIGGER ins_details_trig
BEFORE INSERT
ON HR.CONTRACTS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW 

BEGIN


DECLARE
cursor contract_cur is select * from HR.CONTRACTS;
v_period number(10,2);
v_ins_amount number(10,2);
v_contract_id number(10,2);
v_ins_no number(10,2);
v_ins_date date;
v_period_interval number(10,2);
v_i number(8,2);
--v_seq number(10,2);

BEGIN

FOR contract_rec in contract_cur LOOP

v_contract_id :=  contract_rec.CONTRACT_ID;
v_ins_no := contract_rec.PAYMENTS_INSTALLEMENTS_NO;
v_ins_amount :=  ( contract_rec.CONTRACT_TOTAL_FEES - nvl(contract_rec.CONTRACT_DEPOSIT_FEES , 0) ) / v_ins_no;

IF contract_rec.contract_payment_type = 'ANNUAL' then
    v_period_interval := 12;
ELSIF contract_rec.contract_payment_type = 'HALF ANNUAL'  then
    v_period_interval := 6;
ELSIF contract_rec.contract_payment_type = 'QUARTER'  then
    v_period_interval := 3;
ELSIF contract_rec.contract_payment_type = 'MONTHLY'  then
    v_period_interval := 1;

END IF;

v_ins_date := contract_rec.CONTRACT_STARTDATE;
v_i := 1;

    WHILE  v_i  <=  v_ins_no   LOOP
        
     
       INSERT INTO  HR.INSTALLMENTS_PAID(CONTRACT_ID , INSTALLMENT_DATE , INSTALLMENT_AMOUNT , PAID) VALUES(v_contract_id , v_ins_date , v_ins_amount , NULL );
        v_ins_date := ADD_MONTHS(v_ins_date , v_period_interval);
        v_i := v_i + 1;

       
    END LOOP;

END LOOP;

END;


END;
/

show errors;
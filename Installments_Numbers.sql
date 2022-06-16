set serveroutput on
set serveroutput on size 10000000000



DECLARE
cursor contract_cur is select * from HR.CONTRACTS;
period number(4,2);

BEGIN
FOR contract_rec in contract_cur LOOP

IF contract_rec.contract_payment_type = 'ANNUAL' then
    period := 12;
ELSIF contract_rec.contract_payment_type = 'HALF ANNUAL'  then
    period := 6;
ELSIF contract_rec.contract_payment_type = 'QUARTER'  then
    period := 3;
ELSIF contract_rec.contract_payment_type = 'MONTHLY'  then
    period := 1;

END IF;

UPDATE HR.CONTRACTS SET PAYMENTS_INSTALLEMENTS_NO = months_between(CONTRACT_ENDDATE , CONTRACT_STARTDATE) / period 
WHERE CONTRACT_ID = contract_rec.CONTRACT_ID;

END LOOP;

END;





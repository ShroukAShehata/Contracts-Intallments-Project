CREATE OR REPLACE TRIGGER ins_no_trig
AFTER INSERT
ON HR.CONTRACTS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW 

BEGIN 

    DECLARE
        period number(4,2);
        v_ins_amount number(10,2);
        v_contract_id number(10,2);
        v_ins_no number(10,2);
        v_ins_date date;
        v_i number(8,2);
        rec HR.CONTRACTS%rowtype;
               
    BEGIN
       
        
        IF upper(:New.contract_payment_type) = upper('ANNUAL') then
            period := 12;
        ELSIF upper(:New.contract_payment_type) in  ('HALF ANNUAL' , 'HALFANNUAL' , 'HALF_ANNUAL' , 'HALF.ANNUAL')  then
            period := 6;
        ELSIF upper(:New.contract_payment_type) = upper('QUARTER') then
            period := 3;
        ELSIF upper(:New.contract_payment_type) = upper('MONTHLY')  then
            period := 1;

        END IF;
       
        
        UPDATE HR.CONTRACTS SET PAYMENTS_INSTALLEMENTS_NO = months_between(:New.CONTRACT_ENDDATE , :New.CONTRACT_STARTDATE) / period 
        WHERE CONTRACT_ID = :New.CONTRACT_ID;
        
        select * into rec from HR.CONTRACTS where contract_id = :New.contract_id;
        
        v_contract_id :=  :New.CONTRACT_ID;
        v_ins_no := rec.PAYMENTS_INSTALLEMENTS_NO;
        v_ins_amount :=  ( :New.CONTRACT_TOTAL_FEES - nvl(:New.CONTRACT_DEPOSIT_FEES , 0) )/v_ins_no;
        
        v_ins_date := :New.CONTRACT_STARTDATE;
        v_i := 1;

         WHILE  v_i  <=  v_ins_no   LOOP
        
                INSERT INTO  HR.INSTALLMENTS_PAID(CONTRACT_ID , INSTALLMENT_DATE , INSTALLMENT_AMOUNT , PAID) VALUES(v_contract_id , v_ins_date , v_ins_amount , NULL );
         
                v_ins_date := ADD_MONTHS(v_ins_date , period);
                v_i := v_i + 1;

       
    END LOOP;
        
        
        
        END;
        
END ins_no_trig;
/

show errors;
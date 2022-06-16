--CREATE OR REPLACE  SEQUENCE HR.ins_id_seq
    --START WITH 1
    --INCREMENT BY 1
    --MAXVALUE 99999999
    --MINVALUE 1
    --NOCYCLE
    --CACHE 20
    --NOORDER;
    
    
CREATE OR REPLACE TRIGGER HR.ins_id_seq_trig
    BEFORE INSERT
    ON HR.INSTALLMENTS_PAID
    REFERENCING NEW AS New OLD AS Old 
    FOR EACH ROW
 
BEGIN
    :New.installment_id := HR.ins_id_seq.nextval;

END;
/
   

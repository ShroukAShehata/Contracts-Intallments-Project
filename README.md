# Contracts-Intallments-Project
This is an Advanced PLSQL project, aims to on adding any new contract (id, start date, end date, total fees, deposit fees, payment type) in contracts table, installments number required for this contract is calculated and added in Contracts table, then the contract installation details(installment id ,contract id, installment amount , installment required dates) are calculated and automatically inserted in Installments table.....

The project based on at first there's some data in contracts table and installments table is null, so it scans contract table and calculate for the already existing data available and update installments table.....

Then the trigger is used for re-calculating for every new inserted contract.

#### Files Included ####
-Installments_no:  calculate installments number for already existing contracts in contracts table and update contracts table.
-Installments_Details: calculate installments details for already existing contracts and update installments table.
-INS_ID_SEQ_TRIGGER:  Trigger for installment id sequence on inserting any new record
-INS_NO_Details_TRIGGER:  The core file, the trigger to execute the whole process on adding any new contract after that.
-project_clarification: muted simple video to clarify project and tables structures.


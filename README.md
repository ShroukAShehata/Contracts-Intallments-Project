# Contracts-Intallments-Project
This is an Advanced PLSQL project, aims to on adding any new contract (id, start date, end date, total fees, deposit fees, payment type) in contracts table, installments number required for this contract is calculated and added in Contracts table, then the contract installation details(installment id ,contract id, installment amount , installment required dates) are calculated and automatically inserted in Installments table.
The project based on at first there's some data in contracts table and installments table is null, so it scans contract table and calculate for the already existing data available and update installments table.
Then the trigger is used for re-calculating for every new inserted contract.

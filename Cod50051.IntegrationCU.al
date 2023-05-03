codeunit 50051 IntegrationCU
{

    TableNo = "Customer";

    var
        CustomerRec: Record "Customer";

    trigger OnRun()
    begin
        CustomerRec.Init();
        CustomerRec."No." := rec."No.";
        CustomerRec.Name := rec.Name;
        CustomerRec.Validate("Gen. Bus. Posting Group", 'DOMESTIC');
        CustomerRec.Validate("Customer Posting Group", 'DOMESTIC');
        CustomerRec.Validate("Location Code", 'BH');
        CustomerRec.Insert(True);
    end;

}

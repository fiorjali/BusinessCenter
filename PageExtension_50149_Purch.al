pageextension 50149 PurchaseOrderAli extends "Purchase Order List"
{
    actions
    {
        addlast("O&rder")
        {
            action(TestSystemError)
            {
                ApplicationArea = all;
                Caption = 'Firoj Demo';
                Image = Document;

                trigger onAction()
                var
                    CustomerRec: Record "Customer" temporary;
                    //DashRec: Record "Dashboard Table";
                    ErrorText: Text[1024];
                begin

                    /*CustomerRec.Init();
                    CustomerRec."No." := 'Rohani123';
                    CustomerRec.Name := 'Rohani Kolhe';
                    CustomerRec.Insert(True);
                    CLEARLASTERROR;
                    IF NOT CODEUNIT.RUN(CODEUNIT::IntegrationCU, CustomerRec) THEN BEGIN
                        //Message('Error Traped\' + GetLastErrorText());
                        ErrorText := GetLastErrorText();
                        DashRec.Init();
                        DashRec."Entity Type" := 'Patient';
                        DashRec."Document No" := CustomerRec."No.";
                        DashRec.Status := DashRec.Status::Error;
                        DashRec."Message Text" := 'System' + ErrorText;
                        DashRec."Operation Type" := DashRec."Operation Type"::Create;
                        DashRec."Transaction Type" := DashRec."Transaction Type"::InBound;
                        DashRec."Process Date" := Today;
                        DashRec.Insert();
                        Message('Not Done');
                    END else begin
                        //ErrorText := GetLastErrorText();
                        DashRec.Init();
                        DashRec."Entity Type" := 'Patient';
                        DashRec."Document No" := CustomerRec."No.";
                        DashRec.Status := DashRec.Status::Accepted;
                        DashRec."Message Text" := 'Sync successfully';
                        DashRec."Operation Type" := DashRec."Operation Type"::Create;
                        DashRec."Transaction Type" := DashRec."Transaction Type"::InBound;
                        DashRec."Process Date" := Today;
                        DashRec.Insert();
                        Message('Record is created successfully');
                    end;
                    */
                end;
            }

            action(TestPatiat)
            {
                ApplicationArea = all;
                Caption = 'Rohani Demo';
                Image = Document;

                trigger onAction()
                var
                    //DashRec: Record "Dashboard Table";
                    ErrorText: Text[1024];
                //PatientRec: Record "Stag Patient Registration";
                begin



                    /*
                    PatientRec.Reset();
                    PatientRec.SetRange("Patient Number", 'ALI001');
                    if PatientRec.FindFirst() then begin
                        CLEARLASTERROR;

                        IF NOT CODEUNIT.RUN(CODEUNIT::CreateCustomerCU, PatientRec) THEN BEGIN
                            //Message('Error Traped\' + GetLastErrorText());
                            ErrorText := GetLastErrorText();
                            DashRec.Init();
                            DashRec."Entity Type" := 'Patient';
                            DashRec."Document No" := PatientRec."Patient Number";
                            DashRec.Status := DashRec.Status::Error;
                            DashRec."Message Text" := ErrorText;
                            DashRec."Operation Type" := DashRec."Operation Type"::Create;
                            DashRec."Transaction Type" := DashRec."Transaction Type"::InBound;
                            DashRec."Process Date" := Today;
                            DashRec.Insert();
                            Message('Not Done');
                        END else begin
                            //ErrorText := GetLastErrorText();
                            DashRec.Init();
                            DashRec."Entity Type" := 'Patient';
                            DashRec."Document No" := PatientRec."Patient Number";
                            DashRec.Status := DashRec.Status::Accepted;
                            DashRec."Message Text" := 'Sync successfully';
                            DashRec."Operation Type" := DashRec."Operation Type"::Create;
                            DashRec."Transaction Type" := DashRec."Transaction Type"::InBound;
                            DashRec."Process Date" := Today;
                            DashRec.Insert();
                            Message('Record is created successfully');
                        end;
                    end else begin
                        Message('data Not Found in Patient');
                    end;
                    */
                end;
            }

            action(TestRestAPI)
            {
                ApplicationArea = all;
                Caption = 'Test Rest API';
                Image = Document;
                trigger onAction()
                var
                    ErrorText: Text[1024];
                    CD: Codeunit TestRestAPI;
                    jsonObjectVar: JsonObject;
                    jsontext: Text;
                    response: Text;
                    url: Text;
                    responseText: Text;
                begin

                    jsonObjectVar.Add('name', 'Drig type');
                    jsonObjectVar.Add('code', 'ALI0133');
                    jsonObjectVar.Add('active', 'True');
                    jsonObjectVar.WriteTo(jsontext);
                    Message('Request \' + jsontext);
                    url := 'https://test.artisivf.com/erp/v1/pharmacy_drug_types';
                    //CD.APICall(jsontext, response);
                    //apiRequestQuery := '{"timestamp": "","LeaveAccrual": "test","InsertedOn": "1753-01-01T00:00:00","InsertedBy": "","UpdatedOn": "1753-01-01T00:00:00","UpdatedBy": "","C_systemId": "c1eef8af-c25e-ea11-b7f0-90b11c65cdee"}';
                    responseText := CD.POST_Request(url, jsontext,'POST','');
                    //webApi.GET_Request('localhost:63273/.../LeaveAccrual');
                    Message('Response \' + responseText);

                end;
            }






        }
    }
}
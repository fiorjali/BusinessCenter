pageextension 50148 ItemListAli extends "Item List"
{
    actions
    {
        addlast("Item")
        {

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

                    jsonObjectVar.Add('name', 'Shivanshu-2');
                    jsonObjectVar.Add('code', 'ALI0315');
                    jsonObjectVar.Add('active', 'True');
                    jsonObjectVar.WriteTo(jsontext);
                    url := 'https://test.artisivf.com/erp/v1/pharmacy_drug_types';
                    Message('Request Payload \' + jsontext);
                    responseText := CD.POST_Request(url, jsontext,'POST','');
                    Message('Response Payload \' + responseText);
                end;

            }

        }
    }
}
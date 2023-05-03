pageextension 50147 PurchaseOrderExt extends "Purchase Order"
{
    actions
    {
        addlast("O&rder")
        {
            action(TestRestAPI)
            {
                ApplicationArea = all;
                Caption = 'Sync To Artis';
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
                    PurchLineRec: Record "Purchase Line";
                    LinePayload: Text;
                    Cnt: Integer;
                    input: JsonObject;
                    c: JsonToken;
                    Myresult: Text[1024];
                    created_at: Text;
                    HeaderFlg: Boolean;
                    LineCnt: Integer;

                begin

                    if (Rec.Status <> Rec.Status::Released) then begin
                        Error('PO is not relesead you can not sync with artis');
                    end;

                    // Create Payload for Purchase Header 
                    jsonObjectVar.Add('purchaseOrderNumber', Rec."No.");
                    jsonObjectVar.Add('purchaseOrderDate', Rec."Document Date");
                    Rec.CalcFields(Amount);
                    jsonObjectVar.Add('amount', Rec."Amount");
                    jsonObjectVar.Add('discountPercentage', '0'); // Invoice Discount %
                    jsonObjectVar.Add('taxCollectionAmount', '0'); //Total VAT (INR)
                    jsonObjectVar.Add('vendorCode', rec."Buy-from Vendor No.");
                    jsonObjectVar.Add('status', 'Approved');
                    jsonObjectVar.Add('creatorCode', 'DCTR-0001');

                    jsonObjectVar.WriteTo(jsontext);
                    url := 'https://test.artisivf.com/erp/v1/purchase_orders';
                    
                    //Message('Purchase Request Payload \ \' + jsontext);
                    responseText := CD.POST_Request(url, jsontext,'PUT','');

                    //Message('Response Payload \' + responseText);
                    HeaderFlg := true;
                    input.ReadFrom(responseText);
                    //Get Barcode
                    if input.Get('created_at', c) then begin
                        created_at := c.AsValue().AsText();
                        if (created_at <> '') then begin
                            HeaderFlg := true;
                        end;
                    end else
                        if input.Get('error', c) then begin
                            created_at := c.AsValue().AsText();
                            Error(created_at);
                        end;

                    // Create Payload for Purchase Line
                    if (HeaderFlg = true) then begin
                        Clear(jsonObjectVar);
                        PurchLineRec.Reset();
                        PurchLineRec.SetRange("Document Type", Rec."Document Type");
                        PurchLineRec.SetRange("Document No.", Rec."No.");
                        PurchLineRec.SetRange(Type, PurchLineRec.Type::Item);
                        Cnt := PurchLineRec.Count();
                        if (Cnt > 1) then
                            LinePayload := '[';

                        LineCnt := 0;
                        if PurchLineRec.FindFirst() then begin
                            repeat
                                jsonObjectVar.Add('purchaseOrderNumber', Rec."No.");
                                jsonObjectVar.Add('pharmacyDrugCode', PurchLineRec."No.");
                                jsonObjectVar.Add('quantity', PurchLineRec.Quantity);
                                jsonObjectVar.Add('cost', PurchLineRec."Unit Cost");
                                jsonObjectVar.Add('mrp', 100); // MRP Call from extention of PL Line
                                jsonObjectVar.Add('taxPercentage', 0.18); // taxPercentage Call from extention of Item Table
                                jsonObjectVar.WriteTo(jsontext);
                                url := 'https://test.artisivf.com/erp/v1/purchase_order_lines';
                                //Message('Purchase Line Request Payload \ \' + jsontext);
                                responseText := CD.POST_Request(url, jsontext,'POSt','');
                                //Message(responseText);
                                jsontext := '';
                                Clear(jsonObjectVar);

                                input.ReadFrom(responseText);
                                //Get Barcode
                                if input.Get('created_at', c) then begin
                                    created_at := c.AsValue().AsText();
                                    if (created_at <> '') then begin
                                        LineCnt := LineCnt + 1;
                                    end;
                                end;

                            /*
                            if LinePayload = '' then begin
                                LinePayload := jsontext;
                            end else begin
                                LinePayload := LinePayload + ',' + jsontext;
                            end;
                            Clear(jsonObjectVar);
                            jsontext := '';
                            */
                            until PurchLineRec.Next = 0;
                        end;

                        Message('Purchase order No. %1 and Total line %2 is Create Sucessfully ', Rec."No.", LineCnt);

                        //if (Cnt > 1) then
                        //    LinePayload := LinePayload + ']';

                        // LinePayload := LinePayload.Replace('[,', '[');

                        //jsonObjectVar.WriteTo(jsontext);
                        //url := 'https://test.artisivf.com/erp/v1/purchase_order_lines';
                        //Message('Purchase Line Request Payload \ \' + LinePayload);
                        //responseText := CD.POST_Request(url, jsontext);
                        //Message('Response Payload \' + responseText);
                    end;

                end;
            }

        }
    }
}
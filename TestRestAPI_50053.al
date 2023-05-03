codeunit 50053 TestRestAPI
{
    procedure APICall(Input: Text[1024]; var output: Text)
    var

        client: HttpClient;
        responsse: HttpResponseMessage;
        request: HttpRequestMessage;
        url: text;
        result: text;
        header: HttpHeaders;
        authenticatokenkey: text;
        hostkey: text;
        outurl: text;
        json_object: JsonObject;
        newjsonobject: JsonObject;
        jsontokenn: JsonToken;
        newjsontkenn: JsonToken;
        newrestul: Text;
    begin

        header := client.DefaultRequestHeaders;
        authenticatokenkey := '';
        hostkey := '';
        header.Add('X-Customer-Code', 'Oasis');
        header.Add('X-Branch-Code', 'Demo');
        //header.Add('Content-Type', 'application/json');
        url := 'https://test.artisivf.com/erp/v1/pharmacy_drug_types';
        request.SetRequestUri(url + Input);
        outurl := request.GetRequestUri();
        //Message(outurl);
        request.Method('POST');
        client.Send(request, responsse);
        if responsse.IsSuccessStatusCode then begin
            request.Content.ReadAs(result);
        end;
    end;


    //**************** POST_Request ********************
    Procedure POST_Request(uri: Text; _queryObj: Text; MethodType: Code[20]; PrimeryKeyValue: Code[20]) responseText: Text;
    var
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;
    begin
        // Add the payload to the content
        content.WriteFrom(_queryObj);
        // Retrieve the contentHeaders associated with the content
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        contentHeaders.Add('X-Customer-Code', 'Oasis');
        contentHeaders.Add('X-Branch-Code', 'Demo');
        // Assigning content to request.Content will actually create a copy of the content and assign it.
        // After this line, modifying the content variable or its associated headers will not reflect in
        // the content associated with the request message
        request.Content := content;
        
        if (PrimeryKeyValue <> '') And (MethodType = 'PUT') then
            uri := uri + '/' + PrimeryKeyValue;

        request.SetRequestUri(uri);
        request.Method := MethodType;// 'POST';
        client.Send(request, response);
        // Read the response content as json.
        response.Content().ReadAs(responseText);
    end;


}
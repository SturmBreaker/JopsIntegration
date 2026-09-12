namespace Jops.Trial;

codeunit 50107 "SO Import Webhook"
{
    TableNo = "SO Import Header";

    trigger OnRun()
    begin
        SendStatus(Rec);
    end;

    local procedure SendStatus(ImportHeader: Record "SO Import Header")
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        Response: HttpResponseMessage;
        Payload: JsonObject;
        RequestBody: Text;
    begin
        // Replace this placeholder with the external system's webhook endpoint.
        Payload.Add('entryNo', ImportHeader."Entry No.");
        Payload.Add('externalDocumentNo', ImportHeader."External Document No.");
        Payload.Add('status', Format(ImportHeader.Status));
        Payload.Add('salesOrderNo', ImportHeader."Sales Order No.");
        Payload.Add('errorMessage', ImportHeader."Error Message");
        Payload.WriteTo(RequestBody);

        Content.WriteFrom(RequestBody);
        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');

        if not Client.Post(WebhookEndpoint(), Content, Response) then
            Error('The sales order status webhook request could not be sent.');
        if not Response.IsSuccessStatusCode() then
            Error('The sales order status webhook returned HTTP status %1.', Response.HttpStatusCode());
    end;

    local procedure WebhookEndpoint(): Text
    begin
        exit('https://REPLACE-WITH-ACTUAL-ENDPOINT');
    end;
}
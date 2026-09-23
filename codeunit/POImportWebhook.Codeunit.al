codeunit 50120 "PO Import Webhook"
{
    TableNo = "PO Import Header";

    trigger OnRun()
    begin
        SendStatus(Rec);
    end;

    local procedure SendStatus(ImportHeader: Record "PO Import Header")
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        Response: HttpResponseMessage;
        Payload: JsonObject;
        RequestBody: Text;
        SetupMgt: Codeunit "Order Integration Setup Mgt.";
    begin
        if not SetupMgt.IsPurchaseWebhookEnabled() then
            exit;

        if SetupMgt.GetPurchaseWebhookEndpoint() = '' then
            Error('The purchase webhook is enabled, but its HTTP endpoint is not configured.');

        Payload.Add('entryNo', ImportHeader."Entry No.");
        Payload.Add('externalDocumentNo', ImportHeader."External Document No.");
        Payload.Add('status', Format(ImportHeader.Status));
        Payload.Add('purchaseOrderNo', ImportHeader."Purchase Order No.");
        Payload.Add('errorMessage', ImportHeader."Error Message");
        Payload.WriteTo(RequestBody);

        Content.WriteFrom(RequestBody);
        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');

        if not Client.Post(SetupMgt.GetPurchaseWebhookEndpoint(), Content, Response) then
            Error('The purchase order status webhook request could not be sent.');
        if not Response.IsSuccessStatusCode() then
            Error('The purchase order status webhook returned HTTP status %1.', Response.HttpStatusCode());
    end;
}
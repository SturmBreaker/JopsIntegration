codeunit 50100 "SO Import Webhook Basic"
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
        AuthorizationHeader: Text;
        Endpoint: Text;
        SetupMgt: Codeunit "Order Integration Setup Mgt.";
    begin
        if not SetupMgt.IsSalesWebhookEnabled() then
            exit;

        Endpoint := SetupMgt.GetSalesWebhookEndpoint();
        if Endpoint = '' then
            Error('The sales webhook is enabled, but its HTTP endpoint is not configured.');
        if StrPos(LowerCase(Endpoint), 'https://') <> 1 then
            Error('The sales webhook must use HTTPS when Basic Authentication is enabled.');
        AuthorizationHeader := SetupMgt.GetSalesWebhookAuthorizationHeader();
        if AuthorizationHeader = '' then
            Error('Sales webhook Basic Authentication credentials have not been configured.');

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
        Client.DefaultRequestHeaders().Add('Authorization', AuthorizationHeader);

        if not Client.Post(Endpoint, Content, Response) then
            Error('The sales order status webhook request could not be sent.');
        if not Response.IsSuccessStatusCode() then
            Error('The sales order status webhook returned HTTP status %1.', Response.HttpStatusCode());
    end;
}

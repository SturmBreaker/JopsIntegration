codeunit 50102 "TO Import Webhook Basic"
{
    TableNo = "TO Import Header";

    trigger OnRun()
    begin
        SendStatus(Rec);
    end;

    local procedure SendStatus(ImportHeader: Record "TO Import Header")
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
        if not SetupMgt.IsTransferWebhookEnabled() then
            exit;

        Endpoint := SetupMgt.GetTransferWebhookEndpoint();
        if Endpoint = '' then
            Error('The transfer webhook is enabled, but its HTTP endpoint is not configured.');
        if StrPos(LowerCase(Endpoint), 'https://') <> 1 then
            Error('The transfer webhook must use HTTPS when Basic Authentication is enabled.');
        AuthorizationHeader := SetupMgt.GetTransferWebhookAuthorizationHeader();
        if AuthorizationHeader = '' then
            Error('Transfer webhook Basic Authentication credentials have not been configured.');

        Payload.Add('entryNo', ImportHeader."Entry No.");
        Payload.Add('externalDocumentNo', ImportHeader."External Document No.");
        Payload.Add('status', Format(ImportHeader.Status));
        Payload.Add('transferOrderNo', ImportHeader."Transfer Order No.");
        Payload.Add('errorMessage', ImportHeader."Error Message");
        Payload.WriteTo(RequestBody);

        Content.WriteFrom(RequestBody);
        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');
        Client.DefaultRequestHeaders().Add('Authorization', AuthorizationHeader);

        if not Client.Post(Endpoint, Content, Response) then
            Error('The transfer order status webhook request could not be sent.');
        if not Response.IsSuccessStatusCode() then
            Error('The transfer order status webhook returned HTTP status %1.', Response.HttpStatusCode());
    end;
}

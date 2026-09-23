codeunit 50150 "Order Integration Setup Mgt."
{
    procedure IsApiTelemetryEnabled(): Boolean
    var
        Setup: Record "Order Integration Setup";
    begin
        if not Setup.Get('') then
            exit(true);

        exit(Setup."Enable API Telemetry");
    end;

    procedure IsSalesPostingEnabled(): Boolean
    var
        Setup: Record "Order Integration Setup";
    begin
        if not Setup.Get('') then
            exit(true);

        exit(Setup."Enable Sales Posting");
    end;

    procedure IsPurchasePostingEnabled(): Boolean
    var
        Setup: Record "Order Integration Setup";
    begin
        if not Setup.Get('') then
            exit(true);

        exit(Setup."Enable Purchase Posting");
    end;

    procedure IsTransferPostingEnabled(): Boolean
    var
        Setup: Record "Order Integration Setup";
    begin
        if not Setup.Get('') then
            exit(true);

        exit(Setup."Enable Transfer Posting");
    end;

    procedure IsSalesWebhookEnabled(): Boolean
    var
        Setup: Record "Order Integration Setup";
    begin
        if not Setup.Get('') then
            exit(false);

        exit(Setup."Enable Sales Webhook");
    end;

    procedure GetSalesWebhookEndpoint(): Text
    var
        Setup: Record "Order Integration Setup";
    begin
        if not Setup.Get('') then
            exit('');

        exit(Setup."Sales Webhook HTTP Endpoint");
    end;

    procedure IsPurchaseWebhookEnabled(): Boolean
    var
        Setup: Record "Order Integration Setup";
    begin
        if not Setup.Get('') then
            exit(false);

        exit(Setup."Enable Purchase Webhook");
    end;

    procedure GetPurchaseWebhookEndpoint(): Text
    var
        Setup: Record "Order Integration Setup";
    begin
        if not Setup.Get('') then
            exit('');

        exit(Setup."Purchase Webhook HTTP Endpoint");
    end;

    procedure IsTransferWebhookEnabled(): Boolean
    var
        Setup: Record "Order Integration Setup";
    begin
        if not Setup.Get('') then
            exit(false);

        exit(Setup."Enable Transfer Webhook");
    end;

    procedure GetTransferWebhookEndpoint(): Text
    var
        Setup: Record "Order Integration Setup";
    begin
        if not Setup.Get('') then
            exit('');

        exit(Setup."Transfer Webhook HTTP Endpoint");
    end;
}

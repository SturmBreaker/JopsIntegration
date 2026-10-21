codeunit 50150 "Order Integration Setup Mgt."
{
    procedure IsSalesWebhookBasicAuth(): Boolean
    begin
        exit(IsWebhookBasicAuth('Jops.SalesWebhook.Authentication'));
    end;

    procedure IsPurchaseWebhookBasicAuth(): Boolean
    begin
        exit(IsWebhookBasicAuth('Jops.PurchaseWebhook.Authentication'));
    end;

    procedure IsTransferWebhookBasicAuth(): Boolean
    begin
        exit(IsWebhookBasicAuth('Jops.TransferWebhook.Authentication'));
    end;

    procedure SaveSalesWebhookAuthentication(UseBasicAuthentication: Boolean)
    begin
        SaveWebhookAuthentication('Jops.SalesWebhook.Authentication', UseBasicAuthentication);
    end;

    procedure SavePurchaseWebhookAuthentication(UseBasicAuthentication: Boolean)
    begin
        SaveWebhookAuthentication('Jops.PurchaseWebhook.Authentication', UseBasicAuthentication);
    end;

    procedure SaveTransferWebhookAuthentication(UseBasicAuthentication: Boolean)
    begin
        SaveWebhookAuthentication('Jops.TransferWebhook.Authentication', UseBasicAuthentication);
    end;

    procedure SaveSalesWebhookCredentials(UserName: Text; Password: Text)
    begin
        SaveWebhookCredentials('Jops.SalesWebhook.UserName', 'Jops.SalesWebhook.Password', UserName, Password);
    end;

    procedure SavePurchaseWebhookCredentials(UserName: Text; Password: Text)
    begin
        SaveWebhookCredentials('Jops.PurchaseWebhook.UserName', 'Jops.PurchaseWebhook.Password', UserName, Password);
    end;

    procedure SaveTransferWebhookCredentials(UserName: Text; Password: Text)
    begin
        SaveWebhookCredentials('Jops.TransferWebhook.UserName', 'Jops.TransferWebhook.Password', UserName, Password);
    end;

    procedure GetSalesWebhookAuthorizationHeader(): Text
    begin
        exit(GetWebhookAuthorizationHeader('Jops.SalesWebhook.UserName', 'Jops.SalesWebhook.Password'));
    end;

    procedure GetPurchaseWebhookAuthorizationHeader(): Text
    begin
        exit(GetWebhookAuthorizationHeader('Jops.PurchaseWebhook.UserName', 'Jops.PurchaseWebhook.Password'));
    end;

    procedure GetTransferWebhookAuthorizationHeader(): Text
    begin
        exit(GetWebhookAuthorizationHeader('Jops.TransferWebhook.UserName', 'Jops.TransferWebhook.Password'));
    end;

    local procedure SaveWebhookCredentials(UserNameKey: Text; PasswordKey: Text; UserName: Text; Password: Text)
    begin
        if (UserName = '') or (Password = '') then
            Error('Both a username and password are required.');

        if not IsolatedStorage.SetEncrypted(UserNameKey, UserName, DataScope::Company) then
            Error('The webhook username could not be saved to Isolated Storage.');
        if not IsolatedStorage.SetEncrypted(PasswordKey, Password, DataScope::Company) then
            Error('The webhook password could not be saved to Isolated Storage.');
    end;

    local procedure SaveWebhookAuthentication(AuthenticationKey: Text; UseBasicAuthentication: Boolean)
    var
        Authentication: Text;
    begin
        if UseBasicAuthentication then
            Authentication := 'Basic'
        else
            Authentication := 'None';

        if not IsolatedStorage.Set(AuthenticationKey, Authentication, DataScope::Company) then
            Error('The webhook authentication setting could not be saved.');
    end;

    local procedure IsWebhookBasicAuth(AuthenticationKey: Text): Boolean
    var
        Authentication: Text;
    begin
        if not IsolatedStorage.Get(AuthenticationKey, DataScope::Company, Authentication) then
            exit(false);

        exit(Authentication = 'Basic');
    end;

    local procedure GetWebhookAuthorizationHeader(UserNameKey: Text; PasswordKey: Text): Text
    var
        Base64Convert: Codeunit "Base64 Convert";
        UserName: Text;
        Password: Text;
    begin
        if not IsolatedStorage.Get(UserNameKey, DataScope::Company, UserName) then
            exit('');
        if not IsolatedStorage.Get(PasswordKey, DataScope::Company, Password) then
            exit('');

        exit('Basic ' + Base64Convert.ToBase64(UserName + ':' + Password));
    end;

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

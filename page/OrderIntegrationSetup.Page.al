page 50105 "Order Integration Setup"
{
    PageType = Card;
    SourceTable = "Order Integration Setup";
    Caption = 'Order Integration Setup';
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Enable API Telemetry"; Rec."Enable API Telemetry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether API integration telemetry is sent to Application Insights.';
                }
                field("Enable Sales Posting"; Rec."Enable Sales Posting")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether imported sales orders are posted automatically.';
                }
                field("Enable Purchase Posting"; Rec."Enable Purchase Posting")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether imported purchase orders are posted automatically.';
                }
                field("Enable Transfer Posting"; Rec."Enable Transfer Posting")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether imported transfer orders are posted automatically.';
                }
            }
            group(Webhooks)
            {
                field("Enable Sales Webhook"; Rec."Enable Sales Webhook")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether sales order status webhooks are sent.';
                }
                field("Sales Webhook HTTP Endpoint"; Rec."Sales Webhook HTTP Endpoint")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the HTTP endpoint for sales order status webhooks.';
                }
                field(SalesWebhookAuthentication; SalesWebhookAuthentication)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Webhook Authentication';
                    OptionCaption = 'No Authentication,Basic Authentication';
                    ToolTip = 'Specifies whether the sales webhook uses no authentication or Basic Authentication.';

                    trigger OnValidate()
                    var
                        SetupMgt: Codeunit "Order Integration Setup Mgt.";
                    begin
                        SetupMgt.SaveSalesWebhookAuthentication(SalesWebhookAuthentication = SalesWebhookAuthentication::Basic);
                    end;
                }
                field("Enable Purchase Webhook"; Rec."Enable Purchase Webhook")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether purchase order status webhooks are sent.';
                }
                field("Purchase Webhook HTTP Endpoint"; Rec."Purchase Webhook HTTP Endpoint")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the HTTP endpoint for purchase order status webhooks.';
                }
                field(PurchaseWebhookAuthentication; PurchaseWebhookAuthentication)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Webhook Authentication';
                    OptionCaption = 'No Authentication,Basic Authentication';
                    ToolTip = 'Specifies whether the purchase webhook uses no authentication or Basic Authentication.';

                    trigger OnValidate()
                    var
                        SetupMgt: Codeunit "Order Integration Setup Mgt.";
                    begin
                        SetupMgt.SavePurchaseWebhookAuthentication(PurchaseWebhookAuthentication = PurchaseWebhookAuthentication::Basic);
                    end;
                }
                field("Enable Transfer Webhook"; Rec."Enable Transfer Webhook")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether transfer order status webhooks are sent.';
                }
                field("Transfer Webhook HTTP Endpoint"; Rec."Transfer Webhook HTTP Endpoint")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the HTTP endpoint for transfer order status webhooks.';
                }
                field(TransferWebhookAuthentication; TransferWebhookAuthentication)
                {
                    ApplicationArea = All;
                    Caption = 'Transfer Webhook Authentication';
                    OptionCaption = 'No Authentication,Basic Authentication';
                    ToolTip = 'Specifies whether the transfer webhook uses no authentication or Basic Authentication.';

                    trigger OnValidate()
                    var
                        SetupMgt: Codeunit "Order Integration Setup Mgt.";
                    begin
                        SetupMgt.SaveTransferWebhookAuthentication(TransferWebhookAuthentication = TransferWebhookAuthentication::Basic);
                    end;
                }
            }
            group(WebhookCredentials)
            {
                Caption = 'Webhook Basic Authentication Credentials';
                field(SalesWebhookUserName; SalesWebhookUserName)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Webhook Username';
                    ToolTip = 'Specifies the username to save securely for sales webhook Basic Authentication.';
                }
                field(SalesWebhookPassword; SalesWebhookPassword)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Webhook Password';
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the password to save securely for sales webhook Basic Authentication.';
                }
                field(PurchaseWebhookUserName; PurchaseWebhookUserName)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Webhook Username';
                    ToolTip = 'Specifies the username to save securely for purchase webhook Basic Authentication.';
                }
                field(PurchaseWebhookPassword; PurchaseWebhookPassword)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Webhook Password';
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the password to save securely for purchase webhook Basic Authentication.';
                }
                field(TransferWebhookUserName; TransferWebhookUserName)
                {
                    ApplicationArea = All;
                    Caption = 'Transfer Webhook Username';
                    ToolTip = 'Specifies the username to save securely for transfer webhook Basic Authentication.';
                }
                field(TransferWebhookPassword; TransferWebhookPassword)
                {
                    ApplicationArea = All;
                    Caption = 'Transfer Webhook Password';
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the password to save securely for transfer webhook Basic Authentication.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SaveSalesWebhookCredentials)
            {
                ApplicationArea = All;
                Caption = 'Save Sales Credentials';
                ToolTip = 'Saves the sales webhook username and password in encrypted Isolated Storage.';

                trigger OnAction()
                var
                    SetupMgt: Codeunit "Order Integration Setup Mgt.";
                begin
                    SetupMgt.SaveSalesWebhookCredentials(SalesWebhookUserName, SalesWebhookPassword);
                    Clear(SalesWebhookUserName);
                    Clear(SalesWebhookPassword);
                    Message('Sales webhook credentials were saved securely.');
                end;
            }
            action(SavePurchaseWebhookCredentials)
            {
                ApplicationArea = All;
                Caption = 'Save Purchase Credentials';
                ToolTip = 'Saves the purchase webhook username and password in encrypted Isolated Storage.';

                trigger OnAction()
                var
                    SetupMgt: Codeunit "Order Integration Setup Mgt.";
                begin
                    SetupMgt.SavePurchaseWebhookCredentials(PurchaseWebhookUserName, PurchaseWebhookPassword);
                    Clear(PurchaseWebhookUserName);
                    Clear(PurchaseWebhookPassword);
                    Message('Purchase webhook credentials were saved securely.');
                end;
            }
            action(SaveTransferWebhookCredentials)
            {
                ApplicationArea = All;
                Caption = 'Save Transfer Credentials';
                ToolTip = 'Saves the transfer webhook username and password in encrypted Isolated Storage.';

                trigger OnAction()
                var
                    SetupMgt: Codeunit "Order Integration Setup Mgt.";
                begin
                    SetupMgt.SaveTransferWebhookCredentials(TransferWebhookUserName, TransferWebhookPassword);
                    Clear(TransferWebhookUserName);
                    Clear(TransferWebhookPassword);
                    Message('Transfer webhook credentials were saved securely.');
                end;
            }
        }
    }

    var
        SalesWebhookUserName: Text[215];
        SalesWebhookPassword: Text[215];
        PurchaseWebhookUserName: Text[215];
        PurchaseWebhookPassword: Text[215];
        TransferWebhookUserName: Text[215];
        TransferWebhookPassword: Text[215];
        SalesWebhookAuthentication: Option None,Basic;
        PurchaseWebhookAuthentication: Option None,Basic;
        TransferWebhookAuthentication: Option None,Basic;

    trigger OnOpenPage()
    var
        SetupMgt: Codeunit "Order Integration Setup Mgt.";
    begin
        if not Rec.Get('') then begin
            Rec.Init();
            Rec."Primary Key" := '';
            Rec.Insert();
        end;

        if SetupMgt.IsSalesWebhookBasicAuth() then
            SalesWebhookAuthentication := SalesWebhookAuthentication::Basic;
        if SetupMgt.IsPurchaseWebhookBasicAuth() then
            PurchaseWebhookAuthentication := PurchaseWebhookAuthentication::Basic;
        if SetupMgt.IsTransferWebhookBasicAuth() then
            TransferWebhookAuthentication := TransferWebhookAuthentication::Basic;
    end;
}

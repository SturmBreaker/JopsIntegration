page 50151 "Order Integration Setup"
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
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get('') then begin
            Rec.Init();
            Rec."Primary Key" := '';
            Rec.Insert();
        end;
    end;
}

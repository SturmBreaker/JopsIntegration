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

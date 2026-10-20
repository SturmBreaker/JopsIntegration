page 50151 "Order Integration Activities"
{
    PageType = CardPart;
    Caption = 'Unprocessed Import Records';
    RefreshOnActivate = true;
    SourceTable = "Order Integration Cue";

    layout
    {
        area(content)
        {
            cuegroup(SalesOrders)
            {
                Caption = 'Sales Imports';

                field("SO Unprocessed Headers"; Rec."SO Unprocessed Headers")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "SO Import Header List";
                    ToolTip = 'Specifies the number of sales import headers with status Pending or Error.';
                }
                field("SO Unprocessed Lines"; Rec."SO Unprocessed Lines")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of sales import lines belonging to headers with status Pending or Error.';

                    trigger OnDrillDown()
                    var
                        Header: Record "SO Import Header";
                        Line: Record "SO Import Line";
                    begin
                        Header.SetFilter(Status, '<>%1', Header.Status::Processed);
                        if Header.FindSet() then
                            repeat
                                Line.SetRange("Header Entry No.", Header."Entry No.");
                                if Line.FindSet() then
                                    repeat
                                        Line.Mark(true);
                                    until Line.Next() = 0;
                            until Header.Next() = 0;
                        Line.SetRange("Header Entry No.");
                        Line.MarkedOnly(true);
                        Page.Run(Page::"SO Import Line List", Line);
                    end;
                }
            }
            cuegroup(PurchaseOrders)
            {
                Caption = 'Purchase Imports';

                field("PO Unprocessed Headers"; Rec."PO Unprocessed Headers")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "PO Import Header List";
                    ToolTip = 'Specifies the number of purchase import headers with status Pending or Error.';
                }
                field("PO Unprocessed Lines"; Rec."PO Unprocessed Lines")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of purchase import lines belonging to headers with status Pending or Error.';

                    trigger OnDrillDown()
                    var
                        Header: Record "PO Import Header";
                        Line: Record "PO Import Line";
                    begin
                        Header.SetFilter(Status, '<>%1', Header.Status::Processed);
                        if Header.FindSet() then
                            repeat
                                Line.SetRange("Header Entry No.", Header."Entry No.");
                                if Line.FindSet() then
                                    repeat
                                        Line.Mark(true);
                                    until Line.Next() = 0;
                            until Header.Next() = 0;
                        Line.SetRange("Header Entry No.");
                        Line.MarkedOnly(true);
                        Page.Run(Page::"PO Import Line List", Line);
                    end;
                }
            }
            cuegroup(TransferOrders)
            {
                Caption = 'Transfer Imports';

                field("TO Unprocessed Headers"; Rec."TO Unprocessed Headers")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "TO Import Header List";
                    ToolTip = 'Specifies the number of transfer import headers with status Pending or Error.';
                }
                field("TO Unprocessed Lines"; Rec."TO Unprocessed Lines")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of transfer import lines belonging to headers with status Pending or Error.';

                    trigger OnDrillDown()
                    var
                        Header: Record "TO Import Header";
                        Line: Record "TO Import Line";
                    begin
                        Header.SetFilter(Status, '<>%1', Header.Status::Processed);
                        if Header.FindSet() then
                            repeat
                                Line.SetRange("Header Entry No.", Header."Entry No.");
                                if Line.FindSet() then
                                    repeat
                                        Line.Mark(true);
                                    until Line.Next() = 0;
                            until Header.Next() = 0;
                        Line.SetRange("Header Entry No.");
                        Line.MarkedOnly(true);
                        Page.Run(Page::"TO Import Line List", Line);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec."SO Unprocessed Lines" := CountSOLines();
        Rec."PO Unprocessed Lines" := CountPOLines();
        Rec."TO Unprocessed Lines" := CountTOLines();
    end;

    local procedure CountSOLines(): Integer
    var
        Header: Record "SO Import Header";
        Line: Record "SO Import Line";
        Total: Integer;
    begin
        Header.SetFilter(Status, '<>%1', Header.Status::Processed);
        if Header.FindSet() then
            repeat
                Line.SetRange("Header Entry No.", Header."Entry No.");
                Total += Line.Count();
            until Header.Next() = 0;
        exit(Total);
    end;

    local procedure CountPOLines(): Integer
    var
        Header: Record "PO Import Header";
        Line: Record "PO Import Line";
        Total: Integer;
    begin
        Header.SetFilter(Status, '<>%1', Header.Status::Processed);
        if Header.FindSet() then
            repeat
                Line.SetRange("Header Entry No.", Header."Entry No.");
                Total += Line.Count();
            until Header.Next() = 0;
        exit(Total);
    end;

    local procedure CountTOLines(): Integer
    var
        Header: Record "TO Import Header";
        Line: Record "TO Import Line";
        Total: Integer;
    begin
        Header.SetFilter(Status, '<>%1', Header.Status::Processed);
        if Header.FindSet() then
            repeat
                Line.SetRange("Header Entry No.", Header."Entry No.");
                Total += Line.Count();
            until Header.Next() = 0;
        exit(Total);
    end;
}

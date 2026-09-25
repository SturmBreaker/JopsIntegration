page 50139 "TO Import Header Archive List"
{
    Caption = 'Transfer Order Import Archive';
    PageType = List;
    UsageCategory = History;
    ApplicationArea = All;
    SourceTable = "TO Import Header Archive";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; ToolTip = 'Specifies the entry number of the transfer import.'; }
                field("External Document No."; Rec."External Document No.") { ApplicationArea = All; ToolTip = 'Specifies the document number from the external source system.'; }
                field("Transfer-from Code"; Rec."Transfer-from Code") { ApplicationArea = All; ToolTip = 'Specifies the location from which the transfer order originates.'; }
                field("Transfer-to Code"; Rec."Transfer-to Code") { ApplicationArea = All; ToolTip = 'Specifies the location to which the transfer order is sent.'; }
                field("Order Date"; Rec."Order Date") { ApplicationArea = All; ToolTip = 'Specifies the order date for the transfer order.'; }
                field(Status; Rec.Status) { ApplicationArea = All; ToolTip = 'Specifies the processing status of the transfer import.'; }
                field("Transfer Order No."; Rec."Transfer Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the transfer order number used to create the posted documents.';
                }
                field("Direct Transfer No."; Rec."Direct Transfer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posted direct transfer order number.';

                    trigger OnDrillDown()
                    var
                        DirectTransHdr: Record "Direct Trans. Header";
                    begin
                        DirectTransHdr.SetRange("Transfer Order No.", Rec."Transfer Order No.");
                        if DirectTransHdr.FindLast() then
                            Page.Run(Page::"Posted Direct Transfer", DirectTransHdr);
                    end;
                }

                // field("Shipment No."; Rec."Shipment No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the posted transfer shipment number.';

                //     trigger OnDrillDown()
                //     var
                //         TransferShipmentHeader: Record "Transfer Shipment Header";
                //     begin
                //         if TransferShipmentHeader.Get(Rec."Shipment No.") then
                //             Page.Run(Page::"Posted Transfer Shipment", TransferShipmentHeader);
                //     end;
                // }
                // field("Receipt No."; Rec."Receipt No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the posted transfer receipt number.';

                //     trigger OnDrillDown()
                //     var
                //         TransferReceiptHeader: Record "Transfer Receipt Header";
                //     begin
                //         if TransferReceiptHeader.Get(Rec."Receipt No.") then
                //             Page.Run(Page::"Posted Transfer Receipt", TransferReceiptHeader);
                //     end;
                // }
                field("Archived At"; Rec."Archived At") { ApplicationArea = All; ToolTip = 'Specifies when the transfer import was archived.'; }
                field("Received At"; Rec."Received At") { ApplicationArea = All; ToolTip = 'Specifies when the transfer import was received.'; }
                field("Error Message"; Rec."Error Message") { ApplicationArea = All; ToolTip = 'Specifies the error message recorded during processing.'; }
                field("Webhook Status"; Rec."Webhook Status") { ApplicationArea = All; ToolTip = 'Specifies the status of the transfer status webhook.'; }
                field("Webhook Error Message"; Rec."Webhook Error Message") { ApplicationArea = All; ToolTip = 'Specifies the error message from the transfer status webhook.'; }
            }
        }
    }
}

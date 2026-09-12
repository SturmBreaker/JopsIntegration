namespace Jops.Trial;

page 50141 "TO Import Headers"
{
    PageType = API;
    SourceTable = "TO Import Header";
    APIPublisher = 'jops';
    APIGroup = 'staging';
    APIVersion = 'v1.0';
    EntityName = 'transferOrderImport';
    EntitySetName = 'transferOrderImports';
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            field(id; Rec.SystemId) { ToolTip = 'Specifies the unique identifier of the transfer import.'; }
            field(entryNo; Rec."Entry No.") { ToolTip = 'Specifies the entry number of the transfer import.'; }
            field(externalDocumentNo; Rec."External Document No.") { ToolTip = 'Specifies the document number from the external source system.'; }
            field(transferFromCode; Rec."Transfer-from Code") { ToolTip = 'Specifies the location from which the transfer order originates.'; }
            field(transferToCode; Rec."Transfer-to Code") { ToolTip = 'Specifies the location to which the transfer order is sent.'; }
            field(orderDate; Rec."Order Date") { ToolTip = 'Specifies the order date for the transfer order.'; }
            field(status; Rec.Status) { ToolTip = 'Specifies the processing status of the transfer import.'; }
            field(errorMessage; Rec."Error Message") { ToolTip = 'Specifies the error message recorded during processing.'; }
            field(transferOrderNo; Rec."Transfer Order No.") { ToolTip = 'Specifies the created transfer order number.'; }
            field(shipmentNo; Rec."Shipment No.") { ToolTip = 'Specifies the posted transfer shipment number.'; }
            field(receiptNo; Rec."Receipt No.") { ToolTip = 'Specifies the posted transfer receipt number.'; }
            field(webhookStatus; Rec."Webhook Status") { ToolTip = 'Specifies the status of the transfer status webhook.'; }
            field(webhookErrorMessage; Rec."Webhook Error Message") { ToolTip = 'Specifies the error message from the transfer status webhook.'; }
            field(receivedAt; Rec."Received At") { ToolTip = 'Specifies when the transfer import was received.'; }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Status := Rec.Status::Pending;
        Rec."Received At" := CurrentDateTime();
        exit(true);
    end;
}
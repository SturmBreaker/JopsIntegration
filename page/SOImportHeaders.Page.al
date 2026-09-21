page 50101 "SO Import Headers"
{
    PageType = API;
    SourceTable = "SO Import Header";
    APIPublisher = 'jops';
    APIGroup = 'staging';
    APIVersion = 'v1.0';
    EntityName = 'salesOrderImport';
    EntitySetName = 'salesOrderImports';
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            field(id; Rec.SystemId) { ToolTip = 'Specifies the unique identifier of the sales import.'; }
            field(entryNo; Rec."Entry No.") { ToolTip = 'Specifies the entry number of the sales import.'; }
            field(externalDocumentNo; Rec."External Document No.") { ToolTip = 'Specifies the document number from the external source system.'; }
            field(customerNo; Rec."Customer No.") { ToolTip = 'Specifies the customer for the sales order.'; }
            field(orderDate; Rec."Order Date") { ToolTip = 'Specifies the order date for the sales order.'; }
            field(currencyCode; Rec."Currency Code") { ToolTip = 'Specifies the currency for the sales order.'; }
            field(status; Rec.Status) { ToolTip = 'Specifies the processing status of the sales import.'; }
            field(errorMessage; Rec."Error Message") { ToolTip = 'Specifies the error message recorded during processing.'; }
            field(salesOrderNo; Rec."Sales Order No.") { ToolTip = 'Specifies the created sales order number.'; }
            field(shipmentNo; Rec."Shipment No.") { ToolTip = 'Specifies the posted sales shipment number.'; }
            field(invoiceNo; Rec."Invoice No.") { ToolTip = 'Specifies the posted sales invoice number.'; }
            field(webhookStatus; Rec."Webhook Status") { ToolTip = 'Specifies the status of the sales status webhook.'; }
            field(webhookErrorMessage; Rec."Webhook Error Message") { ToolTip = 'Specifies the error message from the sales status webhook.'; }
            field(receivedAt; Rec."Received At") { ToolTip = 'Specifies when the sales import was received.'; }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Status := Rec.Status::Pending;
        Rec."Received At" := CurrentDateTime();
        exit(true);
    end;
}
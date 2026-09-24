page 50152 "Order Integration Role Center"
{
    PageType = RoleCenter;
    Caption = 'Order Integration Administrator';

    layout
    {
        area(rolecenter)
        {
            part(Headline; "Headline RC Business Manager")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action(OrderIntegrationSetup)
            {
                ApplicationArea = All;
                Caption = 'Order Integration Setup';
                RunObject = page "Order Integration Setup";
            }
            action(SalesImportHeaders)
            {
                ApplicationArea = All;
                Caption = 'Sales Import Headers';
                RunObject = page "SO Import Header List";
            }
            action(SalesImportLines)
            {
                ApplicationArea = All;
                Caption = 'Sales Import Lines';
                RunObject = page "SO Import Line List";
            }
            action(PurchaseImportHeaders)
            {
                ApplicationArea = All;
                Caption = 'Purchase Import Headers';
                RunObject = page "PO Import Header List";
            }
            action(PurchaseImportLines)
            {
                ApplicationArea = All;
                Caption = 'Purchase Import Lines';
                RunObject = page "PO Import Line List";
            }
            action(TransferImportHeaders)
            {
                ApplicationArea = All;
                Caption = 'Transfer Import Headers';
                RunObject = page "TO Import Header List";
            }
            action(TransferImportLines)
            {
                ApplicationArea = All;
                Caption = 'Transfer Import Lines';
                RunObject = page "TO Import Line List";
            }
            action(SalesImportHeaderArchive)
            {
                ApplicationArea = All;
                Caption = 'Sales Import Header Archive';
                RunObject = page "SO Import Header Archive List";
            }
            action(PurchaseImportHeaderArchive)
            {
                ApplicationArea = All;
                Caption = 'Purchase Import Header Archive';
                RunObject = page "PO Import Header Archive List";
            }
            action(TransferImportHeaderArchive)
            {
                ApplicationArea = All;
                Caption = 'Transfer Import Header Archive';
                RunObject = page "TO Import Header Archive List";
            }
        }
        area(processing)
        {
            action(SalesArchive)
            {
                ApplicationArea = All;
                Caption = 'Sales Import Archive';
                RunObject = report "SO Archive Report";
            }
            action(PurchaseArchive)
            {
                ApplicationArea = All;
                Caption = 'Purchase Import Archive';
                RunObject = report "PO Archive Report";
            }
            action(TransferArchive)
            {
                ApplicationArea = All;
                Caption = 'Transfer Import Archive';
                RunObject = report "TO Archive Report";
            }
        }
    }
}
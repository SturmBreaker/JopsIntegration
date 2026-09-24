report 50131 "PO Archive Report"
{
    Caption = 'Archive Purchase Order Staging';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    dataset
    {
        dataitem(ImportHeader; "PO Import Header")
        {
            RequestFilterFields = "Order Date", "Purchase Order No.";

            trigger OnPreDataItem()
            var
                ArchiveCodeunit: Codeunit "PO Import Archive";
            begin
                ArchiveCodeunit.ArchiveFiltered(ImportHeader);
                CurrReport.Break();
            end;
        }
    }
}
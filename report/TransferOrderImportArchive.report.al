report 50145 "TO Archive Report"
{
    Caption = 'Archive Transfer Order Staging';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    dataset
    {
        dataitem(ImportHeader; "TO Import Header")
        {
            RequestFilterFields = "Order Date", "Transfer Order No.";

            trigger OnPreDataItem()
            begin
                CurrReport.Break();
            end;
        }
    }

    trigger OnPreReport()
    var
        ArchiveCodeunit: Codeunit "TO Import Archive";
    begin
        ArchiveCodeunit.ArchiveFiltered(ImportHeader);
    end;
}
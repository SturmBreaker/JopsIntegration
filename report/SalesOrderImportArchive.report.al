report 50130 "SO Archive Report"
{
    Caption = 'Archive Sales Order Staging';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    dataset
    {
        dataitem(ImportHeader; "SO Import Header")
        {
            RequestFilterFields = "Order Date", "Sales Order No.";
            trigger OnPreDataItem()
            begin
                CurrReport.Break();
            end;
        }
    }

    trigger OnPreReport()
    var
        ArchiveCodeunit: Codeunit "SO Import Archive";
    begin
        ArchiveCodeunit.ArchiveFiltered(ImportHeader);
    end;

    var
        FromDate: Date;
        ToDate: Date;
        SalesOrderNo: Code[20];
        ItemNo: Code[20];
}
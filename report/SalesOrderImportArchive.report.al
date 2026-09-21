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
            trigger OnPreDataItem()
            begin
                CurrReport.Break();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(FromDate; FromDate)
                {
                    ApplicationArea = All;
                    Caption = 'From Order Date';
                }
                field(ToDate; ToDate)
                {
                    ApplicationArea = All;
                    Caption = 'To Order Date';
                }
                field(SalesOrderNo; SalesOrderNo)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order No.';
                }
                field(ItemNo; ItemNo)
                {
                    ApplicationArea = All;
                    Caption = 'Item No.';
                }
            }
        }
    }

    trigger OnPreReport()
    var
        ArchiveCodeunit: Codeunit "SO Import Archive";
    begin
        ArchiveCodeunit.ArchiveFiltered(FromDate, ToDate, SalesOrderNo, ItemNo);
    end;

    var
        FromDate: Date;
        ToDate: Date;
        SalesOrderNo: Code[20];
        ItemNo: Code[20];
}
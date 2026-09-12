namespace Jops.Trial;

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
                field(PurchaseOrderNo; PurchaseOrderNo)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Order No.';
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
        ArchiveCodeunit: Codeunit "PO Import Archive";
    begin
        ArchiveCodeunit.ArchiveFiltered(FromDate, ToDate, PurchaseOrderNo, ItemNo);
    end;

    var
        FromDate: Date;
        ToDate: Date;
        PurchaseOrderNo: Code[20];
        ItemNo: Code[20];
}
namespace Jops.Trial;

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
                field(TransferOrderNo; TransferOrderNo)
                {
                    ApplicationArea = All;
                    Caption = 'Transfer Order No.';
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
        ArchiveCodeunit: Codeunit "TO Import Archive";
    begin
        ArchiveCodeunit.ArchiveFiltered(FromDate, ToDate, TransferOrderNo, ItemNo);
    end;

    var
        FromDate: Date;
        ToDate: Date;
        TransferOrderNo: Code[20];
        ItemNo: Code[20];
}
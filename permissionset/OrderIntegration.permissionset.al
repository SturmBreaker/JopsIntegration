namespace Jops.Trial;

using Microsoft.Inventory.Transfer;
using Microsoft.Purchases.Document;
using Microsoft.Sales.Document;

permissionset 50147 "Order Integr."
{
    Assignable = true;
    Caption = 'Jops Order Integration';

    Permissions =
        tabledata "SO Import Header" = RIMD,
        tabledata "SO Import Line" = RIMD,
        tabledata "SO Import Header Archive" = RIMD,
        tabledata "SO Import Line Archive" = RIMD,
        tabledata "PO Import Header" = RIMD,
        tabledata "PO Import Line" = RIMD,
        tabledata "PO Import Header Archive" = RIMD,
        tabledata "PO Import Line Archive" = RIMD,
        tabledata "TO Import Header" = RIMD,
        tabledata "TO Import Line" = RIMD,
        tabledata "TO Import Header Archive" = RIMD,
        tabledata "TO Import Line Archive" = RIMD,
        tabledata "Sales Header" = RIMD,
        tabledata "Sales Line" = RIMD,
        tabledata "Purchase Header" = RIMD,
        tabledata "Purchase Line" = RIMD,
        tabledata "Transfer Header" = RIMD,
        tabledata "Transfer Line" = RIMD,
        codeunit "SO Import Processor" = X,
        codeunit "SO Import Worker" = X,
        codeunit "SO Import Webhook" = X,
        codeunit "SO Import Archive" = X,
        codeunit "PO Import Processor" = X,
        codeunit "PO Import Worker" = X,
        codeunit "PO Import Webhook" = X,
        codeunit "PO Import Archive" = X,
        codeunit "TO Import Processor" = X,
        codeunit "TO Import Worker" = X,
        codeunit "TO Import Webhook" = X,
        codeunit "TO Import Archive" = X,
        page "SO Import Headers" = X,
        page "SO Import Lines" = X,
        page "SO Import Header List" = X,
        page "SO Import Line List" = X,
        page "PO Import Headers" = X,
        page "PO Import Lines" = X,
        page "PO Import Header List" = X,
        page "PO Import Line List" = X,
        page "TO Import Headers" = X,
        page "TO Import Lines" = X,
        page "TO Import Header List" = X,
        page "TO Import Line List" = X,
        report "SO Archive Report" = X,
        report "PO Archive Report" = X,
        report "TO Archive Report" = X;
}
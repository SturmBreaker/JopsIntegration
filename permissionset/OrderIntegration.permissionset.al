namespace Jops.Trial;

using Microsoft.Inventory.Transfer;
using Microsoft.Purchases.Document;
using Microsoft.Sales.Document;

permissionset 50147 "Jops Order Integr."
{
    Assignable = true;
    Caption = 'Jops Order Integration';

    Permissions =
        tabledata "Jops SO Import Header" = RIMD,
        tabledata "Jops SO Import Line" = RIMD,
        tabledata "Jops SO Import Header Archive" = RIMD,
        tabledata "Jops SO Import Line Archive" = RIMD,
        tabledata "Jops PO Import Header" = RIMD,
        tabledata "Jops PO Import Line" = RIMD,
        tabledata "Jops PO Import Header Archive" = RIMD,
        tabledata "Jops PO Import Line Archive" = RIMD,
        tabledata "Jops TO Import Header" = RIMD,
        tabledata "Jops TO Import Line" = RIMD,
        tabledata "Jops TO Import Header Archive" = RIMD,
        tabledata "Jops TO Import Line Archive" = RIMD,
        tabledata "Sales Header" = RIMD,
        tabledata "Sales Line" = RIMD,
        tabledata "Purchase Header" = RIMD,
        tabledata "Purchase Line" = RIMD,
        tabledata "Transfer Header" = RIMD,
        tabledata "Transfer Line" = RIMD,
        codeunit "Jops SO Import Processor" = X,
        codeunit "Jops SO Import Worker" = X,
        codeunit "Jops SO Import Webhook" = X,
        codeunit "Jops SO Import Archive" = X,
        codeunit "Jops PO Import Processor" = X,
        codeunit "Jops PO Import Worker" = X,
        codeunit "Jops PO Import Webhook" = X,
        codeunit "Jops PO Import Archive" = X,
        codeunit "Jops TO Import Processor" = X,
        codeunit "Jops TO Import Worker" = X,
        codeunit "Jops TO Import Webhook" = X,
        codeunit "Jops TO Import Archive" = X,
        page "Jops SO Import Headers" = X,
        page "Jops SO Import Lines" = X,
        page "Jops SO Import Header List" = X,
        page "Jops SO Import Line List" = X,
        page "Jops PO Import Headers" = X,
        page "Jops PO Import Lines" = X,
        page "Jops PO Import Header List" = X,
        page "Jops PO Import Line List" = X,
        page "Jops TO Import Headers" = X,
        page "Jops TO Import Lines" = X,
        page "Jops TO Import Header List" = X,
        page "Jops TO Import Line List" = X,
        report "Jops SO Archive Report" = X,
        report "Jops PO Archive Report" = X,
        report "Jops TO Archive Report" = X;
}
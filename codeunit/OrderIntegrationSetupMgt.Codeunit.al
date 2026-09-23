codeunit 50150 "Order Integration Setup Mgt."
{
    procedure IsApiTelemetryEnabled(): Boolean
    var
        Setup: Record "Order Integration Setup";
    begin
        if not Setup.Get('') then
            exit(true);

        exit(Setup."Enable API Telemetry");
    end;

    procedure IsSalesPostingEnabled(): Boolean
    var
        Setup: Record "Order Integration Setup";
    begin
        if not Setup.Get('') then
            exit(true);

        exit(Setup."Enable Sales Posting");
    end;

    procedure IsPurchasePostingEnabled(): Boolean
    var
        Setup: Record "Order Integration Setup";
    begin
        if not Setup.Get('') then
            exit(true);

        exit(Setup."Enable Purchase Posting");
    end;

    procedure IsTransferPostingEnabled(): Boolean
    var
        Setup: Record "Order Integration Setup";
    begin
        if not Setup.Get('') then
            exit(true);

        exit(Setup."Enable Transfer Posting");
    end;
}

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
}

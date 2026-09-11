namespace Jops.Trial;

codeunit 50148 "Jops Order Integration Tests"
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure SalesImportWithoutLinesSetsError()
    var
        ImportHeader: Record "Jops SO Import Header";
        Processor: Codeunit "Jops SO Import Processor";
    begin
        ImportHeader.Init();
        ImportHeader."Customer No." := 'TEST-CUSTOMER';
        ImportHeader.Status := ImportHeader.Status::Pending;
        ImportHeader.Insert();

        Processor.ProcessPending();

        ImportHeader.Get(ImportHeader."Entry No.");
        AssertStatus(ImportHeader.Status, ImportHeader.Status::Error, 'Sales staging record should be marked as Error.');
        AssertNotEmpty(ImportHeader."Error Message", 'Sales staging error message should be populated.');
    end;

    [Test]
    procedure PurchaseImportWithoutLinesSetsError()
    var
        ImportHeader: Record "Jops PO Import Header";
        Processor: Codeunit "Jops PO Import Processor";
    begin
        ImportHeader.Init();
        ImportHeader."Vendor No." := 'TEST-VENDOR';
        ImportHeader.Status := ImportHeader.Status::Pending;
        ImportHeader.Insert();

        Processor.ProcessPending();

        ImportHeader.Get(ImportHeader."Entry No.");
        AssertStatus(ImportHeader.Status, ImportHeader.Status::Error, 'Purchase staging record should be marked as Error.');
        AssertNotEmpty(ImportHeader."Error Message", 'Purchase staging error message should be populated.');
    end;

    [Test]
    procedure TransferImportWithoutLinesSetsError()
    var
        ImportHeader: Record "Jops TO Import Header";
        Processor: Codeunit "Jops TO Import Processor";
    begin
        ImportHeader.Init();
        ImportHeader."Transfer-from Code" := 'FROM';
        ImportHeader."Transfer-to Code" := 'TO';
        ImportHeader.Status := ImportHeader.Status::Pending;
        ImportHeader.Insert();

        Processor.ProcessPending();

        ImportHeader.Get(ImportHeader."Entry No.");
        AssertStatus(ImportHeader.Status, ImportHeader.Status::Error, 'Transfer staging record should be marked as Error.');
        AssertNotEmpty(ImportHeader."Error Message", 'Transfer staging error message should be populated.');
    end;

    [Test]
    procedure TransferArchiveMovesProcessedHeaderAndLines()
    var
        ImportHeader: Record "Jops TO Import Header";
        ImportLine: Record "Jops TO Import Line";
        ArchiveHeader: Record "Jops TO Import Header Archive";
        ArchiveLine: Record "Jops TO Import Line Archive";
        Archive: Codeunit "Jops TO Import Archive";
        EntryNo: Integer;
    begin
        ImportHeader.Init();
        ImportHeader.Status := ImportHeader.Status::Processed;
        ImportHeader."Transfer Order No." := 'TO-TEST-001';
        ImportHeader.Insert();
        EntryNo := ImportHeader."Entry No.";

        ImportLine.Init();
        ImportLine."Header Entry No." := EntryNo;
        ImportLine."Line No." := 10000;
        ImportLine."Item No." := 'TEST-ITEM';
        ImportLine.Quantity := 1;
        ImportLine.Insert();

        Archive.ArchiveFiltered(0D, 0D, 'TO-TEST-001', 'TEST-ITEM');

        if ImportHeader.Get(EntryNo) then
            Error('Processed transfer staging header should be deleted after archiving.');
        if ImportLine.Get(ImportLine."Entry No.") then
            Error('Processed transfer staging line should be deleted after archiving.');
        if not ArchiveHeader.Get(EntryNo) then
            Error('Transfer archive header should be created.');
        if not ArchiveLine.Get(ImportLine."Entry No.") then
            Error('Transfer archive line should be created.');
    end;

    local procedure AssertStatus(ActualStatus: Option Pending,Processed,Error; ExpectedStatus: Option Pending,Processed,Error; FailureMessage: Text)
    begin
        if ActualStatus <> ExpectedStatus then
            Error(FailureMessage);
    end;

    local procedure AssertNotEmpty(Value: Text[250]; FailureMessage: Text)
    begin
        if Value = '' then
            Error(FailureMessage);
    end;
}
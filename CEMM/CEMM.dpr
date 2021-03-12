program cemm;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {FrmMain},
  DataModuleUnit in 'DataModuleUnit.pas' {DataModule1: TDataModule};

{$R *.res}

begin
	ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

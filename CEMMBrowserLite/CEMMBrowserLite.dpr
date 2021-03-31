program CEMMBrowserLite;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {FrmMain};

{$R *.res}

begin
	ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

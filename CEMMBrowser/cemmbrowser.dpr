program cemmbrowser;

{$I cef.inc}

uses
  Vcl.Forms,
  {$IFDEF DELPHI16_UP}
  WinApi.Windows,
  {$ELSE}
  Windows,
  {$ENDIF }
  uCEFApplication,
  MainUnit in 'MainUnit.pas' {FrmMain};

{$R *.res}

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

begin
	ReportMemoryLeaksOnShutdown := true;
	CreateGlobalCEFApp;

  if GlobalCEFApp.StartMainProcess then
    begin
			Application.Initialize;
      {$IFDEF DELPHI11_UP}
			Application.MainFormOnTaskbar := True;
      {$ENDIF}
      Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
    end;

  DestroyGlobalCEFApp;
end.

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
  MainUnit in 'MainUnit.pas' {MiniBrowserFrm};

{$R *.res}

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

begin
  CreateGlobalCEFApp;

  if GlobalCEFApp.StartMainProcess then
    begin
			Application.Initialize;
      {$IFDEF DELPHI11_UP}
			Application.MainFormOnTaskbar := True;
      {$ENDIF}
      Application.CreateForm(TMiniBrowserFrm, MiniBrowserFrm);
  Application.Run;
    end;

  DestroyGlobalCEFApp;
end.

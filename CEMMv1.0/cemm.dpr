program cemm;

uses
  Vcl.Forms,
  uCEFApplication,
  MainUnit in 'MainUnit.pas' {FrmMain1},
  DataModuleUnit in 'DataModuleUnit.pas' {DataModule1: TDataModule},
  Main1Unit in 'Main1Unit.pas' {FrmMain},
  UISettingsUnit in 'UISettingsUnit.pas' {FrmUISettings};

{$R *.res}

begin
	ReportMemoryLeaksOnShutdown := true;
	CreateGlobalCEFApp;

  if GlobalCEFApp.StartMainProcess then
		begin

			Application.Initialize;
			Application.MainFormOnTaskbar := True;
			Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;



		end;

	DestroyGlobalCEFApp;
end.



(*




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


*)


program cemmbrowser;

uses
	Vcl.Forms,
 	uCEFApplication,
	MainUnit in 'MainUnit.pas' {FrmMain};

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

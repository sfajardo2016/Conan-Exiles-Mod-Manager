library PlgPlugInCEMPluginBrowserFull;

uses
	ShareMem,
  uCEFApplication,
  PlugInPlugInCEMPluginBrowserFull in 'PlugInPlugInCEMPluginBrowserFull.pas' {CEMPluginBrowserFull: TJvPlugIn},
  FormBrowserUnit2 in 'FormBrowserUnit2.pas' {FrmBrowser};

{$R *.res}

exports
  RegisterPlugin;

begin
	ReportMemoryLeaksOnShutdown := true;
	CreateGlobalCEFApp;
						 (*
	if GlobalCEFApp.StartMainProcess then
		begin



		end;

               *)
end.

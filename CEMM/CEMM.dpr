program cemm;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {FrmMain},
  UISettingsUnit in 'UISettingsUnit.pas' {FrmUISettings},
  DataModuleUnit in 'DataModuleUnit.pas' {DataModule1: TDataModule},
  SteamSettingsUnit in 'SteamSettingsUnit.pas' {FrmSteamSettings},
  AppSettingsUnit in 'AppSettingsUnit.pas' {FrmAppSettings},
  ModsSettingsUnit in 'ModsSettingsUnit.pas' {FrmModsSettings};

{$R *.res}

begin
	ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

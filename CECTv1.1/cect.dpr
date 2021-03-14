program cect;

uses
  Vcl.Forms,
  Main in 'Main.pas' {FrmMain},
  UnitSet in 'UnitSet.pas' {FrmSet},
  UnitInstalledMods in 'UnitInstalledMods.pas' {FrmInstalledMods},
  UnitDataModule in 'UnitDataModule.pas' {DataModule1: TDataModule},
  UnitPreview in 'UnitPreview.pas' {FrmPreview},
  UnitSettings in 'UnitSettings.pas' {FrmSettings},
  ABOUT in 'ABOUT.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.

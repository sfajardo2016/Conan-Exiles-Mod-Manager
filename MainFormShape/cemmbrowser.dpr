program cemmbrowser;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {FrmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Demo';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

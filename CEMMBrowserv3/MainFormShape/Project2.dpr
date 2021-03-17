program Project2;

uses
  Forms,
  AdvShaperDemo in 'AdvShaperDemo.pas' {FrmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Demo';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

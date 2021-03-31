program testnewwebvisitor;

uses
  Vcl.Forms,
  Unit7 in 'Unit7.pas' {Form7},
  uCEFBrowserThread in 'uCEFBrowserThread.pas',
  uWebpageSnapshot in 'uWebpageSnapshot.pas' {WebpageSnapshotFrm};

{$R *.res}

begin





	Application.Initialize;
	Application.MainFormOnTaskbar := True;
	Application.CreateForm(TWebpageSnapshotFrm, WebpageSnapshotFrm);
  Application.Run;



end.

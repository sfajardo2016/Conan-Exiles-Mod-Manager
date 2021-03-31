unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs,

	uCEFBrowserThread,

	HTMLUn2, HtmlView, Vcl.StdCtrls;

type
  TForm7 = class(TForm)
    HtmlViewer_1: THtmlViewer;
    Button_1: TButton;
    procedure Button_1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
		{ Private declarations }
		 FThread : TCEFBrowserThread;
    procedure Thread_OnError(Sender: TObject);
    procedure Thread_OnSnapshotAvailable(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}
uses
  uCEFApplication;

procedure TForm7.Button_1Click(Sender: TObject);
var
	TheURL: String;

begin

	TheURL:= 'https://steamcommunity.com/sharedfiles/filedetails/?id=1113901982';


  if (FThread = nil) then
    begin
			FThread                     := TCEFBrowserThread.Create(TheURL, 1024, 768);
      FThread.OnError             := Thread_OnError;
      FThread.OnSnapshotAvailable := Thread_OnSnapshotAvailable;
      FThread.SyncEvents          := True;
      FThread.Start;
    end
	 else


		FThread.LoadUrl(TheURL);

end;



//Error
procedure TForm7.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (FThread <> nil) then
    begin
      if FThread.TerminateBrowserThread then
        FThread.WaitFor;

      FreeAndNil(FThread);
    end;

	CanClose := True;

end;

procedure TForm7.Thread_OnError(Sender: TObject);
begin
	ShowMessage('Error ' + inttostr(FThread.ErrorCode) + ' : ' + FThread.ErrorText + ' - ' + FThread.FailedUrl );
end;


procedure TForm7.Thread_OnSnapshotAvailable(Sender: TObject);

begin

	if (FThread <> nil)  then
		begin

			ShowMessage('Snapshot copied successfully');


		end
	 else ShowMessage('error while Snapshot copied');

end;



end.

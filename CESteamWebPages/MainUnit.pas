unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uCEFChromiumCore,
  uCEFChromium, uCEFWinControl, uCEFWindowParent, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    Button_1: TButton;
    panel_1: TPanel;
    CEFWindowParent1: TCEFWindowParent;
    Chromium1: TChromium;
    Timer_1: TTimer;
    procedure Button_1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer_1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button_1Click(Sender: TObject);
begin
	Chromium1.LoadURL('https://steamcommunity.com/sharedfiles/filedetails/?id=2323901287');
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Chromium1.MultiBrowserMode := True;
	Chromium1.DefaultURL       := 'https://steamcommunity.com/sharedfiles/filedetails/?id=2323901287';
 if not(Chromium1.CreateBrowser(CEFWindowParent1, '')) then Timer_1.Enabled := True;


end;

procedure TForm2.Timer_1Timer(Sender: TObject);
begin
	Timer_1.Enabled := False;
	if not(Chromium1.CreateBrowser(CEFWindowParent1, '')) and not(Chromium1.Initialized) then
		Timer_1.Enabled := True;
end;

end.

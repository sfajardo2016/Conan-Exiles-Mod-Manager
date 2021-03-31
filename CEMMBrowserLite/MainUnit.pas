unit MainUnit;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,

	ActiveX, MSHTML,


  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdCookieManager, IdAntiFreezeBase, Vcl.IdAntiFreeze, HTMLUn2, HtmlView,
  bsSkinCtrls, bsSkinBoxCtrls;

type
  TFrmMain = class(TForm)
    Button1: TButton;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdCookieManager1: TIdCookieManager;
		IdAntiFreeze1: TIdAntiFreeze;
    procedure Button1Click(Sender: TObject);
  private
		function GetLink(ThisLink: String;out WebPageLines:TStringList): Boolean;
    function GetWebPageTitle(ThisPageLines: TStringList): String;
    function GetDescription(ThisPageLines: TStringList): String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.Button1Click(Sender: TObject);
var
	ThisLink: String;
	ThisPageLines: TStringList;
begin


ThisLink := 'https://steamcommunity.com/sharedfiles/filedetails/?id=1113901982';
ThisPageLines := TStringList.Create;

if GetLink(ThisLink,ThisPageLines) then begin


end;


FreeAndNil(ThisPageLines);

end;



function TFrmMain.GetDescription(ThisPageLines:TStringList): String;
var
  ThisResult: String;
	doc: OleVariant;
	el: OleVariant;
	i: Integer;
	HTML: String;
	ThisFile:String;
begin
	ThisResult := 'N/A';

	doc := coHTMLDocument.Create as IHTMLDocument2;

	HTML := ThisPageLines.Text;
	doc.write(HTML);
	doc.close;

	for i := 0 to doc.body.all.length - 1 do
	begin
		el := doc.body.all.item(i);
		if (el.tagName = 'DIV') and (el.className = 'workshopItemDescription') then begin
			ThisResult := el.innerHTML ;
			break;
		end;

	end;


result := ThisResult;
end;



function TFrmMain.GetWebPageTitle(ThisPageLines:TStringList): String;
var
	ThisResult: String;
	I: Integer;
begin
ThisResult := 'N/A';

	for I := 0 to ThisPageLines.Count-1 do begin
		if ( ThisPageLines[I].Contains('<title>Steam Workshop::') ) then begin
			ThisResult := ThisPageLines[I].Replace('<title>Steam Workshop::','').Replace('</title>','').Trim();
			Break;
		end;
  end;








result := ThisResult;
end;


function TFrmMain.GetLink(ThisLink:String; out WebPageLines:TStringList): Boolean;
var
	ThisResult: Boolean;
	RawPage:  TStringStream;

begin
	ThisResult := False;

	RawPage := TStringStream.Create;


	IdHTTP1.Get(ThisLink,RawPage);


	WebPageLines.Text := RawPage.DataString;

	if (WebPageLines.Count>0) then ThisResult := True;

	FreeAndNil(RawPage);



result := ThisResult;
end;





end.

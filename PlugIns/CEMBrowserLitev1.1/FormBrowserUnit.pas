unit FormBrowserUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsSkinData, BusinessSkinForm,
  bsSkinCtrls, HTMLUn2, HtmlView, Vcl.Menus, bsSkinMenus, IdCookieManager,
	IdBaseComponent, IdComponent, IdIOHandler, IdIOHandlerSocket,
	MSHTML,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdTCPConnection, IdTCPClient,
  IdHTTP, IdAntiFreezeBase, Vcl.IdAntiFreeze, FramView, FramBrwz,
  Vcl.StdCtrls, bsSkinBoxCtrls, JvAppStorage, JvComponentBase,
  JvAppIniStorage, JvFormPlacement, bsTrayIcon;

type
  TFrmBrowser = class(TForm)
    CompressedSkinList_Main: TbsCompressedSkinList;
    Theme: TbsSkinData;
    BusinessSkinForm_Main: TbsBusinessSkinForm;
    StatusBar_Browser: TbsSkinStatusBar;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    idCookieManager_1: TIdCookieManager;
    idhttp: TIdHTTP;
    IdAntiFreeze1: TIdAntiFreeze;
    FrameBrowser1: TFrameBrowser;
    bsSkinStdLabel1: TbsSkinStdLabel;
    Font: TbsSkinFontComboBox;
    bsSkinStdLabel3: TbsSkinStdLabel;
    Zoom: TbsSkinSlider;
    JvAppIniFileStorage1: TJvAppIniFileStorage;
    JvFormStorage1: TJvFormStorage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
		procedure FontChange(Sender: TObject);
    procedure ZoomChange(Sender: TObject);
    procedure bsTrayIcon1DblClick(Sender: TObject);
	private

		LastModID:String;
		ModPage: String;
    function GetDescription(ThisPageLines: TStringList): String;
    function GetWebPageTitle(ThisPageLines: TStringList): String;
    function GetModUpdateStats(ThisPageLines: TStringList; out DatePosted,
      DateUpdated: String): Boolean;
		{ Private declarations }
	public
		{ Public declarations }
    procedure VisitWebPage(ThisModID: String; out ModTitle, ModDescription,ModPosted,ModUpdated:String);
	end;

var
	FrmBrowser: TFrmBrowser;

implementation

{$R *.dfm}

procedure TFrmBrowser.FontChange(Sender: TObject);

begin

	FrameBrowser1.DefFontName := Font.FontName;
	FrameBrowser1.LoadFromString(ModPage);





end;

procedure TFrmBrowser.ZoomChange(Sender: TObject);
begin

	FrameBrowser1.DefFontSize := Zoom.Value;
	FrameBrowser1.LoadFromString(ModPage);


end;

procedure TFrmBrowser.bsTrayIcon1DblClick(Sender: TObject);
begin
FrmBrowser.WindowState := wsNormal;
end;

procedure TFrmBrowser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//Action := caFree;
end;

procedure TFrmBrowser.FormCreate(Sender: TObject);
begin

	LastModID := '';
	ModPage   := '';
//	Font.FontName := FrameBrowser1.DefFontName;
//	Font.Refresh;






end;

procedure TFrmBrowser.VisitWebPage(ThisModID:String; out ModTitle, ModDescription,ModPosted,ModUpdated:String);
var
	ThisPageLines: TStringList;
	RawPage:  TStringStream;
begin
	if (LastModID.Equals(ThisModID)) then begin


	 exit;
	end;


 LastModID := ThisModID;
 RawPage := TStringStream.Create;

 ThisPageLines := TStringList.Create;


IdHTTP.Get('https://steamcommunity.com/sharedfiles/filedetails/?id='+ThisModID,RawPage);

ThisPageLines.Text:= RawPage.DataString ;
FreeAndNil(RawPage);


ModDescription := GetDescription(ThisPageLines);
ModTitle := GetWebPageTitle(ThisPageLines);

GetModUpdateStats(ThisPageLines,ModPosted,ModUpdated);

ModPage := ModDescription;
FrameBrowser1.LoadFromString(ModDescription);


FrameBrowser1.ModTitle := ModTitle;


FreeAndNil(ThisPageLines);

end;


function TFrmBrowser.GetWebPageTitle(ThisPageLines:TStringList): String;
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


function TFrmBrowser.GetModUpdateStats(ThisPageLines: TStringList; out DatePosted,DateUpdated:String):Boolean;
var
  ThisResult: String;
	doc: OleVariant;
	el: OleVariant;
	i: Integer;
	iStat:Integer;

begin
	iStat:= 0;

	doc := coHTMLDocument.Create as IHTMLDocument2;
	DatePosted := '';
	DateUpdated := '';

	doc.write(ThisPageLines.Text);
	doc.close;

	for i := 0 to doc.body.all.length - 1 do
	begin
		el := doc.body.all.item(i);
		if (el.tagName = 'DIV') and (el.className = 'detailsStatRight') then begin
			Inc(iStat);
			case iStat of
				1:Begin //size


				End;
				2:Begin

					DatePosted := el.innerText ;

				End;
				3:Begin
					DateUpdated :=el.innerText ;
          Break;
				End;
			end;

		end;

	end;


//

	exit(true);
end;


function TFrmBrowser.GetDescription(ThisPageLines:TStringList): String;
var
  ThisResult: String;
	doc: OleVariant;
	el: OleVariant;
	i: Integer;

begin
	ThisResult := 'N/A';

	doc := coHTMLDocument.Create as IHTMLDocument2;


	doc.write(ThisPageLines.Text);
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




end.

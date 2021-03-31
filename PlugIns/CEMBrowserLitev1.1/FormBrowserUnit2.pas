unit FormBrowserUnit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsSkinData, BusinessSkinForm,
  bsSkinCtrls, HTMLUn2, HtmlView, Vcl.Menus, bsSkinMenus, IdCookieManager,
	IdBaseComponent, IdComponent, IdIOHandler, IdIOHandlerSocket,

	MSHTML,
	uCEFApplication,
	uCEFConstants,
	uCEFInterfaces,
	uCEFTypes,

  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdTCPConnection, IdTCPClient,
  IdHTTP, IdAntiFreezeBase, Vcl.IdAntiFreeze, FramView, FramBrwz,
  Vcl.StdCtrls, bsSkinBoxCtrls, JvAppStorage, JvComponentBase,
  JvAppIniStorage, JvFormPlacement, bsTrayIcon, uCEFChromiumCore,
  uCEFChromium, uCEFWinControl, uCEFWindowParent;

type
  TFrmBrowser2 = class(TForm)
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
    Chromium1: TChromium;
    CEFWindowParent1: TCEFWindowParent;
    procedure FormCreate(Sender: TObject);
		procedure FontChange(Sender: TObject);
    procedure ZoomChange(Sender: TObject);
		procedure bsTrayIcon1DblClick(Sender: TObject);
    procedure Chromium1AfterCreated(Sender: TObject;const browser: ICefBrowser);
    procedure Chromium1BeforeBrowse(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest; user_gesture, isRedirect: Boolean;
      out Result: Boolean);
    procedure Chromium1BeforeClose(Sender: TObject;
      const browser: ICefBrowser);
    procedure Chromium1BeforeContextMenu(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      const params: ICefContextMenuParams; const model: ICefMenuModel);
    procedure Chromium1BeforePluginLoad(Sender: TObject; const mimeType,
      pluginUrl: ustring; isMainFrame: Boolean;
      const topOriginUrl: ustring; const pluginInfo: ICefWebPluginInfo;
      var pluginPolicy: TCefPluginPolicy; var aResult: Boolean);
    procedure Chromium1BeforePopup(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame; const targetUrl,
      targetFrameName: ustring;
      targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean;
      const popupFeatures: TCefPopupFeatures;
      var windowInfo: TCefWindowInfo; var client: ICefClient;
      var settings: TCefBrowserSettings;
      var extra_info: ICefDictionaryValue; var noJavascriptAccess,
      Result: Boolean);
    procedure Chromium1BeforeResourceLoad(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest; const callback: ICefRequestCallback;
      out Result: TCefReturnValue);
    procedure Chromium1Close(Sender: TObject; const browser: ICefBrowser;
      var aAction: TCefCloseBrowserAction);
	protected
    FCanClose : boolean;  // Set to True in TChromium.OnBeforeClose
		FClosing  : boolean;  // Set to True in the CloseQuery event.

	private

		LastModID:String;
		ModPage: String;
		CanLoadANewPage:Boolean;
    function GetDescription(ThisPageLines: TStringList): String;
    function GetWebPageTitle(ThisPageLines: TStringList): String;
    function GetModUpdateStats(ThisPageLines: TStringList; out DatePosted,
      DateUpdated: String): Boolean;
		{ Private declarations }
	public
		{ Public declarations }
    procedure VisitWebPage(ThisModID: String; out ModTitle, ModDescription,ModPosted,ModUpdated:String);
	end;

procedure CreateGlobalCEFApp;

var
	FrmBrowser: TFrmBrowser2;

implementation

{$R *.dfm}



procedure CreateGlobalCEFApp;
begin
		GlobalCEFApp                     := TCefApplication.Create;
//  GlobalCEFApp.LogFile             := 'debug.log';
	GlobalCEFApp.LogSeverity         := LOGSEVERITY_DISABLE;
	GlobalCEFApp.cache               := 'cache';
	GlobalCEFApp.EnableHighDPISupport:= true;
//	GlobalCEFApp.EnablePrintPreview  := True;
  // This is a workaround for the CEF4Delphi issue #324 :
  // https://github.com/salvadordf/CEF4Delphi/issues/324
  GlobalCEFApp.DisableFeatures := 'WinUseBrowserSpellChecker';
end;


procedure TFrmBrowser2.Chromium1AfterCreated(Sender: TObject;
  const browser: ICefBrowser);
begin
  if Chromium1.IsSameBrowser(browser) then
    PostMessage(Handle, CEF_AFTERCREATED, 0, 0)
   else
    SendMessage(browser.Host.WindowHandle, WM_SETICON, 1, application.Icon.Handle); // Use the same icon in the popup window
end;

procedure TFrmBrowser2.Chromium1BeforeBrowse(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  const request: ICefRequest; user_gesture, isRedirect: Boolean;
	out Result: Boolean);
		var
		ThisURL: String;
begin


Result := False;
exit;

ThisURL := request.Url;

if ((ThisURL.ToUpper.Contains('FILEDETAILS/CHANGELOG')) or
//(ThisURL.ToUpper.Contains('FILEDETAILS/DISCUSSIONS')) or  //NO DISCUTTIONS and it needs to load more pages
	 (ThisURL.ToUpper.Contains('FILEDETAILS/?ID=')) or
	 (ThisURL.ToUpper.Contains('FILEDETAILS/COMMENTS'))) and
	 (ThisURL.ToUpper.Contains(LastModID)) then Result := false ELSE Result := Not (CanLoadANewPage); //let



end;

procedure TFrmBrowser2.Chromium1BeforeClose(Sender: TObject;
  const browser: ICefBrowser);
begin
  // The main browser is being destroyed
  if (Chromium1.BrowserId = 0) then
    begin
			FCanClose := True;
      PostMessage(Handle, WM_CLOSE, 0, 0);
    end;

end;

procedure TFrmBrowser2.Chromium1BeforeContextMenu(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  const params: ICefContextMenuParams; const model: ICefMenuModel);
begin
//model.clear; //disable context menu
end;

procedure TFrmBrowser2.Chromium1BeforePluginLoad(Sender: TObject;
  const mimeType, pluginUrl: ustring; isMainFrame: Boolean;
  const topOriginUrl: ustring; const pluginInfo: ICefWebPluginInfo;
  var pluginPolicy: TCefPluginPolicy; var aResult: Boolean);
begin
  // Always allow the PDF plugin to load.
  if (pluginPolicy <> PLUGIN_POLICY_ALLOW) and
     (CompareText(mimeType, 'application/pdf') = 0) then
    begin
      pluginPolicy := PLUGIN_POLICY_ALLOW;
      aResult      := True;
    end
   else
		aResult := False;

end;

procedure TFrmBrowser2.Chromium1BeforePopup(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; const targetUrl,
  targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition;
  userGesture: Boolean; const popupFeatures: TCefPopupFeatures;
	var windowInfo: TCefWindowInfo; var client: ICefClient;
  var settings: TCefBrowserSettings; var extra_info: ICefDictionaryValue;
  var noJavascriptAccess, Result: Boolean);
begin
//	Result := (targetDisposition in [WOD_NEW_FOREGROUND_TAB, WOD_NEW_BACKGROUND_TAB, WOD_NEW_POPUP, WOD_NEW_WINDOW]);
end;

procedure TFrmBrowser2.Chromium1BeforeResourceLoad(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  const request: ICefRequest; const callback: ICefRequestCallback;
	out Result: TCefReturnValue);
begin
  Result := RV_CONTINUE;
end;

procedure TFrmBrowser2.Chromium1Close(Sender: TObject;
  const browser: ICefBrowser; var aAction: TCefCloseBrowserAction);
begin
	if (browser <> nil) and
		 (Chromium1.BrowserId = browser.Identifier) and
		 (CEFWindowParent1 <> nil) then
		begin
			PostMessage(Handle, CEF_DESTROY, 0, 0);
			aAction := cbaDelay;
    end;
end;

procedure TFrmBrowser2.FontChange(Sender: TObject);

begin

	FrameBrowser1.DefFontName := Font.FontName;
	FrameBrowser1.LoadFromString(ModPage);

	Chromium1.LoadString(ModPage);




end;

procedure TFrmBrowser2.ZoomChange(Sender: TObject);
begin

	FrameBrowser1.DefFontSize := Zoom.Value;


end;

procedure TFrmBrowser2.bsTrayIcon1DblClick(Sender: TObject);
begin
FrmBrowser.WindowState := wsNormal;
end;

procedure TFrmBrowser2.FormCreate(Sender: TObject);
begin

	LastModID := '';
	ModPage   := '';
  FCanClose := False;
	FClosing  := False;
 CreateGlobalCEFApp;


end;

procedure TFrmBrowser2.VisitWebPage(ThisModID:String; out ModTitle, ModDescription,ModPosted,ModUpdated:String);
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

CanLoadANewPage:=True;
Chromium1.LoadString( ThisPageLines.Text );



FreeAndNil(ThisPageLines);

end;


function TFrmBrowser2.GetWebPageTitle(ThisPageLines:TStringList): String;
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


function TFrmBrowser2.GetModUpdateStats(ThisPageLines: TStringList; out DatePosted,DateUpdated:String):Boolean;
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


function TFrmBrowser2.GetDescription(ThisPageLines:TStringList): String;
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

unit MainUnit;

//{$I cef.inc}

interface

uses

	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics, Vcl.Menus, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
	Vcl.StdCtrls, Vcl.ExtCtrls, System.Types, Vcl.ComCtrls, Vcl.ClipBrd,
	System.UITypes, Vcl.AppEvnts, Winapi.ActiveX, Winapi.ShlObj,
	System.NetEncoding,

	Cromis.IPC, //IPC Server

	//uCEFApplicationCore,
	uCEFProcessMessage,
	uCEFDomVisitor,

	uCEFChromium, uCEFWindowParent, uCEFInterfaces, uCEFApplication, uCEFTypes,
	uCEFConstants, uCEFWinControl, uCEFSentinel, uCEFChromiumCore, mswheel,
	bsSkinCtrls, JvAppInst, bsSkinData, BusinessSkinForm, JvAppStorage,
  JvAppIniStorage, JvComponentBase, JvFormPlacement, JvHtmlParser;

const
	MINIBROWSER_VISITDOM_FULL   = WM_APP + $102;
	DOMVISITOR_MSGNAME_FULL     = 'domvisitorfull';
  RETRIEVEDOM_MSGNAME_FULL    = 'retrievedomfull';

type
	TDTVisitStatus = (dvsIdle, dvsGettingDocNodeID, dvsQueryingSelector, dvsSettingAttributeValue);


type
	TFrmMain = class(TForm)
		CEFWindowParent1: TCEFWindowParent;
		Chromium1: TChromium;
    DevTools: TCEFWindowParent;
    Timer1: TTimer;
    StatusBar_Browser: TbsSkinStatusBar;
    StatusPanel_Browser: TbsSkinStatusPanel;
    Slider_BrowserZoom: TbsSkinSlider;
    StatusPanel_Zoom: TbsSkinStatusPanel;
    AppInstance_1: TJvAppInstances;
    CompressedSkinList_Main: TbsCompressedSkinList;
    SkinData_Main: TbsSkinData;
    BusinessSkinForm_Main: TbsBusinessSkinForm;
    FormStorage_Main: TJvFormStorage;
    AppIniFileStorage_Main: TJvAppIniFileStorage;
    HTMLParser_1: TJvHTMLParser;

		procedure VisitDOM2Msg(var aMessage : TMessage); message MINIBROWSER_VISITDOM_FULL;


    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure Chromium1AfterCreated(Sender: TObject; const browser: ICefBrowser);
    procedure Chromium1LoadingStateChange(Sender: TObject; const browser: ICefBrowser; isLoading, canGoBack, canGoForward: Boolean);
    procedure Chromium1TitleChange(Sender: TObject; const browser: ICefBrowser; const title: ustring);
    procedure Chromium1StatusMessage(Sender: TObject; const browser: ICefBrowser; const value: ustring);
    procedure Chromium1BeforeResourceLoad(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const request: ICefRequest; const callback: ICefRequestCallback; out Result: TCefReturnValue);
    procedure Chromium1Close(Sender: TObject; const browser: ICefBrowser; var aAction : TCefCloseBrowserAction);
    procedure Chromium1BeforeClose(Sender: TObject; const browser: ICefBrowser);
    procedure Chromium1LoadingProgressChange(Sender: TObject; const browser: ICefBrowser; const progress: Double);
    procedure Chromium1LoadEnd(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
    procedure Chromium1LoadError(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; errorCode: Integer; const errorText, failedUrl: ustring);
    procedure Chromium1BeforePluginLoad(Sender: TObject; const mimeType, pluginUrl: ustring; isMainFrame: Boolean; const topOriginUrl: ustring; const pluginInfo: ICefWebPluginInfo; var pluginPolicy: TCefPluginPolicy; var aResult: Boolean);
    procedure Timer1Timer(Sender: TObject);
		procedure Slider_BrowserZoomChange(Sender: TObject);
    procedure Chromium1BeforeContextMenu(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      const params: ICefContextMenuParams; const model: ICefMenuModel);
    procedure Chromium1BeforePopup(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame; const targetUrl,
      targetFrameName: ustring;
      targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean;
      const popupFeatures: TCefPopupFeatures;
      var windowInfo: TCefWindowInfo; var client: ICefClient;
      var settings: TCefBrowserSettings;
      var extra_info: ICefDictionaryValue; var noJavascriptAccess,
      Result: Boolean);
    procedure Chromium1ProcessMessageReceived(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      sourceProcess: TCefProcessId; const message: ICefProcessMessage;
      out Result: Boolean);
    procedure Chromium1BeforeBrowse(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest; user_gesture, isRedirect: Boolean;
      out Result: Boolean);

	private
			FIPCServer: TIPCServer;
			FirstRun: Boolean;
			PageTitle:String;
			PageLoaded : Boolean;
			IslandMode: Boolean;
			LastURL: String;
			PageFullText: String;
			ThisModDescription: String;
			CanLoadANewPage: Boolean;
			UpdateCache: Boolean;
		procedure SetUpIPCServer;
		procedure OnExecuteRequest(const Request, Response: IIPCData);
		procedure TaskDone;
		procedure ShowDefaultPage;
    function GetModDescription(ThisFullText: String): String;

  protected

    FResponse   : TStringList;
    FRequest    : TStringList;
    FNavigation : TStringList;
    // Variables to control when can we destroy the form safely
    FCanClose : boolean;  // Set to True in TChromium.OnBeforeClose
    FClosing  : boolean;  // Set to True in the CloseQuery event.



    procedure BrowserCreatedMsg(var aMessage : TMessage); message CEF_AFTERCREATED;
    procedure BrowserDestroyMsg(var aMessage : TMessage); message CEF_DESTROY;



    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;

  public
    procedure ShowStatusText(const aText : string);

  end;

var
  FrmMain : TFrmMain;

procedure CreateGlobalCEFApp;

implementation

{$R *.dfm}

procedure DOMVisitor_OnDocAvailableFullMarkup(const browser: ICefBrowser; const frame: ICefFrame; const document: ICefDomDocument);
var
  TempMessage : ICefProcessMessage;
begin
  // Sending back some custom results to the browser process
  // Notice that the DOMVISITOR_MSGNAME_FULL message name needs to be recognized in
  // Chromium1ProcessMessageReceived
  try
    TempMessage := TCefProcessMessageRef.New(DOMVISITOR_MSGNAME_FULL);
    TempMessage.ArgumentList.SetString(0, document.Body.AsMarkup);

    if (frame <> nil) and frame.IsValid then
      frame.SendProcessMessage(PID_BROWSER, TempMessage);
  finally
    TempMessage := nil;
	end;
end;

procedure GlobalCEFApp_OnProcessMessageReceived(const browser       : ICefBrowser;
                                                const frame         : ICefFrame;
                                                      sourceProcess : TCefProcessId;
                                                const message       : ICefProcessMessage;
                                                var   aHandled      : boolean);
var
  TempVisitor : TCefFastDomVisitor2;
begin
  aHandled := False;

  if (browser <> nil) then
    begin
				if (message.name = RETRIEVEDOM_MSGNAME_FULL) then
					begin
						if (frame <> nil) and frame.IsValid then
							begin
								TempVisitor := TCefFastDomVisitor2.Create(browser, frame, DOMVisitor_OnDocAvailableFullMarkup);
								frame.VisitDom(TempVisitor);
							end;

						aHandled := True;
					end;

    end;
end;


procedure CreateGlobalCEFApp;
begin
	GlobalCEFApp                     := TCefApplication.Create;
//  GlobalCEFApp.LogFile             := 'debug.log';


	GlobalCEFApp.OnProcessMessageReceived := GlobalCEFApp_OnProcessMessageReceived;

	GlobalCEFApp.LogSeverity         := LOGSEVERITY_DISABLE;
	GlobalCEFApp.cache               := 'cache';
//	GlobalCEFApp.EnablePrintPreview  := True;
  // This is a workaround for the CEF4Delphi issue #324 :
  // https://github.com/salvadordf/CEF4Delphi/issues/324
  GlobalCEFApp.DisableFeatures := 'WinUseBrowserSpellChecker';
end;

procedure TFrmMain.Chromium1AfterCreated(Sender: TObject; const browser: ICefBrowser);
begin
  if Chromium1.IsSameBrowser(browser) then
    PostMessage(Handle, CEF_AFTERCREATED, 0, 0)
   else
    SendMessage(browser.Host.WindowHandle, WM_SETICON, 1, application.Icon.Handle); // Use the same icon in the popup window
end;

procedure TFrmMain.Chromium1BeforeBrowse(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  const request: ICefRequest; user_gesture, isRedirect: Boolean;
  out Result: Boolean);
begin

Result := Not (CanLoadANewPage);


//if   then Result := true else Result := false;

end;

procedure TFrmMain.Chromium1BeforeClose(Sender: TObject; const browser: ICefBrowser);
begin
  // The main browser is being destroyed
  if (Chromium1.BrowserId = 0) then
    begin
      FCanClose := True;
      PostMessage(Handle, WM_CLOSE, 0, 0);
    end;
end;




procedure TFrmMain.Chromium1BeforeContextMenu(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  const params: ICefContextMenuParams; const model: ICefMenuModel);
begin
model.clear; //disable context menu
end;

procedure TFrmMain.Chromium1BeforePluginLoad(Sender: TObject;
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

procedure TFrmMain.Chromium1BeforePopup(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; const targetUrl,
  targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition;
  userGesture: Boolean; const popupFeatures: TCefPopupFeatures;
  var windowInfo: TCefWindowInfo; var client: ICefClient;
  var settings: TCefBrowserSettings; var extra_info: ICefDictionaryValue;
  var noJavascriptAccess, Result: Boolean);
begin
//Disable popups and new windows


	Result := (targetDisposition in [WOD_NEW_FOREGROUND_TAB, WOD_NEW_BACKGROUND_TAB, WOD_NEW_POPUP, WOD_NEW_WINDOW]);
end;

procedure TFrmMain.Chromium1BeforeResourceLoad(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  const request: ICefRequest; const callback: ICefRequestCallback;
  out Result: TCefReturnValue);
begin
  Result := RV_CONTINUE;



end;

procedure TFrmMain.Chromium1Close(Sender: TObject; const browser: ICefBrowser; var aAction : TCefCloseBrowserAction);
begin
  if (browser <> nil) and
     (Chromium1.BrowserId = browser.Identifier) and
     (CEFWindowParent1 <> nil) then
    begin
      PostMessage(Handle, CEF_DESTROY, 0, 0);
      aAction := cbaDelay;
    end;
end;



procedure TFrmMain.Chromium1LoadEnd(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  httpStatusCode: Integer);
var
  TempHandle : THandle;
begin
  if FClosing or (frame = nil) or not(frame.IsValid) or (browser = nil) then exit;

  if Chromium1.IsSameBrowser(browser) then
    begin
    end
   else
    begin
      // This is a workaround for a focus issue in popup windows handled by CEF
      TempHandle := WinApi.Windows.GetWindow(Browser.Host.WindowHandle, GW_OWNER);
      if (TempHandle <> Handle) then
        WinApi.Windows.SetFocus(TempHandle);
    end;
end;

procedure TFrmMain.Chromium1LoadError(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; errorCode: Integer;
  const errorText, failedUrl: ustring);
var
  TempString : string;
begin
  if (errorCode = ERR_ABORTED) then exit;

  TempString := '<html><body bgcolor="white">' +
                '<h2>Failed to load URL ' + failedUrl +
                ' with error ' + errorText +
                ' (' + inttostr(errorCode) + ').</h2></body></html>';

	Chromium1.LoadString(TempString, frame);



end;

procedure TFrmMain.Chromium1LoadingProgressChange(Sender: TObject;
  const browser: ICefBrowser; const progress: Double);
begin
	StatusPanel_Browser.Caption := 'Loading... ' + FloatToStrF(progress * 100, ffFixed, 3, 0) + '%';
	if (progress*100) = 100  then StatusPanel_Browser.Caption := 'Done';

end;

procedure TFrmMain.Chromium1LoadingStateChange(Sender: TObject;
	const browser: ICefBrowser; isLoading, canGoBack, canGoForward: Boolean);
begin
	PageLoaded := false;

  if not(Chromium1.IsSameBrowser(browser)) or FClosing then exit;
  if isLoading then
    begin
			StatusPanel_Browser.Caption := 'Loading...';
		end
	 else
		begin
			StatusPanel_Browser.Caption := 'Done';
			caption := 'Conan Exiles Steam Mod Browser';
			CanLoadANewPage := false;
			if (FirstRun) then Begin
				FirstRun := False;
				ShowDefaultPage;

			End else begin
				PostMessage(Handle, MINIBROWSER_VISITDOM_FULL, 0, 0);
      end;

		end;
end;


procedure TFrmMain.Chromium1ProcessMessageReceived(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  sourceProcess: TCefProcessId; const message: ICefProcessMessage;
  out Result: Boolean);
begin
  Result := False;

	if (message = nil) or (message.ArgumentList = nil) then begin
		exit;
	end;


		if (message.Name = DOMVISITOR_MSGNAME_FULL) then
			begin
				PageFullText := message.ArgumentList.GetString(0);
				PageLoaded := true;
				Result := True;
			end;





end;

procedure TFrmMain.ShowStatusText(const aText : string);
begin
//if not(FClosing) then StatusPanel_Browser.Caption := aText;
end;




procedure TFrmMain.Slider_BrowserZoomChange(Sender: TObject);
begin
  Chromium1.ZoomLevel := Slider_BrowserZoom.Value*0.1;
end;

procedure TFrmMain.Chromium1StatusMessage(Sender: TObject;
  const browser: ICefBrowser; const value: ustring);
begin
  if Chromium1.IsSameBrowser(browser) then ShowStatusText(value);
end;

procedure TFrmMain.Chromium1TitleChange(Sender: TObject;
  const browser: ICefBrowser; const title: ustring);
begin
  if not(Chromium1.IsSameBrowser(browser)) then exit;

	if (FirstRun) then PageTitle :=''   else PageTitle := title;


	//Show same caption
	caption := 'Conan Exiles Steam Mod Browser';

(*
	if (title <> '') then
		caption := title
	 else
		caption := 'Conan Exiles Steam Mod Browser';
		*)
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := FCanClose;

  if not(FClosing) then
    begin
      FClosing := True;
      Visible  := False;
			Chromium1.CloseAllBrowsers;
			Chromium1.ClearCache;
			Chromium1.DeleteCookies();


    end;

		//Clear chache


end;


procedure TFrmMain.FormCreate(Sender: TObject);
begin
	FCanClose            := False;
	FClosing             := False;
	FResponse            := TStringList.Create;
	FRequest             := TStringList.Create;
	FNavigation          := TStringList.Create;

	FirstRun             := True;
	LastURL              := '';

	CanLoadANewPage := False;


	Chromium1.MultiBrowserMode := False;


	SetUpIPCServer;


end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
try
	if ( FIPCServer.Listening ) then  FIPCServer.Stop;
except

end;

	FreeAndNil(FIPCServer);
  FResponse.Free;
  FRequest.Free;
  FNavigation.Free;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  ShowStatusText('Please wait...');
	Chromium1.WebRTCIPHandlingPolicy := hpDisableNonProxiedUDP;
	Chromium1.WebRTCMultipleRoutes   := STATE_DISABLED;
	Chromium1.WebRTCNonproxiedUDP    := STATE_DISABLED;
  if not(Chromium1.CreateBrowser(CEFWindowParent1, '')) then Timer1.Enabled := True;
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  if not(Chromium1.CreateBrowser(CEFWindowParent1, '')) and not(Chromium1.Initialized) then
    Timer1.Enabled := True;
end;


procedure TFrmMain.ShowDefaultPage();
var
TempString :String;
TempStatus: Boolean;
begin
	TempString := '<html xmlns="http://www.w3.org/1999/xhtml"><head>'+
		'<meta http-equiv="Content-Type" content="text/html; charset=utf-8">'+
		'<title>Conan Exiles Web Browser</title></head>'+
		'<body>'+
		'<div id="page">'+
				'<div class="contentTitle">'+
						'<h1>Conan Exiles Web Browser</h1>'+
						'<hr>'+
				'</div>'+
				'<div class="contentText">'+
						'<p>Waiting the Conan Exiles Mod Manager signal...</p>'+
						'<p>For support visit .........</p>'+

						'<p>&nbsp;</p>'+
				'</div>'+
'</div>';

//Chromium1.LoadURL('https://steamcommunity.com/sharedfiles/filedetails/?id=2384014945');

	CanLoadANewPage:=True;
	Chromium1.LoadString(TempString);



end;
procedure TFrmMain.BrowserCreatedMsg(var aMessage : TMessage);
begin
  CEFWindowParent1.UpdateSize;

end;

procedure TFrmMain.BrowserDestroyMsg(var aMessage : TMessage);
begin
  FreeAndNil(CEFWindowParent1);
end;

procedure TFrmMain.WMMove(var aMessage : TWMMove);
begin
	inherited;

	if (Chromium1 <> nil) then Chromium1.NotifyMoveOrResizeStarted;
end;

procedure TFrmMain.WMMoving(var aMessage : TMessage);
begin
	inherited;

	if (Chromium1 <> nil) then Chromium1.NotifyMoveOrResizeStarted;
end;


procedure TFrmMain.SetUpIPCServer();
begin

	FIPCServer := TIPCServer.Create;
	FIPCServer.OnExecuteRequest := OnExecuteRequest;
	{DONE 2: Get the server name from a config file}
	FIPCServer.ServerName := 'CEMMIPCServer';
	FIPCServer.Start;

end;


procedure TFrmMain.OnExecuteRequest(const Request, Response: IIPCData);
Var
	ThisURL: String;
	ThisModID: String;
	MyText: TStringlist;

begin

	UpdateCache:= Request.Data.ReadBoolean('UpdateCache');
	ThisURL    := Request.Data.ReadString('URL');
	ThisModID  := ThisURL.Substring( pos('=',ThisURL));


	if (ThisURL=LastURL) then begin
		Response.ID := datetimetostr(now);
		Response.Data.WriteString('WindowsTitle','Same');  //Flag to ignore title
		Exit;
	end else LastURL := ThisURL;


	PageLoaded := False;
	PageFullText := '';

	CanLoadANewPage:=True;


	Chromium1.LoadURL(ThisUrl);


	//Wait until reply ???



	while not (PageLoaded ) do begin


	end;



	if (UpdateCache) then begin

		Chromium1.PrintToPDF('.\cache\pdf\'+ThisModID+'.sfp',PageTitle,ThisURL );




  end;


	//Get Description
(*
	MyText:= TStringlist.create;
	try
		MyText.Text := PageFullText;
		MyText.SaveToFile('.\page.html');
	finally
		MyText.Free
	end; {try}

*)

	Response.ID := datetimetostr(now);



	Response.Data.WriteString('WindowsTitle',PageTitle );
	Response.Data.WriteString('ModDescription', GetModDescription(PageFullText )); //Var PageFullText is filled onTextResultAvailable
	TaskDone();



end;


//<div class="workshopItemDescription" id="highlightContent">


function TFrmMain.GetModDescription(ThisFullText:String): String;
var
	ThisResult: String;
	iPosOpenDiv:Integer;
	iPosCloseDiv:Integer;
	iPosLastClosedDiv: Integer;
	DivTagIsClosed: Boolean;
	TempString1: String;
	TempString2: String;
	FinalString: String;
	iTags:Integer;
	iHowManyOpened, iHowManyClosed: Integer;

	frame: ICefFrame;
	code: string;

Begin


ThisModDescription := 'N/A';

ThisModDescription := ThisFullText.Substring( pos('<div class="workshopItemDescription" id="highlightContent">',ThisFullText)-1);

//Count open and close

ThisModDescription := ThisModDescription.Replace('<div class="workshopItemDescription" id="highlightContent">','').Trim();



result := ThisResult;
end;




procedure TFrmMain.TaskDone();
begin
(*
	WiiProgressBar_1.Enabled := false;
	WiiProgressBar_1.Visible := false;
	HTMLText_Msg.Text := '<fs:26><bc:clYellow><fc:clGreen><c>  Operación terminada  </fs></fc></bc></c>';
			*)
			StatusPanel_Browser.Caption := 'Done';
end;



procedure TFrmMain.VisitDOM2Msg(var aMessage : TMessage);
var
  TempMsg : ICefProcessMessage;
begin
  // Use the ArgumentList property if you need to pass some parameters.
	TempMsg := TCefProcessMessageRef.New(RETRIEVEDOM_MSGNAME_FULL); // Same name than TCefCustomRenderProcessHandler.MessageName
	Chromium1.SendProcessMessage(PID_RENDERER, TempMsg);
end;



end.

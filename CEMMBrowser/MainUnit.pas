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


	uCEFChromium, uCEFWindowParent, uCEFInterfaces, uCEFApplication, uCEFTypes,
	uCEFConstants, uCEFWinControl, uCEFSentinel, uCEFChromiumCore, mswheel,
	bsSkinCtrls, JvAppInst;



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

	private
			FIPCServer: TIPCServer;
			FirstRun: Boolean;
    procedure SetUpIPCServer;
    procedure OnExecuteRequest(const Request, Response: IIPCData);
    procedure TaskDone;
    procedure ShowDefaultPage;
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


procedure CreateGlobalCEFApp;
begin
	GlobalCEFApp                     := TCefApplication.Create;
//  GlobalCEFApp.LogFile             := 'debug.log';
//	GlobalCEFApp.LogSeverity         := LOGSEVERITY_INFO;
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

procedure TFrmMain.Chromium1BeforeClose(Sender: TObject; const browser: ICefBrowser);
begin
  // The main browser is being destroyed
  if (Chromium1.BrowserId = 0) then
    begin
      FCanClose := True;
      PostMessage(Handle, WM_CLOSE, 0, 0);
    end;
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
end;

procedure TFrmMain.Chromium1LoadingStateChange(Sender: TObject;
  const browser: ICefBrowser; isLoading, canGoBack, canGoForward: Boolean);
begin
  if not(Chromium1.IsSameBrowser(browser)) or FClosing then exit;
  if isLoading then
    begin
			StatusPanel_Browser.Caption := 'Loading...';
		end
	 else
		begin
			StatusPanel_Browser.Caption := 'Done';
			caption := 'Conan Exiles Steam Mod Browser';
			if (FirstRun) then Begin
				FirstRun := False;
        ShowDefaultPage;


      End;

    end;
end;


procedure TFrmMain.ShowStatusText(const aText : string);
begin
  if not(FClosing) then StatusPanel_Browser.Caption := aText;
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
    end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
	FCanClose            := False;
	FClosing             := False;
	FResponse            := TStringList.Create;
	FRequest             := TStringList.Create;
	FNavigation          := TStringList.Create;

	FirstRun             := True;

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
						'<p>&nbsp;</p>'+
				'</div>'+
'</div>';

//Chromium1.LoadURL('https://steamcommunity.com/sharedfiles/filedetails/?id=2384014945');

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
	{Todo 2: Get the server name from a config file}
	FIPCServer.ServerName := 'CEMMIPCServer';
	FIPCServer.Start;

end;

procedure TFrmMain.OnExecuteRequest(const Request, Response: IIPCData);
Var
	ThisURL: String;

begin

	ThisURL  := Request.Data.ReadString('URL');
	Chromium1.LoadURL(ThisUrl);
	//Run following the transaction type
(*
	WiiProgressBar_1.Enabled := true;
	WiiProgressBar_1.Visible := true;
	*)





//				DoKeyBoard( SetKeyboard, Response);


		TaskDone();



end;

procedure TFrmMain.TaskDone();
begin
(*
	WiiProgressBar_1.Enabled := false;
	WiiProgressBar_1.Visible := false;
	HTMLText_Msg.Text := '<fs:26><bc:clYellow><fc:clGreen><c>  Operación terminada  </fs></fc></bc></c>';
      *)
end;





end.

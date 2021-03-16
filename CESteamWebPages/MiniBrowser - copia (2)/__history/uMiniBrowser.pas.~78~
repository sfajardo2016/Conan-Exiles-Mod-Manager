unit uMiniBrowser;

{$I cef.inc}

interface

uses
	{$IFDEF DELPHI16_UP}
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics, Vcl.Menus, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
	Vcl.StdCtrls, Vcl.ExtCtrls, System.Types, Vcl.ComCtrls, Vcl.ClipBrd,
	System.UITypes, Vcl.AppEvnts, Winapi.ActiveX, Winapi.ShlObj,
	System.NetEncoding,
	{$ELSE}
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Menus,
	Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Types, ComCtrls, ClipBrd,
	AppEvnts, ActiveX, ShlObj, NetEncoding,
	{$ENDIF}
	uCEFChromium, uCEFWindowParent, uCEFInterfaces, uCEFApplication, uCEFTypes,
	uCEFConstants, uCEFWinControl, uCEFSentinel, uCEFChromiumCore;

const
	MINIBROWSER_COOKIESFLUSHED   = WM_APP + $10B;
	MINIBROWSER_HOMEPAGE = 'www.google.com';

type
	TMiniBrowserFrm = class(TForm)
		NavControlPnl: TPanel;
		URLEditPnl: TPanel;
		CEFWindowParent1: TCEFWindowParent;
		Chromium1: TChromium;
    DevTools: TCEFWindowParent;
    StatusBar1: TStatusBar;
    ApplicationEvents1: TApplicationEvents;
    Timer1: TTimer;
    Button1: TButton;
    Label_1: TLabel;

    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);

    procedure Chromium1AfterCreated(Sender: TObject; const browser: ICefBrowser);
    procedure Chromium1LoadingStateChange(Sender: TObject; const browser: ICefBrowser; isLoading, canGoBack, canGoForward: Boolean);
    procedure Chromium1TitleChange(Sender: TObject; const browser: ICefBrowser; const title: ustring);
    procedure Chromium1StatusMessage(Sender: TObject; const browser: ICefBrowser; const value: ustring);
    procedure Chromium1PreKeyEvent(Sender: TObject; const browser: ICefBrowser; const event: PCefKeyEvent; osEvent: TCefEventHandle; out isKeyboardShortcut, Result: Boolean);
    procedure Chromium1KeyEvent(Sender: TObject; const browser: ICefBrowser; const event: PCefKeyEvent; osEvent: TCefEventHandle; out Result: Boolean);
    procedure Chromium1BeforeResourceLoad(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const request: ICefRequest; const callback: ICefRequestCallback; out Result: TCefReturnValue);
    procedure Chromium1Close(Sender: TObject; const browser: ICefBrowser; var aAction : TCefCloseBrowserAction);
    procedure Chromium1BeforeClose(Sender: TObject; const browser: ICefBrowser);
    procedure Chromium1LoadingProgressChange(Sender: TObject; const browser: ICefBrowser; const progress: Double);
    procedure Chromium1LoadEnd(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
    procedure Chromium1LoadError(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; errorCode: Integer; const errorText, failedUrl: ustring);
    procedure Chromium1CookiesFlushed(Sender: TObject);
    procedure Chromium1BeforePluginLoad(Sender: TObject; const mimeType, pluginUrl: ustring; isMainFrame: Boolean; const topOriginUrl: ustring; const pluginInfo: ICefWebPluginInfo; var pluginPolicy: TCefPluginPolicy; var aResult: Boolean);
    procedure Chromium1ZoomPctAvailable(Sender: TObject; const aZoomPct: Double);
    procedure Inczoom1Click(Sender: TObject);
    procedure Deczoom1Click(Sender: TObject);
    procedure Resetzoom1Click(Sender: TObject);
    procedure Flushcookies1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Clearcache1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);

  protected

    FResponse   : TStringList;
    FRequest    : TStringList;
    FNavigation : TStringList;
    // Variables to control when can we destroy the form safely
    FCanClose : boolean;  // Set to True in TChromium.OnBeforeClose
    FClosing  : boolean;  // Set to True in the CloseQuery event.


		procedure HandleKeyUp(const aMsg : TMsg; var aHandled : boolean);
    procedure HandleKeyDown(const aMsg : TMsg; var aHandled : boolean);


    procedure BrowserCreatedMsg(var aMessage : TMessage); message CEF_AFTERCREATED;
    procedure BrowserDestroyMsg(var aMessage : TMessage); message CEF_DESTROY;



		procedure CookiesFlushedMsg(var aMessage : TMessage); message MINIBROWSER_COOKIESFLUSHED;



    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;

  public
    procedure ShowStatusText(const aText : string);

  end;

var
  MiniBrowserFrm : TMiniBrowserFrm;

procedure CreateGlobalCEFApp;

implementation

{$R *.dfm}

// Destruction steps
// =================
// 1. FormCloseQuery sets CanClose to FALSE calls TChromium.CloseBrowser which triggers the TChromium.OnClose event.
// 2. TChromium.OnClose sends a CEFBROWSER_DESTROY message to destroy CEFWindowParent1 in the main thread, which triggers the TChromium.OnBeforeClose event.
// 3. TChromium.OnBeforeClose sets FCanClose := True and sends WM_CLOSE to the form.

procedure CreateGlobalCEFApp;
begin
  GlobalCEFApp                     := TCefApplication.Create;
  GlobalCEFApp.LogFile             := 'debug.log';
  GlobalCEFApp.LogSeverity         := LOGSEVERITY_INFO;
  GlobalCEFApp.cache               := 'cache';
	GlobalCEFApp.EnablePrintPreview  := True;
  // This is a workaround for the CEF4Delphi issue #324 :
  // https://github.com/salvadordf/CEF4Delphi/issues/324
  GlobalCEFApp.DisableFeatures := 'WinUseBrowserSpellChecker';

end;

procedure TMiniBrowserFrm.Resetzoom1Click(Sender: TObject);
begin
  Chromium1.ResetZoomStep;
end;

procedure TMiniBrowserFrm.Chromium1AfterCreated(Sender: TObject; const browser: ICefBrowser);
begin
  if Chromium1.IsSameBrowser(browser) then
    PostMessage(Handle, CEF_AFTERCREATED, 0, 0)
   else
    SendMessage(browser.Host.WindowHandle, WM_SETICON, 1, application.Icon.Handle); // Use the same icon in the popup window
end;

procedure TMiniBrowserFrm.Chromium1BeforeClose(Sender: TObject; const browser: ICefBrowser);
begin
  // The main browser is being destroyed
  if (Chromium1.BrowserId = 0) then
    begin
      FCanClose := True;
      PostMessage(Handle, WM_CLOSE, 0, 0);
    end;
end;




procedure TMiniBrowserFrm.Chromium1BeforePluginLoad(Sender: TObject;
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

procedure TMiniBrowserFrm.Chromium1BeforeResourceLoad(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  const request: ICefRequest; const callback: ICefRequestCallback;
  out Result: TCefReturnValue);
begin
  Result := RV_CONTINUE;



end;

procedure TMiniBrowserFrm.Chromium1Close(Sender: TObject; const browser: ICefBrowser; var aAction : TCefCloseBrowserAction);
begin
  if (browser <> nil) and
     (Chromium1.BrowserId = browser.Identifier) and
     (CEFWindowParent1 <> nil) then
    begin
      PostMessage(Handle, CEF_DESTROY, 0, 0);
      aAction := cbaDelay;
    end;
end;



procedure TMiniBrowserFrm.Chromium1CookiesFlushed(Sender: TObject);
begin
  PostMessage(Handle, MINIBROWSER_COOKIESFLUSHED, 0, 0);
end;

procedure TMiniBrowserFrm.CookiesFlushedMsg(var aMessage : TMessage);
begin
  showmessage('The cookies were flushed successfully');
end;





procedure TMiniBrowserFrm.Chromium1KeyEvent(Sender: TObject;
  const browser: ICefBrowser; const event: PCefKeyEvent; osEvent: TCefEventHandle;
  out Result: Boolean);
var
  TempMsg : TMsg;
begin
  Result := False;

  if (event <> nil) and (osEvent <> nil) then
    case osEvent.Message of
      WM_KEYUP :
        begin
          TempMsg := osEvent^;

          HandleKeyUp(TempMsg, Result);
        end;

      WM_KEYDOWN :
        begin
          TempMsg := osEvent^;

          HandleKeyDown(TempMsg, Result);
        end;
    end;
end;

procedure TMiniBrowserFrm.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
  case Msg.message of
    WM_KEYUP   : HandleKeyUp(Msg, Handled);
    WM_KEYDOWN : HandleKeyDown(Msg, Handled);
  end;
end;

procedure TMiniBrowserFrm.HandleKeyUp(const aMsg : TMsg; var aHandled : boolean);
var
  TempMessage : TMessage;
  TempKeyMsg  : TWMKey;
begin
  TempMessage.Msg     := aMsg.message;
  TempMessage.wParam  := aMsg.wParam;
  TempMessage.lParam  := aMsg.lParam;
  TempKeyMsg          := TWMKey(TempMessage);



end;

procedure TMiniBrowserFrm.HandleKeyDown(const aMsg : TMsg; var aHandled : boolean);
var
  TempMessage : TMessage;
  TempKeyMsg  : TWMKey;
begin
  TempMessage.Msg     := aMsg.message;
  TempMessage.wParam  := aMsg.wParam;
  TempMessage.lParam  := aMsg.lParam;
  TempKeyMsg          := TWMKey(TempMessage);

  if (TempKeyMsg.CharCode = VK_F12) then aHandled := True;
end;

procedure TMiniBrowserFrm.Chromium1LoadEnd(Sender: TObject;
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

procedure TMiniBrowserFrm.Chromium1LoadError(Sender: TObject;
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

procedure TMiniBrowserFrm.Chromium1LoadingProgressChange(Sender: TObject;
  const browser: ICefBrowser; const progress: Double);
begin
  StatusBar1.Panels[0].Text := 'Loading... ' + FloatToStrF(progress * 100, ffFixed, 3, 0) + '%';
end;

procedure TMiniBrowserFrm.Chromium1LoadingStateChange(Sender: TObject;
  const browser: ICefBrowser; isLoading, canGoBack, canGoForward: Boolean);
begin
  if not(Chromium1.IsSameBrowser(browser)) or FClosing then exit;

  // This event is executed in a CEF thread and this can cause problems when
  // you change the 'Enabled' and 'Visible' properties from VCL components.
  // It's recommended to change the 'Enabled' and 'Visible' properties
  // in the main application thread and not in a CEF thread.
  // It's much safer to use PostMessage to send a message to the main form with
  // all this information and update those properties in the procedure handling
  // that message.


  if isLoading then
    begin
      StatusBar1.Panels[0].Text := 'Loading...';
    end
   else
    begin
      StatusBar1.Panels[0].Text := 'Done';
    end;
end;


procedure TMiniBrowserFrm.Chromium1PreKeyEvent(Sender: TObject;
  const browser: ICefBrowser; const event: PCefKeyEvent; osEvent: TCefEventHandle;
  out isKeyboardShortcut, Result: Boolean);
begin
  Result := False;

  if (event <> nil) and
     (event.kind in [KEYEVENT_KEYDOWN, KEYEVENT_KEYUP]) and
     (event.windows_key_code = VK_F12) then
    isKeyboardShortcut := True;
end;




procedure TMiniBrowserFrm.ShowStatusText(const aText : string);
begin
  if not(FClosing) then StatusBar1.Panels[1].Text := aText;
end;




procedure TMiniBrowserFrm.Chromium1StatusMessage(Sender: TObject;
  const browser: ICefBrowser; const value: ustring);
begin
  if Chromium1.IsSameBrowser(browser) then ShowStatusText(value);
end;

procedure TMiniBrowserFrm.Chromium1TitleChange(Sender: TObject;
  const browser: ICefBrowser; const title: ustring);
begin
  if not(Chromium1.IsSameBrowser(browser)) then exit;

	if (title <> '') then
		caption := title
	 else
		caption := 'Conan Exiles Mod Manager';
end;

procedure TMiniBrowserFrm.Chromium1ZoomPctAvailable(Sender: TObject;
  const aZoomPct: Double);
begin
  ShowStatusText('Zoom : ' + floattostr(aZoomPct) + '%');
end;

procedure TMiniBrowserFrm.Clearcache1Click(Sender: TObject);
begin
  Chromium1.ClearCache;
end;


procedure TMiniBrowserFrm.Flushcookies1Click(Sender: TObject);
begin
  if not(Chromium1.FlushCookieStore(False)) then
    showmessage('There was a problem flushing the cookies.');
end;

procedure TMiniBrowserFrm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := FCanClose;

  if not(FClosing) then
    begin
      FClosing := True;
      Visible  := False;

      // if TChromium.MultiBrowserMode is enabled then we have to close all
      // stored browsers and not only the main browser.
      Chromium1.CloseAllBrowsers;
    end;
end;

procedure TMiniBrowserFrm.FormCreate(Sender: TObject);
begin
  FCanClose            := False;
  FClosing             := False;
  FResponse            := TStringList.Create;
  FRequest             := TStringList.Create;
  FNavigation          := TStringList.Create;



  // The MultiBrowserMode store all the browser references in TChromium.
  // The first browser reference is the browser in the main form.
  // When MiniBrowser allows CEF to create child popup browsers it will also
  // store their reference inside TChromium and you can use all the TChromium's
  // methods and properties to manipulate those browsers.
  // To do that call TChromium.SelectBrowser with the browser ID that will be
  // used when you call any method or property in TChromium.
  Chromium1.MultiBrowserMode := True;
	Chromium1.DefaultURL       := MINIBROWSER_HOMEPAGE;



end;

procedure TMiniBrowserFrm.FormDestroy(Sender: TObject);
begin
  FResponse.Free;
  FRequest.Free;
  FNavigation.Free;
end;

procedure TMiniBrowserFrm.FormMouseWheelDown(Sender: TObject;
	Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
if ssCtrl in Shift then Chromium1.IncZoomStep;
Label_1.Caption := 'Down - ' + DateTimeToStr(now);

Handled:=True;
end;

procedure TMiniBrowserFrm.FormMouseWheelUp(Sender: TObject;
	Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
if ssCtrl in Shift then Chromium1.DecZoomStep;
Label_1.Caption := 'Up -' + DateTimeToStr(now);
Handled:=True;
end;

procedure TMiniBrowserFrm.FormShow(Sender: TObject);
begin
  ShowStatusText('Initializing browser. Please wait...');

  // WebRTC's IP leaking can lowered/avoided by setting these preferences
  // To test this go to https://www.browserleaks.com/webrtc
  Chromium1.WebRTCIPHandlingPolicy := hpDisableNonProxiedUDP;
  Chromium1.WebRTCMultipleRoutes   := STATE_DISABLED;
  Chromium1.WebRTCNonproxiedUDP    := STATE_DISABLED;

  // GlobalCEFApp.GlobalContextInitialized has to be TRUE before creating any browser
  // If it's not initialized yet, we use a simple timer to create the browser later.
  if not(Chromium1.CreateBrowser(CEFWindowParent1, '')) then Timer1.Enabled := True;
end;

procedure TMiniBrowserFrm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  if not(Chromium1.CreateBrowser(CEFWindowParent1, '')) and not(Chromium1.Initialized) then
    Timer1.Enabled := True;
end;


procedure TMiniBrowserFrm.BrowserCreatedMsg(var aMessage : TMessage);
begin
  CEFWindowParent1.UpdateSize;
  NavControlPnl.Enabled := True;
end;

procedure TMiniBrowserFrm.BrowserDestroyMsg(var aMessage : TMessage);
begin
  FreeAndNil(CEFWindowParent1);
end;

procedure TMiniBrowserFrm.Button1Click(Sender: TObject);
begin

Chromium1.LoadURL('https://steamcommunity.com/sharedfiles/filedetails/?id=2384014945');

end;

procedure TMiniBrowserFrm.Inczoom1Click(Sender: TObject);
begin
  Chromium1.IncZoomStep;
end;



procedure TMiniBrowserFrm.WMMove(var aMessage : TWMMove);
begin
	inherited;

	if (Chromium1 <> nil) then Chromium1.NotifyMoveOrResizeStarted;
end;

procedure TMiniBrowserFrm.WMMoving(var aMessage : TMessage);
begin
	inherited;

	if (Chromium1 <> nil) then Chromium1.NotifyMoveOrResizeStarted;
end;


procedure TMiniBrowserFrm.Deczoom1Click(Sender: TObject);
begin
	Chromium1.DecZoomStep;
end;



end.

unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
	BusinessSkinForm, bsSkinData, bsSkinHint, bsSkinCtrls,

	 uCEFInterfaces,
	 uCEFConstants,
	 uCEFTypes,
	 uCEFApplication,

  bsribbon, varcodedxe8, bsMessages, DzHTMLText, uCEFWinControl,
  uCEFWindowParent, uCEFChromiumCore, uCEFChromium, Vcl.ExtCtrls,
  Vcl.StdCtrls;



CONST
	MINIBROWSER_COOKIESFLUSHED   = WM_APP + $10B;


type
	smType = (smNormal, smWarning,smError);



type
  TFrmMain = class(TForm)
    BusinessSkinForm_Main: TbsBusinessSkinForm;
    CompressedSkinList_Main: TbsCompressedSkinList;
    SkinData_Main: TbsSkinData;
    StatusBar_1: TbsSkinStatusBar;
		HTMLText_GameFoldersAndFilesMsg: TDzHTMLText;
    Varcoded: TVarCodedxe8;
    msgdlg_Main: TbsSkinMessage;
    CEFWindowParent1: TCEFWindowParent;
    Chromium1: TChromium;
    Timer_BrowserSetUp: TTimer;
    Button_1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Timer_BrowserSetUpTimer(Sender: TObject);
    procedure Chromium1AfterCreated(Sender: TObject;
      const browser: ICefBrowser);
    procedure Chromium1BeforeClose(Sender: TObject;
      const browser: ICefBrowser);
    procedure Chromium1BeforeResourceLoad(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest; const callback: ICefRequestCallback;
      out Result: TCefReturnValue);
    procedure Chromium1Close(Sender: TObject; const browser: ICefBrowser;
      var aAction: TCefCloseBrowserAction);
    procedure Chromium1CookiesFlushed(Sender: TObject);
    procedure Chromium1LoadEnd(Sender: TObject; const browser: ICefBrowser;
      const frame: ICefFrame; httpStatusCode: Integer);
    procedure Chromium1LoadError(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      errorCode: Integer; const errorText, failedUrl: ustring);
    procedure Chromium1LoadingProgressChange(Sender: TObject;
      const browser: ICefBrowser; const progress: Double);
    procedure Chromium1LoadingStateChange(Sender: TObject;
      const browser: ICefBrowser; isLoading, canGoBack,
      canGoForward: Boolean);
    procedure Chromium1TitleChange(Sender: TObject;
      const browser: ICefBrowser; const title: ustring);
    procedure Button_1Click(Sender: TObject);
	private




		UIThemeIsLight: Boolean;

		function BeginSession: Boolean;
		function SetUpLog: Boolean;
		procedure SetupUI;
    procedure LoadDefaultWebPage(IsActive: Boolean);
    procedure SetupBrowser;

		{ Private declarations }
	public
		{ Public declarations }

		procedure Log(ThisMsg: String); overload;
		procedure Log(ThisEvent: TLogEventID; ThisMsg: String); overload;

		procedure ScreenMsg(ThisType: smType; ThisMsg: String;ThisLabel: TDzHTMLText); overload;
		procedure ScreenMsg(ThisType: smType; ThisMsg: String); overload;
		procedure ScreenMsg(ThisMsg: String); overload;

	protected
    FCanClose : boolean;  // Set to True in TChromium.OnBeforeClose
		FClosing  : boolean;  // Set to True in the CloseQuery event.

		
	end;

var
	FrmMain: TFrmMain;
	procedure CreateGlobalCEFApp;

implementation

{$R *.dfm}



procedure CreateGlobalCEFApp;
begin
  GlobalCEFApp                     := TCefApplication.Create;
//  GlobalCEFApp.LogFile             := 'debug.log';
//  GlobalCEFApp.LogSeverity         := LOGSEVERITY_INFO;
  GlobalCEFApp.cache               := 'cache';
	GlobalCEFApp.EnablePrintPreview  := True;
  // This is a workaround for the CEF4Delphi issue #324 :
  // https://github.com/salvadordf/CEF4Delphi/issues/324
  GlobalCEFApp.DisableFeatures := 'WinUseBrowserSpellChecker';
end;






procedure TFrmMain.Button_1Click(Sender: TObject);
begin
Chromium1.LoadURL('www.google.com');
end;

procedure TFrmMain.Chromium1AfterCreated(Sender: TObject;
  const browser: ICefBrowser);
begin
	if Chromium1.IsSameBrowser(browser) then
    PostMessage(Handle, CEF_AFTERCREATED, 0, 0)
	 else
    SendMessage(browser.Host.WindowHandle, WM_SETICON, 1, application.Icon.Handle); // Use the same icon in the popup window

end;

procedure TFrmMain.Chromium1BeforeClose(Sender: TObject;
  const browser: ICefBrowser);
begin
  // The main browser is being destroyed
  if (Chromium1.BrowserId = 0) then
    begin
      FCanClose := True;
      PostMessage(Handle, WM_CLOSE, 0, 0);
    end;

end;

procedure TFrmMain.Chromium1BeforeResourceLoad(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  const request: ICefRequest; const callback: ICefRequestCallback;
	out Result: TCefReturnValue);
begin
  Result := RV_CONTINUE;
end;

procedure TFrmMain.Chromium1Close(Sender: TObject;
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

procedure TFrmMain.Chromium1CookiesFlushed(Sender: TObject);
begin
  PostMessage(Handle, MINIBROWSER_COOKIESFLUSHED, 0, 0);
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

	ScreenMsg('Loading... ' + FloatToStrF(progress * 100, ffFixed, 3, 0) + '%');

end;

procedure TFrmMain.Chromium1LoadingStateChange(Sender: TObject;
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
			ScreenMsg('Loading...');
		end
	 else
		begin
					ScreenMsg('Done');

		end;


end;

procedure TFrmMain.Chromium1TitleChange(Sender: TObject;
  const browser: ICefBrowser; const title: ustring);
begin
  if not(Chromium1.IsSameBrowser(browser)) then exit;

	if (title <> '') then
		caption := title
	 else
		caption := 'Conan Exiles Mod Manager';


end;

Procedure TFrmMain.FormCreate(Sender: TObject);
begin
Sleep(50); //Timer to let UI react
if not (BeginSession()) then begin
	Sleep(50);
	Close;
	Application.Terminate;
end;



end;

function TFrmMain.BeginSession(): Boolean;
var
	ThisResult: Boolean;
	db: string;
begin
ThisResult := false;

/// <remarks>
///   Default values
/// </remarks>
///
UIThemeIsLight := true;
varcoded.SetCreator('Zaphod (See "About" option for contact)');



if NOT ( varcoded.IsValidInstallation() ) then
begin
		varcoded.winlog(leWarning,'Invalid installation, please re-install');
		msgdlg_Main.MessageDlg('Hi, sorry to bother you but, this app installation is corrupted.'+#13+#13+
												'Run it again or re-install this app to fix it.', mtWarning, [mbOk], 0);
		exit ( false );
end;



if NOT ( SetUpLog() ) then
begin
		varcoded.winlog(leWarning,'Can not setup the LOG file:' + varcoded.MainLogFile );
		msgdlg_Main.MessageDlg('Hi, sorry to bother you but, I can not setup the LOG'+#13+
												'Please check if you have full access to this app folder.'+#13+#13+
												'Run it again or re-install this app to fix it.', mtWarning, [mbOk], 0);
		exit ( false );
end;


	SetupUI();
	SetupBrowser();



ThisResult := true;
Log('App is ready');
ScreenMsg('Ready');
result := ThisResult;
end;





procedure TFrmMain.SetupUI;

begin



end;


procedure TFrmMain.Timer_BrowserSetUpTimer(Sender: TObject);
begin
	Timer_BrowserSetUp.Enabled := False;
	if not(Chromium1.CreateBrowser(CEFWindowParent1, '')) and not(Chromium1.Initialized) then
		Timer_BrowserSetUp.Enabled := True else LoadDefaultWebPage(true);


end;


procedure TFrmMain.LoadDefaultWebPage(IsActive: Boolean);
begin


	//	Chromium1.LoadURL('file:///'+ ChangeFileExt( Application.ExeName, '.html?Msg=To get the mod steam web page, click on a mod in your left list' ));
		Chromium1.LoadURL('www.google.com');


end;


procedure TFrmMain.SetupBrowser();

begin

	FCanClose            := False;
	FClosing             := False;



	Timer_BrowserSetUp.Enabled := False;
	Chromium1.MultiBrowserMode := False;
	Chromium1.WebRTCIPHandlingPolicy := hpDisableNonProxiedUDP;
	Chromium1.WebRTCMultipleRoutes   := STATE_DISABLED;
	Chromium1.WebRTCNonproxiedUDP    := STATE_DISABLED;


 if not(Chromium1.CreateBrowser(CEFWindowParent1, '')) then Timer_BrowserSetUp.Enabled := True else LoadDefaultWebPage(false);






end;



{$REGION 'Log'}


	procedure TFrmMain.Log(ThisEvent: TLogEventID; ThisMsg: String);
	begin
	varcoded.Log(ThisEvent,ThisMSg);
	end;

	procedure TFrmMain.Log(ThisMsg: String);
	begin

		varcoded.Log(ThisMsg);

	end;



function TFrmMain.SetUpLog(): Boolean;
	begin
	result := varcoded.SetUpLog();
	end;

{$ENDREGION}


{$REGION 'ScreenMsg'}

  procedure TFrmMain.ScreenMsg(ThisType: smType; ThisMsg: String);
  begin

  ScreenMsg(ThisType,ThisMsg,HTMLText_GameFoldersAndFilesMsg);

  end;

  procedure TFrmMain.ScreenMsg(ThisMsg: String);
  begin

  ScreenMsg(smNormal,ThisMsg,HTMLText_GameFoldersAndFilesMsg);
  end;


  procedure TFrmMain.ScreenMsg(ThisType:smType;ThisMsg:String;ThisLabel: TDzHTMLText);
	begin

	ThisMsg :=  ThisMsg + StringOfChar(' ', 200-ThisMsg.Length);

  case ThisType of
  	smNormal: if (UIThemeIsLight) then
  						ThisLabel.Text := '<fs:14>'+ThisMsg+'</fs>'
  						else
  						ThisLabel.Text := '<fs:14><bc:clBlack><fc:clWhite>'+ThisMsg+'</fs></bc></fc>';

  	smWarning: ThisLabel.Text := '<fs:14><bc:clYellow>'+ThisMsg+'</fs></fc>';
  	smError: ThisLabel.Text := '<fs:14><fc:clRed><bc:clYellow>'+ThisMsg+'</fs></fc></bc>';
  end;

  end;
{$ENDREGION}





end.


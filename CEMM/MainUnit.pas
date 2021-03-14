unit MainUnit;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,Forms,
	Vcl.Controls,   siComp,
	BusinessSkinForm, bsSkinExCtrls, Vcl.ExtCtrls, bsSkinData, bsSkinCtrls,
	Vcl.ComCtrls, bsSkinTabs, cxGraphics, cxControls, cxLookAndFeels,
	cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
	cxDataStorage, cxEdit, cxNavigator, dxDateRanges, Data.DB, cxDBData,
	cxSpinEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
	cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, bsaadapter,
	Vcl.Dialogs,

	/// <remarks>
	///   Browser
	/// </remarks>
	///
	 uCEFInterfaces,
	 uCEFConstants,
	 uCEFTypes,
	 uCEFApplication,

	 uCEFStringVisitor,






	 uCEFSentinel,
	 uCEFWinControl, uCEFWindowParent, uCEFChromiumCore,
	 uCEFChromium,




	varcodedxe8,
	DataModuleUnit,

	bsMessages,
	Vcl.StdCtrls, bsSkinBoxCtrls, Vcl.Mask, dxPDFCore, dxPDFBase, dxPDFText,
  dxPDFRecognizedObject, dxPDFDocument, dxBarBuiltInMenu, dxCustomPreview,
  dxPDFDocumentViewer, dxPDFViewer, bsSkinShellCtrls;


	CONST
		MINIBROWSER_COOKIESFLUSHED   = WM_APP + $10B;
type
  TFrmMain = class(TForm)
    StatusBar_1: TbsSkinStatusBar;
    BusinessSkinForm_1: TbsBusinessSkinForm;
    SkinData_1: TbsSkinData;
    CompressedSkinList_1: TbsCompressedSkinList;
    siLang_Main: TsiLang;
    Timer_StartUp: TTimer;
    PageControl_Main: TbsSkinPageControl;
    Panel_ModsOnPC: TbsSkinExPanel;
    SplitterEx_1: TbsSkinSplitterEx;
    SkinAdapter_1: TbsaSkinAdapter;
    Grid_modsonthispc: TcxGrid;
    DBTableView_1: TcxGridDBTableView;
    GridDBColumn___Grid1DBTableView1modid: TcxGridDBColumn;
    GridDBColumn___Grid1DBTableView1modname1: TcxGridDBColumn;
    GridDBColumn__Grid1DBTableView1Column1: TcxGridDBColumn;
    GridDBColumn___Grid1DBTableView1modsize: TcxGridDBColumn;
    GridDBColumn___Grid1DBTableView1Column1: TcxGridDBColumn;
    GridLevel_1: TcxGridLevel;
    TabSheet_SteamModWebPage: TbsSkinTabSheet;
    Varcoded: TVarCodedxe8;
    msgdlg_1: TbsSkinMessage;
    TabSheet_ModSets: TbsSkinTabSheet;
    TabSheet_SteamSetUp: TbsSkinTabSheet;
    TabSheet_Config: TbsSkinTabSheet;
    CEFWindowParent1: TCEFWindowParent;
    ComboBox_ShowWebPage: TbsSkinComboBoxEx;
    Label_1: TbsSkinStdLabel;
    Panel_UISettings: TbsSkinExPanel;
    OfficeComboBox_Languages: TbsSkinOfficeComboBox;
    OfficeComboBox_Skin: TbsSkinOfficeComboBox;
    Panel_GameFolders: TbsSkinExPanel;
    Panel_SettingsOKButton: TbsSkinPanel;
    Button_SaveSettings: TbsSkinButton;
    Button_CancelSettings: TbsSkinButton;
    Timer_BrowserSetUp: TTimer;
    Chromium1: TChromium;
    StatusBar_Browser: TbsSkinStatusBar;
    StatusPanel_Browser: TbsSkinStatusPanel;
    Slider_BrowserZoom: TbsSkinSlider;
    StatusPanel_Zoom: TbsSkinStatusPanel;
    PDFViewer1: TdxPDFViewer;
    Button_1: TButton;
    Label_11: TbsSkinStdLabel;
    DirectoryEdit_ModList: TbsSkinDirectoryEdit;
    Label_12: TbsSkinStdLabel;
    Label_13: TbsSkinStdLabel;
    DirectoryEdit_Mods: TbsSkinDirectoryEdit;
    Label_14: TbsSkinStdLabel;
    Label_15: TbsSkinStdLabel;
    FileEdit_CEEXEFile: TbsSkinFileEdit;
    Label_16: TbsSkinStdLabel;
    Label_17: TbsSkinStdLabel;
    Label_18: TbsSkinStdLabel;
    DirectoryEdit_1: TbsSkinDirectoryEdit;
    Button_ValidateFolders: TbsSkinSpeedButton;
    TabSheet_Steam: TbsSkinTabSheet;
    procedure OfficeComboBox_LanguagesChange(Sender: TObject);
    procedure Timer_StartUpTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OfficeComboBox_SkinChange(Sender: TObject);
    procedure Button_SaveSettingsClick(Sender: TObject);
    procedure Button_CancelSettingsClick(Sender: TObject);
    procedure DBTableView_1CellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure Timer_BrowserSetUpTimer(Sender: TObject);
    procedure Chromium1AfterCreated(Sender: TObject;  const browser: ICefBrowser);
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
    procedure Chromium1TitleChange(Sender: TObject;
      const browser: ICefBrowser; const title: ustring);
    procedure Chromium1LoadingProgressChange(Sender: TObject;
      const browser: ICefBrowser; const progress: Double);
    procedure Chromium1LoadingStateChange(Sender: TObject;
      const browser: ICefBrowser; isLoading, canGoBack,
      canGoForward: Boolean);
    procedure Slider_BrowserZoomChange(Sender: TObject);
    procedure Button_1Click(Sender: TObject);
  private
		dm: TDataModule1;
		/// <remarks>
		///   Web page
		/// </remarks>
		LastUrlVisited: String;

		bShowSteamWebPage: Boolean;
    CanLoadWepPage : Boolean;

		function BeginSession: Boolean;
		procedure SetupUI();
    function SetUpLog: Boolean;
    procedure SaveSettings;
    procedure ShowSteamModPage;
    procedure SetupBrowser;
    procedure LoadDefaultWebPage(IsActive: Boolean);


    { Private declarations }
  public
		{ Public declarations }
		procedure Log(ThisMsg:String); overload;
		procedure Log(ThisEvent:TLogEventID; ThisMsg:String); overload;

	protected
	    // Variables to control when can we destroy the form safely
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


procedure StringVisitor(const str: ustring);
begin
  //str is the SourceHtml
showmessage(str);
end;


procedure TFrmMain.Button_1Click(Sender: TObject);
begin

Chromium1.PrintToPDF('.\page.pdf','CE web browser',Chromium1.DocumentURL );

PDFViewer1.LoadFromFile('.\page.pdf' );



end;

procedure TFrmMain.Button_CancelSettingsClick(Sender: TObject);
begin
SetUpUI;
end;

procedure TFrmMain.Button_SaveSettingsClick(Sender: TObject);
begin
SaveSettings();
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
	LastSteamWebPageContent: String;
	CefStringVisitor: ICefStringVisitor;
	TempVisitor     : ICefStringVisitor;


begin
	if FClosing or (frame = nil) or not(frame.IsValid) or (browser = nil) then exit;

	//cache the page
//	 Chromium1.Browser.MainFrame.GetSource();

//	LastSteamWebPageContent :=


if frame.IsMain then begin

					TempVisitor := TCustomCefStringVisitor.Create(Chromium1);
					Chromium1.Browser.MainFrame.GetSource(TempVisitor);


//					frame.GetSource(TempVisitor);



//					TempFrame.GetSource(TempVisitor);


//	CefStringVisitor := TCefFastStringVisitor.Create(StringVisitor);
//  Chromium1.Browser.MainFrame.GetSource(CefStringVisitor);
end;




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

	// This event is executed in a CEF thread and this can cause problems when
	// you change the 'Enabled' and 'Visible' properties from VCL components.
	// It's recommended to change the 'Enabled' and 'Visible' properties
	// in the main application thread and not in a CEF thread.
	// It's much safer to use PostMessage to send a message to the main form with
	// all this information and update those properties in the procedure handling
	// that message.


	if isLoading then
		begin
			StatusPanel_Browser.Caption := 'Loading...';
		end
	 else
		begin
      StatusPanel_Browser.Caption := 'Done';
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

procedure TFrmMain.DBTableView_1CellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
if (bShowSteamWebPage) then ShowSteamModPage() else LoadDefaultWebPage(bShowSteamWebPage);
end;


procedure TFrmMain.ShowSteamModPage();
var
	thisurl: string;
	thismodid:string;

begin





	thismodid:= dm.query_mods.FieldByName('modid').AsString.Trim;
	if (thismodid.IsEmpty)  then Exit;

  CanLoadWepPage := False;

	thisurl := 'http://steamcommunity.com/sharedfiles/filedetails/?id=' + thismodid;

	if (thisurl<> LastUrlVisited)  then begin //show


		if (PageControl_Main.TabIndex=0) then begin
				CanLoadWepPage := True;
				Log('Loading page: ' + thisurl);
				LastUrlVisited := thisurl;
				Chromium1.LoadURL(thisurl);

				(*

				WebBrowser1.Stop;
				Gauge_web.Visible:=True;
				Gauge_web.Value:=30;
				StatusPanel_web.Caption:='Loading ' + thisurl;

				WebBrowser1.Navigate(thisurl);
				WebBrowser1.Visible := true;

				*)
		end else begin
				(*
				WebBrowser1.Stop;
				WebBrowser1.Navigate('D:\temp\blank.html');
				StatusPanel_web.Caption:='Ready';
          *)

    end;


  end;






end;

procedure TFrmMain.Slider_BrowserZoomChange(Sender: TObject);
begin

if (bShowSteamWebPage) then begin
  Chromium1.ZoomLevel := Slider_BrowserZoom.Value*0.1;

end;

end;

procedure TFrmMain.SaveSettings();
begin

	dm.SetSetting('UILanguage',OfficeComboBox_Languages.ItemIndex.ToString() );
	dm.SetSetting('UITheme', OfficeComboBox_Skin.ItemIndex.ToString());
	dm.SetSetting('showsteamwebpage', ComboBox_ShowWebPage.ItemIndex.tostring() );

	bShowSteamWebPage := ComboBox_ShowWebPage.ItemIndex = 0;

  LoadDefaultWebPage(bShowSteamWebPage);


end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
Timer_StartUp.Enabled := true;

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
procedure TFrmMain.OfficeComboBox_LanguagesChange(Sender: TObject);
begin

siLang_Main.ActiveLanguage := OfficeComboBox_Languages.ItemIndex;
end;

procedure TFrmMain.OfficeComboBox_SkinChange(Sender: TObject);
begin
SkinData_1.SkinIndex:= OfficeComboBox_Skin.ItemIndex-1;
end;

procedure TFrmMain.SetupUI;
var
	ThisIndex: smallint;
begin

	if (dm.GetSetting('UILanguage',ThisIndex)) then
		OfficeComboBox_Languages.ItemIndex:= ThisIndex
		else
		OfficeComboBox_Languages.ItemIndex:= 1; //English by default


	if (dm.GetSetting('UITheme',ThisIndex)) then
		OfficeComboBox_Skin.ItemIndex:= ThisIndex
		else
		OfficeComboBox_Skin.ItemIndex:= 1; //Light by default


	if (dm.GetSetting('showsteamwebpage',ThisIndex)) then
		ComboBox_ShowWebPage.ItemIndex := ThisIndex
		else
		ComboBox_ShowWebPage.ItemIndex:= 1; //No by default





	siLang_Main.ActiveLanguage := OfficeComboBox_Languages.ItemIndex;
	SkinData_1.SkinIndex:= OfficeComboBox_Skin.ItemIndex-1;
	bShowSteamWebPage := ComboBox_ShowWebPage.ItemIndex = 0;





end;

procedure TFrmMain.Timer_BrowserSetUpTimer(Sender: TObject);
begin
	Timer_BrowserSetUp.Enabled := False;
	if not(Chromium1.CreateBrowser(CEFWindowParent1, '')) and not(Chromium1.Initialized) then
		Timer_BrowserSetUp.Enabled := True else LoadDefaultWebPage(bShowSteamWebPage);

end;

procedure TFrmMain.Timer_StartUpTimer(Sender: TObject);
begin
Timer_StartUp.Enabled := false;
if not (BeginSession) then Close;

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

LastUrlVisited:= '';
//https://store.steampowered.com/app/440900/

varcoded.SetCreator('Zaphod (See "About" option for contact)');



if NOT ( varcoded.IsValidInstallation() ) then
begin
		varcoded.winlog(leWarning,'Invalid installation, please re-install');
		msgdlg_1.MessageDlg('Hi, sorry to bother you but, this app installation is corrupted.'+#13+#13+
												'Run it again or re-install this app to fix it.', mtWarning, [mbOk], 0);
		exit ( false );
end;



if NOT ( SetUpLog() ) then
begin
		varcoded.winlog(leWarning,'Can not setup the LOG file:' + varcoded.MainLogFile );
		msgdlg_1.MessageDlg('Hi, sorry to bother you but, I can not setup the LOG'+#13+
												'Please check if you have full access to this app folder.'+#13+#13+
												'Run it again or re-install this app to fix it.', mtWarning, [mbOk], 0);
		exit ( false );
end;


	DM:= TDataModule1.Create(FrmMain);
	db := ExtractFilePath(Application.ExeName) + 'cemm.sfp';

	if not (dm.SetupData ( db )) then begin
		Log(leWarning,'Can not setup the DB:' + db + #13+#13+' '+ dm.LastMessage);
		msgdlg_1.MessageDlg('Hi, sorry to bother you but, I can not setup the main database'+#13+
												'Please check if you have full access to this app folder.'+#13+#13+
												'Run it again or re-install this app to fix it.', mtWarning, [mbOk], 0);
		exit ( false );
	end;





	if not (dm.AreSettingsValid) then begin
		Log(leWarning,'Settings ar not valid, prompting the user to check the settings');
		msgdlg_1.MessageDlg('Hi, app settings are not valid'+#13+
												'( game folder, mod folder, etc).'+#13+#13+
												'Please review the configuration settings.', mtWarning, [mbOk], 0);

		PageControl_Main.TabIndex := 3;
		/// <remarks>
		///  Continue as the settings can be fixed by the user
    /// </remarks>

	end else 		PageControl_Main.TabIndex := 0;






	SetupUI();
	SetupBrowser();



ThisResult := true;
Log('App is ready');

result := ThisResult;
end;


procedure TFrmMain.LoadDefaultWebPage(IsActive: Boolean);
var
	TempString:String;

begin

//	CEFWindowParent1.Visible:= bShowSteamWebPage;


	if  (bShowSteamWebPage) then
    	Chromium1.LoadURL('file:///'+ ChangeFileExt( Application.ExeName, '.html?Msg=To get the mod steam web page, click on a mod in your left list' ))
  		else
      Chromium1.LoadURL('file:///'+ ChangeFileExt( Application.ExeName, '.html?Msg=To get the mod steam web page, change your settings' ));

end;

procedure TFrmMain.SetupBrowser();

begin
	FCanClose            := False;
	FClosing             := False;


	Timer_BrowserSetUp.Enabled := False;


	Chromium1.MultiBrowserMode := False;

	if  (bShowSteamWebPage) then
    	Chromium1.DefaultUrl := 'file:///'+ ChangeFileExt( Application.ExeName, '.html?Msg=To get the mod steam web page, click on a mod in your left list' )
  		else
      Chromium1.DefaultUrl := 'file:///'+ ChangeFileExt( Application.ExeName, '.html?Msg=To get the mod steam web page, change your settings' );




	//    D:/Dev/varcoded/ConanExiles/Conan-Exiles-Mod-Manager/CEMM/Deploy/cemm.html';

	Chromium1.WebRTCIPHandlingPolicy := hpDisableNonProxiedUDP;
	Chromium1.WebRTCMultipleRoutes   := STATE_DISABLED;
	Chromium1.WebRTCNonproxiedUDP    := STATE_DISABLED;




 if not(Chromium1.CreateBrowser(CEFWindowParent1, '')) then Timer_BrowserSetUp.Enabled := True else LoadDefaultWebPage(bShowSteamWebPage);






end;



end.

unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvSmoothSplashScreen,
	BusinessSkinForm, bsSkinData, bsSkinHint, bsSkinCtrls, DzHTMLText,

	DataModuleUnit,


  bsribbon,  bsMessages, siComp, System.ImageList, Vcl.ImgList,
  JvComponentBase, JvErrorIndicator, bsaadapter, cxStyles, cxClasses,
  varcodedxe81;




type
	smType = (smNormal, smWarning,smError);


type
  TFrmMain = class(TForm)
    SplashScreen_Main: TAdvSmoothSplashScreen;
    BusinessSkinForm_Main: TbsBusinessSkinForm;
    CompressedSkinList_Main: TbsCompressedSkinList;
    SkinData_Main: TbsSkinData;
    SkinHint_Main: TbsSkinHint;
    StatusBar_1: TbsSkinStatusBar;
		HTMLText_GameFoldersAndFilesMsg: TDzHTMLText;
    Gauge_Main: TbsSkinGauge;
    Ribbon_Main: TbsRibbon;
    RibbonPage_Main: TbsRibbonPage;
    RibbonGroup_MainOptions: TbsRibbonGroup;
    Button_ModCollection: TbsSkinSpeedButton;
    msgdlg_Main: TbsSkinMessage;
    Lang_Main: TsiLang;
    ImageList_Validator: TImageList;
    ErrorIndicator_Main: TJvErrorIndicator;
    LangDispatcher_Main: TsiLangDispatcher;
    RibbonPage_Settings: TbsRibbonPage;
    RibbonGroup_Settings: TbsRibbonGroup;
    Button_UISettings: TbsSkinSpeedButton;
    Button_GameSettings: TbsSkinSpeedButton;
    Button_SteamSettings: TbsSkinSpeedButton;
    Button_ModsSettings: TbsSkinSpeedButton;
    SkinAdapter_Main: TbsaSkinAdapter;
    StyleReposity_Main: TcxStyleRepository;
    Style_Duplicated: TcxStyle;
    Varcoded: TVarCodedxe81;
    Style_Normal: TcxStyle;
    procedure Button_UISettingsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button_SteamSettingsClick(Sender: TObject);
    procedure Button_GameSettingsClick(Sender: TObject);
    procedure Button_ModsSettingsClick(Sender: TObject);
	private

		dm: TDataModule1;
		/// <remarks>
		///   Web page
		/// </remarks>
		LastUrlVisited: String;

		bShowSteamWebPage: Boolean;
		CanLoadWepPage : Boolean;
		UIThemeIsLight : Boolean;


    procedure ShowUISettings;
		function BeginSession: Boolean;
		function SetUpLog: Boolean;
		procedure SetupUI;
		procedure ShowSteamSettings;
		procedure ShowAppSettings;
		procedure UpdateLanguage(ThisIndex: SmallInt);
		procedure ShowModSettings;
    procedure SetupBrowser;






		{ Private declarations }
	public
		{ Public declarations }

		IslandMode: Boolean;
		IsBrowserEnabled: Boolean;
		BrowserFileName:String;


		procedure ScreenMsg(ThisType: smType; ThisMsg: String;ThisLabel: TDzHTMLText); overload;
		procedure ScreenMsg(ThisType: smType; ThisMsg: String); overload;
		procedure ScreenMsg(ThisMsg: String); overload;




		procedure UpdateModsFromPC(Folder1, Folder2: String);

		function IsEmptyOrNull(const Value: Variant): Boolean;
		function GetModIDFromQuery: String;
		function UpdateModName(NewName: String): Boolean;
		function GetModLastUpdateDate(ThisModID: String): TDateTime;
    function UpdateModLastUpdateDate(ThisModID: String): Boolean;


	end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses ModsSettingsUnit,AppSettingsUnit,SteamSettingsUnit, UISettingsUnit;

function TFrmMain.IsEmptyOrNull(const Value: Variant): Boolean;
begin
  Result := VarIsClear(Value) or VarIsEmpty(Value) or VarIsNull(Value) or (VarCompareValue(Value, Unassigned) = vrEqual);
  if (not Result) and VarIsStr(Value) then
    Result := Value = '';
end;



procedure TFrmMain.Button_GameSettingsClick(Sender: TObject);
begin
ShowAppSettings();
end;

procedure TFrmMain.Button_ModsSettingsClick(Sender: TObject);
begin
ShowModSettings();
end;

procedure TFrmMain.ShowModSettings();
var
	FrmModsSettings: TFrmModsSettings;
	ThisValue:String;
begin	

//	FrmModsSettings:= TFrmModsSettings.Create(FrmMain);
FrmModsSettings:= TFrmModsSettings.Create(FrmMain);

	ThisValue := '';
	dm.GetSetting('cemodfolder',ThisValue);
	FrmModsSettings.Label_CEModFolder.Caption:= ThisValue;

	ThisValue := '';
	dm.GetSetting('appmodfolder',ThisValue);
	FrmModsSettings.Label_AppModFolder.Caption:= ThisValue;

	ScreenMsg(smNormal,'Ready',FrmModsSettings.HTMLText_GameFoldersAndFilesMsg);
	ScreenMsg('Showing dialog.');
	FrmModsSettings.ShowModal;
	ScreenMsg('Ready.');
		


end;

procedure TFrmMain.Button_SteamSettingsClick(Sender: TObject);
begin
ShowSteamSettings();
end;


procedure TFrmMain.ShowAppSettings();

var
	FrmAppSettings: TFrmAppSettings;
	ThisValue:String;

begin

	FrmAppSettings:= TFrmAppSettings.Create(FrmMain);
	ThisValue := '';
	dm.GetSetting('cemodlistfolder',ThisValue);
	FrmAppSettings.FileEdit_modlisttxt.Text := ThisValue;


	ThisValue := '';
	dm.GetSetting('cemodfolder',ThisValue);
	FrmAppSettings.DirectoryEdit_Mods.Text := ThisValue;

	ThisValue := '';
	dm.GetSetting('ceexefile',ThisValue);
	FrmAppSettings.FileEdit_CEEXEFile.Text := ThisValue;

	ScreenMsg(smNormal,'Ready',FrmAppSettings.HTMLText_GameFoldersAndFilesMsg);
	ScreenMsg('Showing dialog.');

	if (FrmAppSettings.ShowModal=1) then begin
	//Save
		dm.SetSetting('cemodlistfolder',FrmAppSettings.FileEdit_modlisttxt.Text );
		dm.SetSetting('cemodfolder',FrmAppSettings.DirectoryEdit_Mods.Text );
		dm.SetSetting('ceexefile',FrmAppSettings.FileEdit_CEEXEFile.Text );
	end;

	ScreenMsg('Ready.');


  
end;



procedure TFrmMain.ShowSteamSettings();

var
	FrmSteamSettings: TFrmSteamSettings;
begin

	FrmSteamSettings:= TFrmSteamSettings.Create(FrmMain);
//	FrmSteamSettings.siLang_UISettings.ActiveLanguage := siLang_Main.ActiveLanguage;



	if (FrmSteamSettings.ShowModal=1) then begin

	end;

end;


procedure TFrmMain.Button_UISettingsClick(Sender: TObject);
begin
ShowUISettings();
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
Sleep(50); //Timer to let UI react
if not (BeginSession()) then begin
	Sleep(50);
	Close;
	Application.Terminate;
end;



end;

function TFrmMain.GetModIDFromQuery(): String;
var
	ThisResult: String;
begin
ThisResult := dm.query_mods.FieldByName('modid').AsString.Trim;
result := ThisResult;
end;

//FrmMain.GetModLastUpdateDate();

function TFrmMain.GetModLastUpdateDate(ThisModID:String): TDateTime;
var
  ThisResult: TDate;
begin
ThisResult := dm.GetModLastUpdateDate(ThisModID);

result := ThisResult;
end;


function TFrmMain.UpdateModLastUpdateDate(ThisModID:String): Boolean;

begin
result := dm.UpdateModLastUpdateDate(ThisModID);
end;






function TFrmMain.UpdateModName(NewName:String): Boolean;

begin

dm.UpdateModName(NewName);
result := true;
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
IslandMode:= False; //Default assume on-line
IsBrowserEnabled := false;
BrowserFileName := '';

{TODO -oZap -cMust have :Define island mode}

varcoded.SetCreator('Zaphod (See "About" option for contact)');



if NOT ( varcoded.IsValidInstallation() ) then
begin
		varcoded.winlogw('Invalid installation, please re-install');
		msgdlg_Main.MessageDlg('Hi, sorry to bother you but, this app installation is corrupted.'+#13+#13+
												'Run it again or re-install this app to fix it.', mtWarning, [mbOk], 0);
		exit ( false );
end;



if NOT ( SetUpLog() ) then
begin
		varcoded.winlogw('Can not setup the LOG file:' + varcoded.MainLogFile );
		msgdlg_Main.MessageDlg('Hi, sorry to bother you but, I can not setup the LOG'+#13+
												'Please check if you have full access to this app folder.'+#13+#13+
												'Run it again or re-install this app to fix it.', mtWarning, [mbOk], 0);
		exit ( false );
end;


	DM:= TDataModule1.Create(FrmMain);
	db := ExtractFilePath(Application.ExeName) + 'cemm.sfp';

	if not (dm.SetupData ( db )) then begin
		varcoded.LogW('Can not setup the DB:' + db + #13+#13+' '+ dm.LastMessage);
		msgdlg_Main.MessageDlg('Hi, sorry to bother you but, I can not setup the main database'+#13+
												'Please check if you have full access to this app folder.'+#13+#13+
												'Run it again or re-install this app to fix it.', mtWarning, [mbOk], 0);
		exit ( false );
	end;


	if not (dm.AreSettingsValid) then begin
		varcoded.LogW('Settings ar not valid, prompting the user to check the settings');
		msgdlg_Main.MessageDlg('Hi, app settings are not valid'+#13+
												'( game folder, mod folder, etc).'+#13+#13+
												'Please review the configuration settings.', mtWarning, [mbOk], 0);

		/// <remarks>
		///  Continue as the settings can be fixed by the user
    /// </remarks>

	end ;






	SetupUI();
	SetupBrowser();



ThisResult := true;
varcoded.Log('App is ready');

ScreenMsg('Ready');
	
result := ThisResult;
end;

procedure TFrmMain.SetupBrowser();
var
	ThisBrowserFile: String;
begin
	ThisBrowserFile := ExtractFilePath(ParamStr(0));
	BrowserFileName := ThisBrowserFile + 'browser\cemmbrowser.exe';
	IsBrowserEnabled := FileExists (BrowserFileName);
	varcoded.Log('Browser file:' +BrowserFileName);

	if IsBrowserEnabled then varcoded.Log('was found') else varcoded.Log('Was NOT found');

end;

procedure TFrmMain.ShowUISettings();
var
	FrmUISettings: TFrmUISettings;

begin
	FrmUISettings := TFrmUISettings.Create(FrmMain);

	FrmUISettings.OfficeComboBox_Languages.ItemIndex := Lang_Main.ActiveLanguage;
	FrmUISettings.OfficeComboBox_Skin.ItemIndex := SkinData_Main.SkinIndex+1;
	if (bShowSteamWebPage) then
		FrmUISettings.ComboBox_ShowWebPage.ItemIndex := 0
		else
		FrmUISettings.ComboBox_ShowWebPage.ItemIndex := 1;


	if (FrmUISettings.ShowModal=1) then begin
	//Save settings and re-apply them

		dm.SetSetting('UILanguage',FrmUISettings.OfficeComboBox_Languages.ItemIndex.ToString() );
		dm.SetSetting('UITheme', FrmUISettings.OfficeComboBox_Skin.ItemIndex.ToString());
		dm.SetSetting('showsteamwebpage', FrmUISettings.ComboBox_ShowWebPage.ItemIndex.tostring() );

		UpdateLanguage(FrmUISettings.OfficeComboBox_Languages.ItemIndex );

		SkinData_Main.SkinIndex:= FrmUISettings.OfficeComboBox_Skin.ItemIndex-1;
		bShowSteamWebPage := FrmUISettings.ComboBox_ShowWebPage.ItemIndex = 0;

		UIThemeIsLight := SkinData_Main.SkinIndex=0; //0 is Light


  end;

  ScreenMsg('Ready');




end;


procedure TFrmMain.UpdateLanguage(ThisIndex:SmallInt);
begin

	Lang_Main.ActiveLanguage := ThisIndex;
	LangDispatcher_Main.ActiveLanguage :=ThisIndex;


end;

procedure TFrmMain.SetupUI;
var
	ThisIndex: smallint;
begin

	Ribbon_Main.ActivePage := RibbonPage_Main;

	ThisIndex := 1;
	if (dm.GetSetting('UILanguage',ThisIndex)) then UpdateLanguage(ThisIndex);

	ThisIndex := 1;
	if (dm.GetSetting('UITheme',ThisIndex)) then 	SkinData_Main.SkinIndex:= ThisIndex-1;
	UIThemeIsLight := SkinData_Main.SkinIndex=0; //0 is Light


	ThisIndex := 1;
	if (dm.GetSetting('showsteamwebpage',ThisIndex)) then bShowSteamWebPage := ThisIndex = 0;

end;


{$REGION 'Log'}


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


{$REGION 'Data'}
	

procedure TFrmMain.UpdateModsFromPC(Folder1,Folder2:String);
begin

	dm.UpdateModListFromPC(Folder1,1,true);
	dm.UpdateModListFromPC(Folder2,2,false);
	


end;
	
	
  
{$ENDREGION}

end.


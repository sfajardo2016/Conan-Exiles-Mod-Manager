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


	varcodedxe8,
  DataModuleUnit,

	bsMessages;

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
    OfficeComboBox_Languages: TbsSkinOfficeComboBox;
    OfficeComboBox_Skin: TbsSkinOfficeComboBox;
    procedure OfficeComboBox_LanguagesChange(Sender: TObject);
    procedure Timer_StartUpTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OfficeComboBox_SkinChange(Sender: TObject);
  private
		dm: TDataModule1;
		function BeginSession: Boolean;
		procedure SetupUI();
    function SetUpLog: Boolean;


    { Private declarations }
  public
		{ Public declarations }
		procedure Log(ThisMsg:String); overload;
		procedure Log(ThisEvent:TLogEventID; ThisMsg:String); overload;

  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

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
begin

	OfficeComboBox_Languages.ItemIndex:= 1;
	OfficeComboBox_Skin.ItemIndex:= 1;

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




	SetupUI();



ThisResult := true;
Log('App is ready');

result := ThisResult;
end;



end.

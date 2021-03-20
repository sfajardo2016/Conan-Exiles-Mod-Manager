unit ModsSettingsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsSkinCtrls,
  BusinessSkinForm, Vcl.StdCtrls, siComp, bsSkinShellCtrls,
  cxGraphics, cxControls,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
	cxGridCustomView, cxGrid, bsaadapter,  JvExControls,
	JvSwitch, cxGridLevel, cxDataStorage, cxEdit, cxNavigator,

	Winapi.ShellAPI,
	Cromis.IPC,


  Data.DB, cxDBData, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  siLngLnk, DzHTMLText, cxCustomData, cxFilter, cxData, dxDateRanges,
  AdvOfficeButtons;

type
  TFrmModsSettings = class(TForm)
    BusinessSkinForm_Main: TbsBusinessSkinForm;
    Panel_GameFolders: TbsSkinExPanel;
    Label_13: TbsSkinStdLabel;
    Button_ValidateFolders: TbsSkinSpeedButton;
    StatusBar_1: TbsSkinStatusBar;
    HTMLText_GameFoldersAndFilesMsg: TDzHTMLText;
    LangLinked_1: TsiLangLinked;
    Label_2: TbsSkinStdLabel;
    Label_CEModFolder: TbsSkinStdLabel;
    Label_1: TbsSkinStdLabel;
    Label_AppModFolder: TbsSkinStdLabel;
		grid_mods: TcxGrid;
    DBTableView_1: TcxGridDBTableView;
    GridDBColumn_1: TcxGridDBColumn;
    GridDBColumn_2: TcxGridDBColumn;
    GridDBColumn_3: TcxGridDBColumn;
    GridDBColumn_4: TcxGridDBColumn;
    GridDBColumn_6: TcxGridDBColumn;
    GridLevel_1: TcxGridLevel;
    GridDBColumn_5: TcxGridDBColumn;
    SkinAdapter_Main: TbsaSkinAdapter;
    Label_3: TbsSkinStdLabel;
    CheckBox_WebBrowser: TbsSkinCheckBox;
    procedure Button_ValidateFoldersClick(Sender: TObject);
    procedure GridDBColumn_5GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure DBTableView_1CellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure DBTableView_1StylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);

	private
    procedure GetMods;
    procedure ShowBrowser;
    function FoundBrowser(TimeOut: Integer): Boolean;
    procedure SendURLToBrowser(ThisURL: String);

    { Private declarations }
	public
    { Public declarations }
  end;

var
  FrmModsSettings: TFrmModsSettings;

implementation

{$R *.dfm}

Uses MainUnit;



procedure TFrmModsSettings.Button_ValidateFoldersClick(Sender: TObject);
begin

GetMods();
end;

procedure TFrmModsSettings.DBTableView_1CellClick(
  Sender: TcxCustomGridTableView;
	ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
	AShift: TShiftState; var AHandled: Boolean);
begin
if (CheckBox_WebBrowser.Checked)  then ShowBrowser();
end;




procedure TFrmModsSettings.DBTableView_1StylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
	var
		ThisValue:Integer;
begin

	ThisValue := 0;
	FrmMain.Log( ARecord.Values[4] );

	try
		if NOT (FrmMain.IsEmptyOrNull (ARecord.Values[4] ))  then ThisValue := ARecord.Values[4];
	except
		on E: Exception do

	end;

	AStyle := nil;
	if (ThisValue = 3 ) then AStyle := FrmMain.Style_Duplicated;




//Style_Duplicated
end;

procedure TFrmModsSettings.ShowBrowser();
var
	thisurl: string;
	thismodid:string;
begin

	thismodid:= FrmMain.GetModIDFromQuery();

	if (thismodid.IsEmpty)  then Exit;

	thisurl := 'http://steamcommunity.com/sharedfiles/filedetails/?id=' + thismodid;


	ShellExecute(Handle, 'open','D:\Dev\varcoded\ConanExiles\Conan-Exiles-Mod-Manager\CEMMBrowser\Deploy\cemmbrowser.exe', 'CEMM', nil, SW_SHOWNORMAL) ;

	 //Wait ??
	if not (FoundBrowser(3)) then begin
		FrmMain.msgdlg_Main.MessageDlg('Can not found the Conan Exiles Web Browser.'+#13+#13+
												'Try again, re-install this app or verify that you download it.', mtWarning, [mbOk], 0);

		Exit;
	end;


	SendURLToBrowser(thisurl);





end;




procedure TFrmModsSettings.SendURLToBrowser(ThisURL:String);

var
	Result: IIPCData;
  Request: IIPCData;
  IPCClient: TIPCClient;
	Error: Boolean;
	hnd: THandle;
	TaskDone: Boolean;
	WindowTitle: String;
	ModDescription: String;

begin

	IPCClient := TIPCClient.Create;
  try
    IPCClient.ComputerName := FrmMain.Varcoded.ComputerName;
    IPCClient.ServerName := 'CEMMIPCServer';
    IPCClient.ConnectClient(cDefaultTimeout);
		try
      if IPCClient.IsConnected then
			begin

				Request := AcquireIPCData;
				Request.ID := DateTimeToStr(Now);
				Request.Data.WriteString('URL',ThisURL);
				Request.Data.WriteString('Theme',FrmMain.SkinData_Main.SkinIndex.ToString() );
				Result := IPCClient.ExecuteConnectedRequest(Request);

        if IPCClient.AnswerValid then
				begin
					//Get description ??

					if NOT ( FrmMain.IslandMode ) then begin
						WindowTitle := Result.Data.ReadString('WindowsTitle');


						if NOT (WindowTitle.ToUpper.Equals('SAME')) then begin
							 FrmMain.UpdateModName(WindowTitle.Replace('Steam Workshop::',''));
							 ModDescription := Result.Data.ReadString('ModDescription');

							 showmessage(ModDescription);
						end;


					end;





        end
      end;

    finally
      IPCClient.DisconnectClient;
    end;
  finally
    IPCClient.Free;
	end;



end;

function TFrmModsSettings.FoundBrowser(TimeOut: Integer):Boolean;
	var
	bRes: Boolean;
	Waiting: Boolean;
	TimeOutCounter: Integer;
	hnd: THandle;
begin
	bRes := false;
	Waiting := true;
	TimeOutCounter:=0;


	while (Waiting) do begin

		hnd := FindWindow(nil, PChar('Conan Exiles Steam Mod Browser'));
		if (hnd = 0 ) then begin //not found
			Inc(TimeOutCounter);
			if ( TimeOutCounter >= TimeOut )  then begin
			 Waiting := False;
			end else Sleep(1000); 		//wait 1 second
		end else begin
			bRes := true;
			Waiting := False;
		end;
	end;

	result := bRes;

end;





procedure TFrmModsSettings.GetMods();
begin
FrmMain.varcoded.EnterProc('Getting mods');
FrmMain.UpdateModsFromPC ( Label_CEModFolder.Caption,Label_AppModFolder.Caption );
FrmMain.varcoded.ExitProc('Getting mods');

end;

procedure TFrmModsSettings.GridDBColumn_5GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
	var AText: string);
	var
		ThisValue:Integer;
begin

	ThisValue := 0;
	FrmMain.Log( ARecord.Values[4] );

	try
		if NOT (FrmMain.IsEmptyOrNull (ARecord.Values[4] ))  then ThisValue := ARecord.Values[4];
	except
		on E: Exception do

	end;

	case ThisValue of
		0: AText := 'N/A';
		1: AText := 'Game folder';
		2: AText := 'App folder';
		3: AText := 'Both folders(!)';


	end;

end;

end.



unit ModsSettingsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsSkinCtrls,  bsSkinExCtrls,
  BusinessSkinForm, bsSkinBoxCtrls, Vcl.StdCtrls, siComp, bsSkinShellCtrls,
  Vcl.Mask, JvValidators, JvComponentBase, DzHTMLText, siLngLnk,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, Data.DB, cxDBData, cxSpinEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid;

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
    GridDBColumn_5: TcxGridDBColumn;
    GridLevel_1: TcxGridLevel;
    GridDBColumn_6: TcxGridDBColumn;
    procedure Button_ValidateFoldersClick(Sender: TObject);

	private
    procedure GetMods;

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

procedure TFrmModsSettings.GetMods();
begin
FrmMain.varcoded.EnterProc('Getting mods');
FrmMain.UpdateModsFromPC ( Label_CEModFolder.Caption,Label_AppModFolder.Caption );
FrmMain.varcoded.ExitProc('Getting mods');

end;

end.


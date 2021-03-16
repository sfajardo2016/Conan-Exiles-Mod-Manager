unit Main1Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsMessages, bsSkinMenus,
  System.ImageList, Vcl.ImgList, bsPngImageList, Vcl.Menus, bsSkinData,
  bsSkinHint, BusinessSkinForm, bsColorCtrls, bsSkinBoxCtrls,
  bsSkinExCtrls, Vcl.StdCtrls, bsSkinCtrls, bsribbon, bsaadapter,
  DzHTMLText;

type
  TFrmMain = class(TForm)
    SkinHint_Main: TbsSkinHint;
    Ribbon_1: TbsRibbon;
    RibbonPage_12: TbsRibbonPage;
    RibbonGroup_MainOptions: TbsRibbonGroup;
    Button_ModCollection: TbsSkinSpeedButton;
    CompressedSkinList_1: TbsCompressedSkinList;
    SkinData_1: TbsSkinData;
    BusinessSkinForm_1: TbsBusinessSkinForm;
    SkinAdapter_1: TbsaSkinAdapter;
    StatusBar_1: TbsSkinStatusBar;
    HTMLText_GameFoldersAndFilesMsg: TDzHTMLText;
    Gauge_Main: TbsSkinGauge;
    RibbonGroup_Settings: TbsRibbonGroup;
    Button_UISettings: TbsSkinSpeedButton;
    Button_GameSettings: TbsSkinSpeedButton;
    Button_SteamSettings: TbsSkinSpeedButton;
    procedure Button_UISettingsClick(Sender: TObject);
  private
    procedure ShowUISettings;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation
{$R *.dfm}
uses UISettingsUnit;

procedure TFrmMain.Button_UISettingsClick(Sender: TObject);
begin
ShowUISettings();
end;

procedure TFrmMain.ShowUISettings();
var
	FrmUISettings: TFrmUISettings;
begin
	FrmUISettings := TFrmUISettings.Create(FrmMain);
	FrmUISettings.ShowModal;

end;

end.

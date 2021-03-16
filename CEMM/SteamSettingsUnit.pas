unit SteamSettingsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsSkinCtrls,  bsSkinExCtrls,
  BusinessSkinForm, bsSkinBoxCtrls, Vcl.StdCtrls, siComp, bsSkinShellCtrls,
  Vcl.Mask, Vcl.ComCtrls, bsSkinTabs, siLngLnk;

type
  TFrmSteamSettings = class(TForm)
    Panel_SettingsOKButton: TbsSkinPanel;
    Button_SaveSettings: TbsSkinButton;
    Button_CancelSettings: TbsSkinButton;
    BusinessSkinForm_Main: TbsBusinessSkinForm;
    bsSkinPanel1: TbsSkinPanel;
    Button_setupsteamcmd: TbsSkinSpeedButton;
    bsSkinStdLabel1: TbsSkinStdLabel;
    edit_steamcmdzipfile: TbsSkinEdit;
    PageControl_1: TbsSkinPageControl;
    bsSkinTabSheet1: TbsSkinTabSheet;
    Memo_log: TbsSkinMemo;
    bsSkinTabSheet2: TbsSkinTabSheet;
    Memo_Steam: TbsSkinMemo;
    LangLinked_1: TsiLangLinked;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSteamSettings: TFrmSteamSettings;

implementation

{$R *.dfm}

end.

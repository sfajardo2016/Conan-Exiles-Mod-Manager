unit UISettingsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsSkinCtrls,  bsSkinExCtrls,
  BusinessSkinForm, bsSkinBoxCtrls, Vcl.StdCtrls, siComp, siLngLnk;

type
  TFrmUISettings = class(TForm)
    OfficeComboBox_Languages: TbsSkinOfficeComboBox;
    OfficeComboBox_Skin: TbsSkinOfficeComboBox;
    Panel_SettingsOKButton: TbsSkinPanel;
    Button_SaveSettings: TbsSkinButton;
    Button_CancelSettings: TbsSkinButton;
    BusinessSkinForm_Main: TbsBusinessSkinForm;
    Label_1: TbsSkinStdLabel;
    ComboBox_ShowWebPage: TbsSkinComboBoxEx;
    LangLinked_1: TsiLangLinked;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUISettings: TFrmUISettings;

implementation

{$R *.dfm}

end.

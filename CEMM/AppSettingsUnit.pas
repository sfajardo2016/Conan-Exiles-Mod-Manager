unit AppSettingsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsSkinCtrls,  bsSkinExCtrls,
  BusinessSkinForm, bsSkinBoxCtrls, Vcl.StdCtrls, siComp, bsSkinShellCtrls,
  Vcl.Mask, JvValidators, JvComponentBase, DzHTMLText, siLngLnk;

type
  TFrmAppSettings = class(TForm)
    Panel_SettingsOKButton: TbsSkinPanel;
    Button_SaveSettings: TbsSkinButton;
    Button_CancelSettings: TbsSkinButton;
    BusinessSkinForm_Main: TbsBusinessSkinForm;
    Panel_GameFolders: TbsSkinExPanel;
    Label_11: TbsSkinStdLabel;
    Label_12: TbsSkinStdLabel;
    Label_13: TbsSkinStdLabel;
    Label_14: TbsSkinStdLabel;
    Label_15: TbsSkinStdLabel;
    Label_16: TbsSkinStdLabel;
    Button_ValidateFolders: TbsSkinSpeedButton;
    DirectoryEdit_Mods: TbsSkinDirectoryEdit;
    FileEdit_CEEXEFile: TbsSkinFileEdit;
    FileEdit_modlisttxt: TbsSkinFileEdit;
    JvValidators1: TJvValidators;
    CustomValidator_MODLISTFile: TJvCustomValidator;
    CustomValidator_ModFolder: TJvCustomValidator;
    CustomValidator_EXEFiles: TJvCustomValidator;
    StatusBar_1: TbsSkinStatusBar;
    HTMLText_GameFoldersAndFilesMsg: TDzHTMLText;
    LangLinked_1: TsiLangLinked;
    procedure CustomValidator_MODLISTFileValidate(Sender: TObject;
      ValueToValidate: Variant; var Valid: Boolean);
    procedure CustomValidator_ModFolderValidate(Sender: TObject;
      ValueToValidate: Variant; var Valid: Boolean);
    procedure CustomValidator_EXEFilesValidate(Sender: TObject;
      ValueToValidate: Variant; var Valid: Boolean);
    procedure Button_ValidateFoldersClick(Sender: TObject);
  private
    procedure ValidateFoldersAndFiles;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAppSettings: TFrmAppSettings;

implementation

{$R *.dfm}

Uses MainUnit;

procedure TFrmAppSettings.Button_ValidateFoldersClick(Sender: TObject);
begin
ValidateFoldersAndFiles();
end;

procedure TFrmAppSettings.ValidateFoldersAndFiles();
begin
FrmMain.ScreenMsg(smNormal,'Validating files and folders . . .',HTMLText_GameFoldersAndFilesMsg);


if NOT (JvValidators1.Validate) then begin

	FrmMain.ScreenMsg(smWarning,'Please check warnings.',HTMLText_GameFoldersAndFilesMsg);
	Exit;

end;




FrmMain.ScreenMsg(smNormal,'App settings are OK, don'+#39+'t forget to save them !',HTMLText_GameFoldersAndFilesMsg);

end;

procedure TFrmAppSettings.CustomValidator_EXEFilesValidate(Sender: TObject;
	ValueToValidate: Variant; var Valid: Boolean);
	var
	ThisFile: String;
begin

	ThisFile := FileEdit_CEEXEFile.Text;
	Valid := (FileExists(ThisFile)  ) ;  //and  (ThisFile.ToUpper.EndsWith('CONANSANDBOX.EXE'));

end;

procedure TFrmAppSettings.CustomValidator_ModFolderValidate(
	Sender: TObject; ValueToValidate: Variant; var Valid: Boolean);
begin
Valid := DirectoryExists(DirectoryEdit_Mods.Text  );
end;

procedure TFrmAppSettings.CustomValidator_MODLISTFileValidate(
  Sender: TObject; ValueToValidate: Variant; var Valid: Boolean);
begin
Valid := FileExists(FileEdit_modlisttxt.Text  );
end;

end.

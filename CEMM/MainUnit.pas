unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,Forms,
  Vcl.Controls,   siComp,
  BusinessSkinForm, bsSkinExCtrls, Vcl.ExtCtrls, bsSkinData, bsSkinCtrls;

type
  TFrmMain = class(TForm)
    StatusBar_1: TbsSkinStatusBar;
    BusinessSkinForm_1: TbsBusinessSkinForm;
    SkinData_1: TbsSkinData;
    CompressedSkinList_1: TbsCompressedSkinList;
    siLang_Main: TsiLang;
    Timer_StartUp: TTimer;
    OfficeComboBox_Languages: TbsSkinOfficeComboBox;
    OfficeComboBox_Skin: TbsSkinOfficeComboBox;
    procedure OfficeComboBox_LanguagesChange(Sender: TObject);
    procedure Timer_StartUpTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OfficeComboBox_SkinChange(Sender: TObject);
  private
		function BeginSession: Boolean;
		procedure SetupUI();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
Timer_StartUp.Enabled := true;

end;

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
begin
ThisResult := false;

	SetupUI();





ThisResult := true;
result := ThisResult;
end;


end.

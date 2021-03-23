{********************************************************************}
{ TMS TAdvShaper Demo                                                }
{                                                                    }
{                                                                    }
{ written by TMS Software                                            }
{            copyright � 2012                                        }
{            Email : info@tmssoftware.com                            }
{            Website : http://www.tmssoftware.com                    }
{********************************************************************}

unit AdvShaperDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvShaper, StdCtrls, AdvGlowButton, Vcl.Menus, bsSkinMenus,
  AdvGlassButton, JvExControls, JvButton, JvTransparentButton,
  AdvCircularProgress, AdvSmoothStatusIndicator;

type
  TFrmMain = class(TForm)
    AdvShaper2: TAdvShaper;
    TransparentButton_Close: TJvTransparentButton;
    CircularProgress_1: TAdvCircularProgress;
    procedure TransparentButton_CloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}



procedure TFrmMain.TransparentButton_CloseClick(Sender: TObject);
begin
Close;
end;

end.
unit PlugInPlugInCEMPluginBrowserFull;

interface

uses
	Windows, Messages, SysUtils, Classes, Dialogs, Forms, Controls,
 	varcodedxe81,
	FormBrowserUnit2,


  JvPlugin;

type
  TCEMPluginBrowserFull = class(TJvPlugIn)
    procedure JvPlugInPluginMessage(Sender: TObject;
      APluginMessage: Integer; AMessageText: string);
    procedure JvPlugInCreate(Sender: TObject);
	private

		{ Private declarations }
		ThisWebPage,ThisWebPageTitle: String;
		ModPosted,ModUpdated: String;
		FrmBrowser2: TFrmBrowser2;
    procedure ShowBrowser(ThisModID: String);

  public
    { Public declarations }
end;

function RegisterPlugin: TJvPlugIn; stdcall;


implementation

{$R *.dfm}

// IMPORTANT NOTE: If you change the name of the Plugin container,
// you must set the type below to the same type. (Delphi changes
// the declaration, but not the procedure itself. Both the return
// type and the type created must be the same as the declared type above.
function RegisterPlugin: TJvPlugIn;
begin
  Result := TCEMPluginBrowserFull.Create(nil);
end;






procedure TCEMPluginBrowserFull.JvPlugInCreate(Sender: TObject);
begin
CreateGlobalCEFApp;
end;

procedure TCEMPluginBrowserFull.JvPlugInPluginMessage(
	Sender: TObject; APluginMessage: Integer; AMessageText: string);
		var
	ThisVarCoded: TVarCodedxe81;

begin

	case APluginMessage of
		101: Begin //Get Title
		End;

		301: Begin //Show Browser

			ShowBrowser(AMessageText);

					ThisVarCoded :=   TVarCodedxe81(HostApplication.MainForm.FindComponent('VarCoded')) ;//      TVarCodedxe81 (HostApplication.MainForm.Components[I]  );
					ThisVarCoded.PlugInsMsg.Add('ModTitle',ThisWebPageTitle);
					ThisVarCoded.PlugInsMsg.Add('ModDescription',ThisWebPage);
					ThisVarCoded.PlugInsMsg.Add('ModPosted',ModPosted);
					ThisVarCoded.PlugInsMsg.Add('ModUpdated',ModUpdated);




		End;


	end;
end;


procedure TCEMPluginBrowserFull.ShowBrowser(ThisModID:String);


begin



	if ( FrmBrowser2=nil) then begin

			FrmBrowser2:= TFrmBrowser2.Create(self);

	end;


	FrmBrowser2.VisitWebPage(ThisModID,ThisWebPageTitle,ThisWebPage,ModPosted,ModUpdated );
	FrmBrowser2.Caption := FrmBrowser2.FrameBrowser1.ModTitle;

	FrmBrowser2.Show;




end;


end.

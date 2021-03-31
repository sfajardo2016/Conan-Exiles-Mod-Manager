unit PlugInCEMPluginBrowserLite;

interface

uses
	Windows, Messages, SysUtils, Classes, Dialogs, Forms, Controls,
	Vcl.StdCtrls,
	varcodedxe81,
	FormBrowserUnit,
	Vcl.ExtCtrls,
	JvPlugin;

type
	TCEMLiteBrowserPlugin = class(TJvPlugIn)
		procedure JvPlugInPluginMessage(Sender: TObject;
			APluginMessage: Integer; AMessageText: string);
	private

		FrmBrowser: TFrmBrowser;
		ThisWebPage,ThisWebPageTitle: String;
		ModPosted,ModUpdated: String;
		procedure ShowBrowser(ThisModID: String);
		{ Private declarations }
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
	Result := TCEMLiteBrowserPlugin.Create(nil);
end;

procedure TCEMLiteBrowserPlugin.JvPlugInPluginMessage(Sender: TObject;
  APluginMessage: Integer; AMessageText: string);
	var
	ThisVarCoded: TVarCodedxe81;


begin

	case APluginMessage of
		101: Begin //Get Title

		End;

		201: Begin //Show Browser
			ShowBrowser(AMessageText);
			//		ThisWebPage,ThisWebPageTitle: String;
					ThisVarCoded :=   TVarCodedxe81(HostApplication.MainForm.FindComponent('VarCoded')) ;//      TVarCodedxe81 (HostApplication.MainForm.Components[I]  );
					ThisVarCoded.PlugInsMsg.Add('ModTitle',ThisWebPageTitle);
					ThisVarCoded.PlugInsMsg.Add('ModDescription',ThisWebPage);
					ThisVarCoded.PlugInsMsg.Add('ModPosted',ModPosted);
					ThisVarCoded.PlugInsMsg.Add('ModUpdated',ModUpdated);




		End;

		301: Begin //Visit web page






    End;


	end;

end;

procedure TCEMLiteBrowserPlugin.ShowBrowser(ThisModID:String);


begin



	if ( FrmBrowser=nil) then begin

			FrmBrowser:= TFrmBrowser.Create(self);

	end;
	FrmBrowser.VisitWebPage(ThisModID,ThisWebPageTitle,ThisWebPage,ModPosted,ModUpdated );
	FrmBrowser.Caption := FrmBrowser.FrameBrowser1.ModTitle;
	FrmBrowser.Show;




end;

//

end.

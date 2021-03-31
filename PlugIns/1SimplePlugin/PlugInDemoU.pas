{******************************************************************

											 JEDI-VCL Demo

 Copyright (C) 2002 Project JEDI

 Original author:

 Contributor(s):

 You may retrieve the latest version of this file at the JEDI-JVCL
 home page, located at http://jvcl.delphi-jedi.org

 The contents of this file are used with permission, subject to
 the Mozilla Public License Version 1.1 (the "License"); you may
 not use this file except in compliance with the License. You may
 obtain a copy of the License at
 http://www.mozilla.org/MPL/MPL-1_1Final.html

 Software distributed under the License is distributed on an
 "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 implied. See the License for the specific language governing
 rights and limitations under the License.

******************************************************************}

unit PlugInDemoU;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	JvPluginManager, StdCtrls, Buttons, Menus, ExtCtrls, ImgList, JvComponent,

  JvComponentBase, varcodedxe81;

type
	TForm1 = class(TForm)
    uilPluginManager: TJvPluginManager;
    clbPlugins: TListBox;
    MainMenu1: TMainMenu;
    Plugin1: TMenuItem;
    lbStatus: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    labAuthor: TLabel;
    Label2: TLabel;
    labDescription: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    SendMessagetoPlugins1: TMenuItem;
    N1: TMenuItem;
    Splitter1: TSplitter;
    VarCoded: TVarCodedxe81;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure uilPluginManagerBeforeLoad(Sender: TObject; Filename: String;
      var AllowLoad: Boolean);
    procedure uilPluginManagerBeforeLoading(Sender: TObject);
    procedure clbPluginsClick(Sender: TObject);
    procedure clbPluginsDblClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure SendMessagetoPlugins1Click(Sender: TObject);
		procedure uilPluginManagerAfterLoad(Sender: TObject; FileName: String;
			const ALibHandle: Cardinal; var AllowLoad: Boolean);
		procedure Button1Click(Sender: TObject);
		procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
	private
  	PlugIsLoaded: Boolean;

		{ Private declarations }
	public
		NumButtons : integer;
		ModTitle: String;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}





procedure TForm1.FormCreate(Sender: TObject);
begin
   uilPluginManager.LoadPlugins;
	 uilPluginManager.GetLoadedPlugins(clbPlugins.Items);
	 PlugIsLoaded:=True;
end;

procedure TForm1.uilPluginManagerBeforeLoad(Sender: TObject;
  Filename: String; var AllowLoad: Boolean);
begin
   lbStatus.Items.Add('Loading Plug-in: ' + Filename);
end;

procedure TForm1.uilPluginManagerBeforeLoading(Sender: TObject);
begin
   lbStatus.Items.Add('Starting to load Plug-ins');
end;

procedure TForm1.Button1Click(Sender: TObject);

begin

	 uilPluginManager.BroadcastMessage(201, '1113901982');
	 varcoded.PlugInsMsg.Clear;










end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if (PlugIsLoaded) then begin
			uilPluginManager.UnloadPlugin(0);
      uilPluginManager.UnloadPlugin(0);
	Button2.Caption:= 'Load';




end else begin

Button2.Caption:= 'Unload';
	 uilPluginManager.LoadPlugins;


end;

PlugIsLoaded := not ( PlugIsLoaded);

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
	 uilPluginManager.BroadcastMessage(301, '1113901982');
	 varcoded.PlugInsMsg.Clear;

end;

procedure TForm1.clbPluginsClick(Sender: TObject);
begin
   if clbPlugins.ItemIndex = -1 then Exit;
   labAuthor.Caption := uilPluginManager.Plugins[clbPlugins.ItemIndex].Author;
   labDescription.Caption := uilPluginManager.Plugins[clbPlugins.ItemIndex].Description;
end;

procedure TForm1.clbPluginsDblClick(Sender: TObject);
begin
   uilPluginManager.Plugins[clbPlugins.ItemIndex].Configure;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
   Close;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
   ShowMessage('A simple host application for demoing JEDI Plug-ins.'#13#10#13#10'(c) 2002, Project JEDI.');
end;


procedure TForm1.SendMessagetoPlugins1Click(Sender: TObject);
begin
	 uilPluginManager.BroadcastMessage(101, '1113901982');
	 showmessage(varcoded.PlugInsMsg['ModPosted']+'x' );



	 varcoded.PlugInsMsg.Remove( 'ModPosted' );

end;

procedure TForm1.uilPluginManagerAfterLoad(Sender: TObject;
  FileName: String; const ALibHandle: Cardinal; var AllowLoad: Boolean);
begin
   uilPluginManager.GetLoadedPlugins(clbPlugins.Items);
   lbStatus.Items.Add('Finished loading Plug-in: ' + Filename);
end;

end.

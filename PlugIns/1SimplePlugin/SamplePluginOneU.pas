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

unit SamplePluginOneU;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Vcl.Dialogs,
	Vcl.Forms,
	Vcl.StdCtrls,
  JvPlugin;

type
  TSampleUILPlugin = class(TJvPlugin)
    procedure uilPlugin1PluginMessage(Sender: TObject; APluginMessage: Integer; AMessageText: string);
    procedure uilPlugin1Configure(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function RegisterPlugin: TSampleUILPlugin; stdcall;

implementation

{$R *.DFM}

// IMPORTANT NOTE: If you change the name of the Plugin container,
// you must set the type below to the same type. (Delphi changes
// the declaration, but not the procedure itself. Both the return
// type and the type created must be the same as the declared type above.

function RegisterPlugin: TSampleUILPlugin;
begin
  Result := TSampleUILPlugin.Create(nil);
end;

procedure TSampleUILPlugin.uilPlugin1PluginMessage(Sender: TObject;
	APluginMessage: Integer; AMessageText: string);
	var
	i:integer;
	ThisMemo: TMemo;

begin

	case APluginMessage of
		101: Begin //Get Title
			HostApplication.MainForm.Caption:= 'The mod title';
			for I := 0 to HostApplication.MainForm.ComponentCount-1 do begin
				if ( HostApplication.MainForm.Components[I].Name = 'Memo_buffer')   then begin

					ThisMemo := TMemo (HostApplication.MainForm.Components[I]  );
					ThisMemo.Lines.add('From here !!');
          Break;


        end;



      end;





		End;


	end;


end;

procedure TSampleUILPlugin.uilPlugin1Configure(Sender: TObject);
begin
  ShowMessage('You could put a configuration dialog here, if your plugin requires one.');
end;

end.

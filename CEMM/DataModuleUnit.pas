unit DataModuleUnit;

interface

uses
	System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
	FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
	FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
	FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
	FireDAC.Stan.ExprFuncs, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.UI,
	FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
	FireDAC.Comp.DataSet, FireDAC.Phys.SQLiteDef;

type
	TDataModule1 = class(TDataModule)
		fdgxwtcrsr1: TFDGUIxWaitCursor;
		con_1: TFDConnection;
		query_mods: TFDQuery;
		ds_query_mods: TDataSource;
		query_INI: TFDQuery;
		Transaction_1: TFDTransaction;
		query_modset: TFDQuery;
		ds_query_modset: TDataSource;
		Query_settings: TFDQuery;
    Query_test: TFDQuery;
    ds_query_test: TDataSource;
	private

		FileList: TStringList;

		procedure DeleteMods;
		procedure Log(m: string);
		procedure ScanForAllMods(const Dir: string;ThisType:SmallInt);







		{ Private declarations }
	public
		LastMessage: string;
		function UpdateModListFromPC(thisfolder: string;ThisType:SmallInt;  DeleteOld:Boolean): string;
		function SetupData(s: string): Boolean;



		function GetSetting(ThisKey:string; out ThisValue:String):Boolean; overload;
		function GetSetting(ThisKey:string; out ThisValue: Integer):Boolean; overload;
		function GetSetting(ThisKey:string; out ThisValue: SmallInt):Boolean; overload;
		function SetSetting(ThisKey, ThisValue: String): Boolean;

		procedure UpdateModName(NewName: String);
		function GetModLastUpdateDate(ThisID: String): TDateTime;
		function UpdateModLastUpdateDate(ThisID: String): Boolean;


		function AreSettingsValid: Boolean;
		function CreateDefaultFolders: Boolean;
		{ Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
uses MainUnit;


{$REGION 'Get Settings Keys'}
  
  function TDataModule1.GetSetting(ThisKey:string; out ThisValue:String):Boolean;
  var
  	bRes: Boolean;
  begin
  	ThisValue := '';
  
  	bRes:= Query_settings.Locate('value',ThisKey,[]);
  	if (bRes) then ThisValue := Query_settings.FieldByName('data').AsString;
  	result := bRes;
  end;
  
  
  function TDataModule1.GetSetting(ThisKey:string; out ThisValue: Integer):Boolean;
  var
  	bRes: Boolean;
  begin
  	ThisValue := -1;
  	bRes:= Query_settings.Locate('value',ThisKey,[]);
  	if (bRes) then ThisValue := Query_settings.FieldByName('data').AsInteger;
  	result := bRes;
  
  end;
  
  
  function TDataModule1.GetSetting(ThisKey:string; out ThisValue: smallint):Boolean;
  var
  	bRes: Boolean;
  begin
  	ThisValue := -1;
  	bRes:= Query_settings.Locate('value',ThisKey,[]);
  	if (bRes) then ThisValue := Query_settings.FieldByName('data').AsInteger;
  	result := bRes;
  
  end;

  
{$ENDREGION}

{$REGION 'Set Settings Keys'}

  function TDataModule1.SetSetting(ThisKey:string; ThisValue:String):Boolean;
	var
  	bRes: Boolean;
  begin
		bRes:= Query_settings.Locate('value',ThisKey,[]);
		if (bRes) then begin
			Query_settings.Edit;
			Query_settings.FieldByName('data').AsString := ThisValue;
			Query_settings.Post;

    end;
  	result := bRes;
  end;





{$ENDREGION}




function TDataModule1.CreateDefaultFolders():Boolean;
var
  datakey: string;
  datavalue:string;
  datavalueb: Boolean;
  stillchecking, r: Boolean;

begin

  stillchecking := True;
  r:= False;

  //Create the data for the folders

  //Update basic folders
  datavalue := ExtractFileDir(ParamStr(0));
  SetSetting('cectmainfolder',datavalue );

  datavalue := datavalue + '\steamcmd';
  SetSetting('steamcmdfolder',datavalue );
  SetSetting('steamcmdzipfile',datavalue + '\steamcmd.zip');

  datavalue := datavalue + '\cectmods';
  SetSetting('cectsteamcmdfolder',datavalue);
  SetSetting('cectmodfolder',datavalue + '\steamapps');




  with (Query_settings) do begin
    First;

    while not (Eof) and stillchecking do begin

      datavalue := FieldByName('datatype').AsString.ToLower();


      if  (datavalue.StartsWith('dc'))  then begin //it's a directory and must create

        datavalue := FieldByName('data').AsString.ToLower().Trim();





        if not (DirectoryExists(datavalue)) then begin
          try

            r:= ForceDirectories(datavalue );




          except on E: Exception do
            LastMessage := e.Message + #13+ datavalue;

          end;

          if not(r) then begin



            stillchecking := False;


          end; //r=false

        end; //dir doesnt exists

      end;

      Next;

    end;
      r:= True;


  end;

  result := r;







end;



function TDataModule1.AreSettingsValid():Boolean;
var
  thisvalue: string;
  r: Boolean;
begin

	r:= GetSetting('cectvalidsettings', ThisValue);

	if (r)  then r:=(thisvalue='1');

	if not (r) then LastMessage := 'Settings are not valid';

	exit(r);



end;

function TDataModule1.SetupData(s: string): Boolean;
var
  res: Boolean;
begin

  LastMessage :='';
  res := FileExists(s);


  if (res) then
  begin
    with con_1 do
    begin
      Close;
      Params.Clear;
      Params.Add('Database=' + s);
      Params.Add('LockingMode=Normal');
      Params.Add('Synchronous=Full');
      Params.Add('DateTimeFormat=DateTime');
      Params.Add('DriverID=SQLite');
      LoginPrompt := False;
      try
        Connected := True;
        query_mods.Open();
//        query_modset.Open();
				Query_settings.Open();

        res := True;
      except
        on E: Exception do
          LastMessage :=  E.Message;

      end;
    end;

  end
  else
    LastMessage := 'DB File not found'; // if exists


  result := res;

end;



	procedure TDataModule1.Log(m: string);
	begin
		FrmMain.Varcoded.Log(m);
  end;




  procedure TDataModule1.DeleteMods();
  begin

    with (query_INI ) do
    begin
      Close;
      Sql.Clear;

      Sql.Text := 'delete from mods;';

      try
        Prepare;
        Transaction.StartTransaction;
        ExecSQL;
				Transaction.Commit;
				Log('All mods delete from the table');
      except
        on E: Exception do
        begin
          Log(E.Message);
          LastMessage := E.Message;
        end;

      end;
      Close;

    end;

    query_mods.Refresh;

  end;

	function TDataModule1.UpdateModListFromPC(thisfolder: string;ThisType:SmallInt; DeleteOld:Boolean ): string;
	var
		r: string;
	begin

		if ( DeleteOld) then begin
			Log('Deleting old data from mods');
			DeleteMods();
		end;

		FileList := TStringList.Create;
		Log('Getting mods from: ' + thisfolder);

		ScanForAllMods(thisfolder,ThisType);
		r := '';
		LastMessage := '';
		// add all mods
		query_mods.Refresh;
		query_mods.First;

		FreeAndNil(		FileList );


		result := r;
	end;


procedure TDataModule1.UpdateModName(NewName:String);
begin
with (query_mods) do begin
	Edit;
	FieldByName('modname').AsString:= NewName;
	Post;
end;

end;


function TDataModule1.GetModLastUpdateDate(ThisID:String): TDateTime;
var
	ThisResult: TDate;
begin

with (query_mods) do begin
	ThisResult := FieldByName('modlastupdatedate').AsDateTime;
end;
result := ThisResult;
end;

function TDataModule1.UpdateModLastUpdateDate(ThisID:String): Boolean;

var
	DayToday:TDateTime;
	JustDate: TDateTime;
begin

	DayToday := Now();
	JustDate := date;
with (query_mods) do begin
	Edit;
	FieldByName('moddescription').AsString := 'Description goes here';
	FieldByName('modlastupdatedate').AsString :=  DateTimeToSTR(DayToday);
	Post;

end;


result := True;
end;



procedure TDataModule1.ScanForAllMods(const Dir: string;ThisType:SmallInt);
var
  SR: TSearchRec;

  FullFileName: String;
  FileName: string;
  ModSize: Int64;

  PartString: string;

  Pos1: Integer;


begin

  query_mods.DisableControls;

  if FindFirst(IncludeTrailingBackslash(Dir) + '*.*', faAnyFile or faDirectory,
    SR) = 0 then
    try
      repeat
        if (SR.Attr and faDirectory) = 0 then
        begin

          FileName := SR.Name;

          if (FileName.ToUpper().EndsWith('.PAK')) then
          begin
            with (query_mods) do
            begin

              FullFileName := Dir + '\' + FileName;

              ModSize := Int64(SR.FindData.nFileSizeHigh) shl Int64(32) +
                Int64(SR.FindData.nFileSizeLow);
							ModSize := Round(ModSize / 1000); // mb

							Pos1 := Pos('\440900\', FullFileName);
							PartString := FullFileName.Substring(Pos1);
							PartString := PartString.Replace('440900', '').Replace('\', '')
								.Replace(FileName, '');


							if not (Locate('modid',PartString,[]))  then begin
								Append;
								FieldByName('modid').AsString := PartString;

								FieldByName('modname').AsString := FileName.ToUpper.Replace('.PAK', '').Replace('_',' ').Replace('-',' ');
								FieldByName('modsize').AsInteger := ModSize;
								FieldByName('modlocation').AsInteger := ThisType;

	//              FieldByName('moddescription').AsString := 'N/A';
								FieldByName('modfile').AsString := FullFileName;
								FieldByName('modlastupdatedate').AsDateTime := StrToDateTime('03/12/1972');

								Log('New mod added:' +FullFileName);
								Post;
							end else begin
								//duplicated
								if (ThisType<>FieldByName('modlocation').AsInteger) then begin
									Edit;
									FieldByName('modlocation').AsInteger := 3; //Both folders
									Post;
									Log('Mod ' + ExtractFileName(FullFileName)  +' is duplicated !');
                end;
              end;

            end;
          end; // .pak file

        end
        else if (SR.Name <> '.') and (SR.Name <> '..') then
        begin
          ScanForAllMods(IncludeTrailingBackslash(Dir) + SR.Name,ThisType);
        end; // ignored
        // recursive call!
      until FindNext(SR) <> 0;
    finally
      FindClose(SR);
    end;

//  UpdateMemTable;
  query_mods.EnableControls;

end;





end.

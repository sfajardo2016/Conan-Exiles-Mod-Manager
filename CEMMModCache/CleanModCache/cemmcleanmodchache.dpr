library cemmcleanmodchache;



uses SysUtils, Classes, Vcl.Dialogs;



procedure CleanMod(ThisFolder: Pchar);stdcall; export;
var
	ModID:String;
	RootFolder: String;
	FakeIndexFile: String;
	RealIndexFile: String;
	FileLines:TStringList;
	I:Integer;
begin

/// <remarks>
/// Expected a cache folder
/// </remarks>

	if NOT (DirectoryExists(ThisFolder)) then exit;

	//Delete misc files
	try

		if (FileExists(ThisFolder+'\'+'backblue.gif'))  then DeleteFile(ThisFolder+'\'+'backblue.gif' );
		if (FileExists(ThisFolder+'\'+'cookies.txt' ))  then DeleteFile(ThisFolder+'\'+'cookies.txt' );
		if (FileExists(ThisFolder+'\'+'fade.gif' ))  then DeleteFile(ThisFolder+'\'+'fade.gif' );

	except on E: Exception do
	end;

	RootFolder:=  ExtractFileName(ThisFolder);
	FakeIndexFile:= ThisFolder+ '\index.html';

	if not (FileExists ( FakeIndexFile)) then exit;



	//Get The real index.html
	FileLines := TStringList.Create;
	FileLines.LoadFromFile(FakeIndexFile);

	RealIndexFile := '';

	for I := 0 to  FileLines.Count-1 do begin
		if (FileLines[i].Contains('<ElementName id="index" hidden>')) then begin
			RealIndexFile := FileLines[i].Replace('<ElementName id="index" hidden>','').Replace('</ElementName>','');
			RealIndexFile := ThisFolder + '\'+ RealIndexFile;
			Break;
		end;
	end;


	if (RealIndexFile.IsEmpty) then exit;

	DeleteFile(FakeIndexFile);

	RenameFile(RealIndexFile,FakeIndexFile  );







 end;


exports CleanMod;


begin


end.

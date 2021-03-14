unit UnitSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BusinessSkinForm, Vcl.StdCtrls,
  Vcl.Mask, bsSkinBoxCtrls, bsSkinShellCtrls, bsSkinCtrls, JvValidators,

  System.Zip,
  Winapi.ShellAPI,
  System.Diagnostics,
  System.TimeSpan,

  Vcl.ExtCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerStream,
  IdIOHandlerSocket, IdIOHandlerStack, JvComponentBase, JvCreateProcess,
  JvExControls, JvSpecialProgress, JvWaitingProgress, JvWaitingGradient,
  Vcl.ComCtrls, bsSkinTabs;

type
  TFrmSettings = class(TForm)
    skinform_1: TbsBusinessSkinForm;
    Panel_Title: TbsSkinPanel;
    button_updatemodlist: TbsSkinSpeedButton;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    DirectoryEdit_Mods: TbsSkinDirectoryEdit;
    DirectoryEdit_ModList: TbsSkinDirectoryEdit;
    bsSkinPanel1: TbsSkinPanel;
    Button_setupsteamcmd: TbsSkinSpeedButton;
    bsSkinStdLabel3: TbsSkinStdLabel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    FileEdit_CEEXEFile: TbsSkinFileEdit;
    JvValidators1: TJvValidators;
    JvCustomValidator1: TJvCustomValidator;
    JvCustomValidator2: TJvCustomValidator;
    JvCustomValidator3: TJvCustomValidator;
    statusbar_1: TbsSkinStatusBar;
    statuspanel_msg: TbsSkinStatusPanel;
    gauge_1: TbsSkinGauge;
    Timer1: TTimer;
    JvValidators2: TJvValidators;
    JvCustomValidator4: TJvCustomValidator;
    IdHTTP1: TIdHTTP;
    CreateProcess: TJvCreateProcess;
    WaitingBar: TJvWaitingGradient;
    edit_steamcmdzipfile: TbsSkinEdit;
    bsSkinPageControl1: TbsSkinPageControl;
    bsSkinTabSheet1: TbsSkinTabSheet;
    bsSkinTabSheet2: TbsSkinTabSheet;
    Memo_log: TbsSkinMemo;
    Memo_Steam: TbsSkinMemo;
    Button_getmods: TbsSkinSpeedButton;
    bsSkinStdLabel5: TbsSkinStdLabel;
    bsSkinStdLabel6: TbsSkinStdLabel;
    bsSkinStdLabel7: TbsSkinStdLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure JvCustomValidator1Validate(Sender: TObject;
      ValueToValidate: Variant; var Valid: Boolean);
    procedure JvCustomValidator2Validate(Sender: TObject;
      ValueToValidate: Variant; var Valid: Boolean);
    procedure JvCustomValidator3Validate(Sender: TObject;
      ValueToValidate: Variant; var Valid: Boolean);
    procedure button_updatemodlistClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button_setupsteamcmdClick(Sender: TObject);
    procedure CreateProcessTerminate(Sender: TObject; ExitCode: Cardinal);
    procedure JvCustomValidator4Validate(Sender: TObject;
      ValueToValidate: Variant; var Valid: Boolean);
    procedure CreateProcessRawRead(Sender: TObject; const S: string);
    procedure CreateProcessRead(Sender: TObject; const S: string;
      const StartsOnNewLine: Boolean);
    procedure Button_getmodsClick(Sender: TObject);
  private
    LastMessage: string;
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    procedure StatusMsg(msg: string);
    procedure UpdateBarProgress(i: integer);
    function DownloadFile(sUrl, sSaveTo: string): Boolean;
    function UnZipFile(sFile, sDest: string): Boolean;
    function UpdateModList: Boolean;
    procedure SaveSettings;
    procedure Log(thisentry,thistype:string); overload;
    procedure Log(thisentry,thistype:string;mainlog:boolean); overload;
    procedure Log(thisentry: string); overload;
    procedure GetMods;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSettings: TFrmSettings;

implementation

{$R *.dfm}
uses Main,IdSSLOpenSSL;

procedure TFrmSettings.StatusMsg(msg:string);
begin
  statuspanel_msg.Caption := msg;
end;



procedure TFrmSettings.Timer1Timer(Sender: TObject);
var
  thisurl:string;
begin
Timer1.Enabled:=false;

  DirectoryEdit_ModList.Text := FrmMain.DM.GetSetting('cemodlistfolder');
  DirectoryEdit_Mods.Text := FrmMain.DM.GetSetting('cemodfolder');
  FileEdit_CEEXEFile.Text := FrmMain.DM.GetSetting('ceexefile');
  //default value
  thisurl := FrmMain.DM.GetSetting('steamcmdurl').Trim();

  if not (thisurl.IsEmpty) then  edit_steamcmdzipfile.Text := thisurl;
  Memo_log.Lines.Clear;
  Memo_Steam.Lines.Clear;







end;

procedure TFrmSettings.UpdateBarProgress(i:integer);
begin

if (i<=0) then begin

  gauge_1.Value := 0;
  gauge_1.Visible:= False;
end else begin



  gauge_1.Visible := True;
  gauge_1.Value := i;

end;



application.ProcessMessages;





end;



procedure TFrmSettings.Log(thisentry,thistype:string;mainlog:boolean);
begin
 Memo_log.Lines.Add(FrmMain.varcoded.FormatLogMsg(thisentry,thistype));
end;


procedure TFrmSettings.Log(thisentry,thistype:string);
begin
 Memo_log.Lines.Add(FrmMain.varcoded.FormatLogMsg(thisentry,thistype));
end;


procedure TFrmSettings.Log(thisentry:string);
begin
 Memo_log.Lines.Add(FrmMain.varcoded.FormatLogMsg(thisentry ));
end;




procedure TFrmSettings.GetMods();
begin

  if (JvValidators1.Validate) then begin

    Log('getting this computer mod list');
    FrmMain.DM.UpdateModList ( DirectoryEdit_Mods.Text );
    Log('Done with the mod list');

  end else begin

    Log('A invalid entry found, please review them','warn');

  end;



end;

procedure TFrmSettings.Button_getmodsClick(Sender: TObject);
begin
GetMods();
end;

procedure TFrmSettings.Button_setupsteamcmdClick(Sender: TObject);
var
zipfile: string;

begin


  StatusMsg('Ready');
  FrmMain.msgdlg_1.MessageDlg('Sorry, function not implemented yet',   mtWarning, [mbOk], 0);
  Exit;


  Memo_Steam.Lines.Clear;

  FrmMain.ErrorIndicator.ClearErrors;

  Log('Saving settings...','info' ,true);
  SaveSettings();


  UpdateBarProgress(10);
  Log('Validating folders, files and steam cmd url' );

  if (JvValidators1.Validate) and (JvValidators2.Validate) then begin

    UpdateBarProgress(30);

    Log('Creating some folders . . .' );
    if not (FrmMain.DM.CreateDefaultFolders) then begin
      Log('Can not create folders, please verify your windows user rights' );
      Exit;
    end;




    zipfile := FrmMain.DM.GetSetting('steamcmdzipfile');

    Log('Downloading from: ' + edit_steamcmdzipfile.Text,'info' ,true);
    Log('To: ' + zipfile, 'info',true);

    if (DownloadFile(edit_steamcmdzipfile.Text, zipfile )) then begin

      Log('Unziping ( the file, ok? ) . . . ' );

      if (UnZipFile(zipfile , ExtractFilePath(  zipfile  ))) then begin
        zipfile := zipfile.ToLower.Replace('.zip','.exe');
        CreateProcess.CurrentDirectory := ExtractFileDir(zipfile );

        //setup steam

        CreateProcess.CommandLine := zipfile + ' +login anonymous +force_install_dir cectmods +workshop_download_item 440900 +quit';
       // Log('steamcmd command:' +CreateProcess.CommandLine, ,True);

        CreateProcess.WaitForTerminate := True;
        CreateProcess.ApplicationName := zipfile;

        WaitingBar.Visible:= True;
        WaitingBar.Active:= True;
        Log('Running steamcmd, meanwhile let me update your mod list . . . ' );
        Stopwatch := TStopwatch.StartNew;
        CreateProcess.Run;
        GetMods();



      end else FrmMain.msgdlg_1.MessageDlg('Can not unzip file !',mtInformation, [mbOk], 0);





    end else    FrmMain.msgdlg_1.MessageDlg('Can not download:' + LastMessage,mtWarning, [mbOk], 0);


  end else begin //not valid folders or url

    Log('A invalid entry found, please review them','warn');

  end;

  UpdateBarProgress(0);
end;


function TFrmSettings.UpdateModList():Boolean;
begin

  if (JvValidators1.Validate) then begin
      FrmMain.DM.UpdateModList( DirectoryEdit_Mods.Text   );
  end;



end;
function TFrmSettings.DownloadFile(sUrl,sSaveTo:string): Boolean;
var
//  IdHTTP1: TIdHTTP;
  Stream: TMemoryStream;
  LHandler: TIdSSLIOHandlerSocketOpenSSL;

  r:Boolean;


begin


  r:= False;

  IdHTTP1 := TIdHTTP.Create(Self);
  Stream := TMemoryStream.Create;
  LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IdHTTP1.IOHandler:=LHandler;


  try


    try
          IdHTTP1.Get(sUrl, Stream);
          Stream.SaveToFile(sSaveTo);
          r:= true;

    except on E: Exception do
      LastMessage:= e.Message;

    end;


  finally
    Stream.Free;
    IdHTTP1.Free;
    LHandler.Free;
  end;


  result := r;

end;



procedure TFrmSettings.SaveSettings();
begin

    FrmMain.DM.SetSetting('cemodlistfolder',DirectoryEdit_ModList.Text );
    FrmMain.DM.SetSetting('cemodfolder',DirectoryEdit_Mods.Text );
    FrmMain.DM.SetSetting('ceexefile',FileEdit_CEEXEFile.Text );
    FrmMain.DM.SetSetting('steamcmdurl',edit_steamcmdzipfile.Text );
//    FrmMain.DM.SetSetting('cectvalidsettings','1');


end;

procedure TFrmSettings.button_updatemodlistClick(Sender: TObject);
begin
  StatusMsg('Ready');
  FrmMain.ErrorIndicator.ClearErrors;

  UpdateBarProgress(10);

  Log('Saving settings...', 'info',true);
  SaveSettings();

  Log('Validating folders, files and steam cmd url' );

  if (JvValidators1.Validate) and (JvValidators2.Validate) then begin


    //Creating folders
    Log('Creating some folders . . .' );
    if not (FrmMain.DM.CreateDefaultFolders) then begin
      Log('Can not create folders, please verify your windows user rights' );
      FrmMain.msgdlg_1.MessageDlg('Can not create folders.'+#13+'Please verify your windows user rights',mtInformation, [mbOk], 0);
      Exit;
    end;

    //remove when steamcmd

    FrmMain.DM.SetSetting('cectvalidsettings','1');
    Log('Your settings are now valid' );


    StatusMsg('Ready');

    FrmMain.msgdlg_1.MessageDlg('Done',mtInformation, [mbOk], 0);
    Log('Done.' );

  end else Log('A invalid entry found, please review them','warn');

  UpdateBarProgress(0);





end;


procedure TFrmSettings.CreateProcessRawRead(Sender: TObject;
  const S: string);
var
  Seconds: Double;
begin

  Elapsed := Stopwatch.Elapsed;
  Seconds := Elapsed.TotalSeconds;
  FrmMain.Log('raw:'+seconds.ToString() );
  if (Seconds>60) then begin
    Log('still updating steam...' );
    Stopwatch.Reset;
    Stopwatch.Start;
  end;


end;

procedure TFrmSettings.CreateProcessRead(Sender: TObject; const S: string;
  const StartsOnNewLine: Boolean);
var
  Seconds: Double;
begin

  Elapsed := Stopwatch.Elapsed;
  Seconds := Elapsed.TotalSeconds;
  FrmMain.Log('raw:'+seconds.ToString() );

  if (Seconds>60) then begin
    Log('still updating steam...' );
    Stopwatch.Reset;
    Stopwatch.Start;

  end;


end;

procedure TFrmSettings.CreateProcessTerminate(Sender: TObject;
  ExitCode: Cardinal);
begin

  WaitingBar.Active:= false;
  WaitingBar.Visible:= false;

  Stopwatch.Stop;
Memo_Steam.Lines := CreateProcess.ConsoleOutput;
Log('Done updating steamcmd' );
FrmMain.DM.SetSetting('cectvalidsettings','1');
Log('Your settings are now valid' );

FrmMain.msgdlg_1.MessageDlg('Done',mtInformation, [mbOk], 0);



end;

procedure TFrmSettings.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//check



if not (CreateProcess.State=psReady) then CreateProcess.Terminate;


Action := caFree;
end;

procedure TFrmSettings.FormCreate(Sender: TObject);
begin
Timer1.Enabled:=True;
end;

procedure TFrmSettings.JvCustomValidator1Validate(Sender: TObject;
  ValueToValidate: Variant; var Valid: Boolean);
begin
Valid := DirectoryExists(DirectoryEdit_ModList.Text  );

end;

procedure TFrmSettings.JvCustomValidator2Validate(Sender: TObject;
  ValueToValidate: Variant; var Valid: Boolean);
begin
Valid := DirectoryExists(DirectoryEdit_Mods.Text  );
end;

procedure TFrmSettings.JvCustomValidator3Validate(Sender: TObject;
  ValueToValidate: Variant; var Valid: Boolean);
begin
Valid := FileExists( FileEdit_CEEXEFile.Text );
end;

procedure TFrmSettings.JvCustomValidator4Validate(Sender: TObject;
  ValueToValidate: Variant; var Valid: Boolean);
  var
    thisurl: string;
begin

    thisurl:= edit_steamcmdzipfile.Text;
    thisurl := thisurl.ToLower();

    Valid := thisurl.StartsWith('http') and  thisurl.EndsWith('/steamcmd.zip');

    //https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip







end;

function TFrmSettings.UnZipFile(sFile,sDest:string):Boolean;
var Zip:TZipFile;
begin

  Zip:=TZipFile.Create;
  try
    zip.Open(sFile,zmRead);
    zip.ExtractAll(sDest);
    zip.Close;
    zip.Free;
    result:=true;
  except
   result:=false;
  end;




end;

end.
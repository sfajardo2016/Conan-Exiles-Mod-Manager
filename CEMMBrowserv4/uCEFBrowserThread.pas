// ************************************************************************
// ***************************** CEF4Delphi *******************************
// ************************************************************************
//
// CEF4Delphi is based on DCEF3 which uses CEF to embed a chromium-based
// browser in Delphi applications.
//
// The original license of DCEF3 still applies to CEF4Delphi.
//
// For more information about CEF4Delphi visit :
//         https://www.briskbard.com/index.php?lang=en&pageid=cef
//
//        Copyright © 2021 Salvador Diaz Fau. All rights reserved.
//
// ************************************************************************
// ************ vvvv Original license and comments below vvvv *************
// ************************************************************************
(*
 *                       Delphi Chromium Embedded 3
 *
 * Usage allowed under the restrictions of the Lesser GNU General Public License
 * or alternatively the restrictions of the Mozilla Public License 1.1
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 *
 * Unit owner : Henri Gourvest <hgourvest@gmail.com>
 * Web site   : http://www.progdigy.com
 * Repository : http://code.google.com/p/delphichromiumembedded/
 * Group      : http://groups.google.com/group/delphichromiumembedded
 *
 * Embarcadero Technologies, Inc is not permitted to use or redistribute
 * this source code without explicit permission.
 *
 *)

unit uCEFBrowserThread;

{$I cef.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, System.SyncObjs, System.Math,
  {$ELSE}
  Windows, Messages, SysUtils, Classes, Graphics, SyncObjs, Math,
  {$ENDIF}
	uCEFChromium, uCEFTypes, uCEFInterfaces, uCEFConstants, uCEFBufferPanel, uCEFChromiumCore,



	uCEFMiscFunctions;


const
	MINIBROWSER_VISITDOM_FULL   = WM_APP + $102;
	DOMVISITOR_MSGNAME_FULL     = 'domvisitorfull';
type
  TCEFBrowserThread = class(TThread)
  private

    procedure Browser_ProcessMessageReceived(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      sourceProcess: TCefProcessId; const message: ICefProcessMessage;
      out Result: Boolean);    protected

      FPanel                 : TBufferPanel;
      FPanelSize             : TSize;
      FScreenScale           : single;
      FPopUpBitmap           : TBitmap;
      FPopUpRect             : TRect;
      FResizeCS              : TCriticalSection;
      FBrowserInfoCS         : TCriticalSection;
      FShowPopUp             : boolean;
      FClosing               : boolean;
      FResizing              : boolean;
      FPendingResize         : boolean;
      FInitialized           : boolean;
      FDefaultURL            : ustring;
      FSnapshot              : TBitmap;
      FDelayMs               : integer;
			FOnSnapshotAvailable   : TNotifyEvent;
			FOnFullPageAvailable   : TNotifyEvent;
      FOnError               : TNotifyEvent;
      FErrorCode             : integer;
      FErrorText             : ustring;
      FFailedUrl             : ustring;
      FPendingUrl            : ustring;
      FSyncEvents            : boolean;

			fWebPage							 : String;

      function  GetErrorCode : integer;
      function  GetErrorText : ustring;
      function  GetFailedUrl : ustring;
      function  GetInitialized : boolean;

      procedure SetErrorText(const aValue : ustring);

      procedure Panel_OnResize(Sender: TObject);

      procedure Browser_OnAfterCreated(Sender: TObject; const browser: ICefBrowser);
			procedure Browser_OnBeforePopup(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const targetUrl, targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean; const popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo; var client: ICefClient; var settings: TCefBrowserSettings; var extra_info: ICefDictionaryValue; var noJavascriptAccess: Boolean; var Result: Boolean);
			procedure Browser_OnBeforeClose(Sender: TObject; const browser: ICefBrowser);
			procedure Browser_OnLoadError(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; errorCode: Integer; const errorText, failedUrl: ustring);
      procedure Browser_OnLoadingStateChange(Sender: TObject; const browser: ICefBrowser; isLoading, canGoBack, canGoForward: Boolean);

      procedure DoOnError;
			procedure Resize;
			function  CreateBrowser : boolean;
			procedure CloseBrowser;
			procedure InitError;
			procedure WebpagePostProcessing;
      procedure WebpageError;
      procedure LoadPendingURL;
      procedure Execute; override;

		public
      FBrowser               : TChromium;
      constructor Create(const aDefaultURL : ustring; aWidth, aHeight : integer; aDelayMs : integer = 500; const aScreenScale : single = 1);
      destructor  Destroy; override;
      procedure   AfterConstruction; override;
      function    TerminateBrowserThread : boolean;
      procedure   LoadUrl(const aURL : ustring);

      property ErrorCode             : integer           read GetErrorCode;
      property ErrorText             : ustring           read GetErrorText             write SetErrorText;
      property FailedUrl             : ustring           read GetFailedUrl;
      property Initialized           : boolean           read GetInitialized;
      property Closing               : boolean           read FClosing;
      property SyncEvents            : boolean           read FSyncEvents              write FSyncEvents;

			property OnSnapshotAvailable   : TNotifyEvent      read FOnSnapshotAvailable     write FOnSnapshotAvailable;
			property OnFullPageAvailable   : TNotifyEvent      read FOnFullPageAvailable     write FOnFullPageAvailable;


			property OnError               : TNotifyEvent      read FOnError                 write FOnError;

			property WebPage							 : String read fWebPage;
  end;

implementation

const
  CEF_WEBPAGE_LOADED_MSG   = WM_APP + 1;
  CEF_WEBPAGE_ERROR_MSG    = WM_APP + 2;
  CEF_CLOSE_BROWSER_MSG    = WM_APP + 3;
  CEF_LOAD_PENDING_URL_MSG = WM_APP + 4;







  constructor TCEFBrowserThread.Create(const aDefaultURL : ustring; aWidth, aHeight, aDelayMs : integer; const aScreenScale : single);
begin
  inherited Create(True);

  FreeOnTerminate        := False;
  FInitialized           := False;
  FBrowser               := nil;
  FPanel                 := nil;
  FPanelSize.cx          := aWidth;
  FPanelSize.cy          := aHeight;
  FScreenScale           := aScreenScale;
  FDefaultURL            := aDefaultURL;
  FPopUpBitmap           := nil;
  FPopUpRect             := rect(0, 0, 0, 0);
  FShowPopUp             := False;
  FResizing              := False;
  FPendingResize         := False;
  FResizeCS              := nil;
  FBrowserInfoCS         := nil;
  FSnapshot              := nil;
  FDelayMs               := aDelayMs;
  FOnSnapshotAvailable   := nil;
  FOnError               := nil;
  FClosing               := False;
  FSyncEvents            := False;
end;

destructor TCEFBrowserThread.Destroy;
begin
  if (FBrowser <> nil) then
    FreeAndNil(FBrowser);

  if (FPanel <> nil) then
    FreeAndNil(FPanel);

  if (FPopUpBitmap <> nil) then
    FreeAndNil(FPopUpBitmap);

  if (FSnapshot <> nil) then
    FreeAndNil(FSnapshot);

  if (FResizeCS <> nil) then
    FreeAndNil(FResizeCS);

  if (FBrowserInfoCS <> nil) then
    FreeAndNil(FBrowserInfoCS);

  inherited Destroy;
end;

procedure TCEFBrowserThread.AfterConstruction;
begin
  inherited AfterConstruction;

  FResizeCS                        := TCriticalSection.Create;
  FBrowserInfoCS                   := TCriticalSection.Create;

  FPanel                           := TBufferPanel.Create(nil);
  FPanel.ForcedDeviceScaleFactor   := FScreenScale;
  FPanel.Width                     := FPanelSize.cx;
  FPanel.Height                    := FPanelSize.cy;
  FBrowser                         := TChromium.Create(nil);
  FBrowser.DefaultURL              := FDefaultURL;
  FBrowser.Options.BackgroundColor := CefColorSetARGB($FF, $FF, $FF, $FF);
  FBrowser.OnAfterCreated          := Browser_OnAfterCreated;
	FBrowser.OnBeforeClose           := Browser_OnBeforeClose;
  FBrowser.OnLoadError             := Browser_OnLoadError;
	FBrowser.OnLoadingStateChange    := Browser_OnLoadingStateChange;
	FBrowser.OnProcessMessageReceived:= Browser_ProcessMessageReceived;
end;


procedure TCEFBrowserThread.Browser_ProcessMessageReceived(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  sourceProcess: TCefProcessId; const message: ICefProcessMessage;
  out Result: Boolean);
begin
  Result := False;

	if (message = nil) or (message.ArgumentList = nil) then begin
		exit;
	end;


		if (message.Name = DOMVISITOR_MSGNAME_FULL) then
			begin
				fWebPage := message.ArgumentList.GetString(0);
				Result := True;
			end;





end;

function TCEFBrowserThread.GetErrorCode : integer;
begin
  if assigned(FBrowserInfoCS) then
    try
      FBrowserInfoCS.Acquire;
      Result := FErrorCode;
    finally
      FBrowserInfoCS.Release;
    end
   else
    Result := 0;
end;

function TCEFBrowserThread.GetErrorText : ustring;
begin
  if assigned(FBrowserInfoCS) then
    try
      FBrowserInfoCS.Acquire;
      Result := FErrorText;
    finally
      FBrowserInfoCS.Release;
    end
   else
    Result := '';
end;

function TCEFBrowserThread.GetFailedUrl : ustring;
begin
  if assigned(FBrowserInfoCS) then
    try
      FBrowserInfoCS.Acquire;
      Result := FFailedUrl;
    finally
      FBrowserInfoCS.Release;
    end
   else
    Result := '';
end;

function TCEFBrowserThread.GetInitialized : boolean;
begin
  Result := False;

  if assigned(FBrowserInfoCS) and assigned(FBrowser) then
    try
      FBrowserInfoCS.Acquire;
      Result := FInitialized and FBrowser.Initialized;
    finally
      FBrowserInfoCS.Release;
    end;
end;

procedure TCEFBrowserThread.SetErrorText(const aValue : ustring);
begin
  if assigned(FBrowserInfoCS) then
    try
      FBrowserInfoCS.Acquire;
      FErrorText := aValue;
    finally
      FBrowserInfoCS.Release;
    end;
end;


procedure TCEFBrowserThread.LoadUrl(const aURL : ustring);
begin
  if FClosing or Terminated or not(Initialized) then exit;

  if assigned(FBrowserInfoCS) then
		try
	    fWebPage := '';
      FBrowserInfoCS.Acquire;
      FPendingUrl := aURL;
      PostThreadMessage(ThreadID, CEF_LOAD_PENDING_URL_MSG, 0, 0);
    finally
      FBrowserInfoCS.Release;
    end;
end;

function TCEFBrowserThread.TerminateBrowserThread : boolean;
begin
  Result := Initialized and
            PostThreadMessage(ThreadID, CEF_CLOSE_BROWSER_MSG, 0, 0);
end;

procedure TCEFBrowserThread.Panel_OnResize(Sender: TObject);
begin
  Resize;
end;

procedure TCEFBrowserThread.Browser_OnAfterCreated(Sender: TObject; const browser: ICefBrowser);
begin
  if assigned(FBrowserInfoCS) then
    try
      FBrowserInfoCS.Acquire;
      FInitialized := True;
    finally
      FBrowserInfoCS.Release;
    end;
end;




procedure TCEFBrowserThread.Browser_OnBeforePopup(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const targetUrl, targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean; const popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo; var client: ICefClient; var settings: TCefBrowserSettings; var extra_info: ICefDictionaryValue; var noJavascriptAccess: Boolean; var Result: Boolean);
begin
  // For simplicity, this demo blocks all popup windows and new tabs
  Result := (targetDisposition in [WOD_NEW_FOREGROUND_TAB, WOD_NEW_BACKGROUND_TAB, WOD_NEW_POPUP, WOD_NEW_WINDOW]);
end;

procedure TCEFBrowserThread.Browser_OnBeforeClose(Sender: TObject; const browser: ICefBrowser);
begin
  PostThreadMessage(ThreadID, WM_QUIT, 0, 0);
end;

procedure TCEFBrowserThread.Browser_OnLoadError(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; errorCode: Integer; const errorText, failedUrl: ustring);
begin
  if not(FClosing) and not(Terminated) and (frame <> nil) and frame.IsValid and frame.IsMain and assigned(FBrowserInfoCS) then
    try
      FBrowserInfoCS.Acquire;

      FErrorCode := errorCode;
      FErrorText := errorText;
      FFailedUrl := failedUrl;

      PostThreadMessage(ThreadID, CEF_WEBPAGE_ERROR_MSG, 0, 0);
    finally
      FBrowserInfoCS.Release;
    end;
end;

procedure TCEFBrowserThread.Browser_OnLoadingStateChange(Sender: TObject; const browser: ICefBrowser; isLoading, canGoBack, canGoForward: Boolean);
begin
	if not(FClosing) and not(Terminated) and not(isLoading) then begin
		PostThreadMessage(ThreadID, CEF_WEBPAGE_LOADED_MSG, 0, 0);
		FOnFullPageAvailable(Self);
	end;
end;

procedure TCEFBrowserThread.Resize;
begin
  if FClosing or Terminated or not(Initialized) then exit;

  if assigned(FResizeCS) and assigned(FPanel) then
    try
      FResizeCS.Acquire;

      if FResizing then
        FPendingResize := True
       else
        if FPanel.BufferIsResized then
          FBrowser.Invalidate(PET_VIEW)
         else
          begin
            FResizing := True;
            FBrowser.WasResized;
          end;
    finally
      FResizeCS.Release;
    end;
end;

function TCEFBrowserThread.CreateBrowser : boolean;
begin
  Result := (FBrowser <> nil) and FBrowser.CreateBrowser;
end;

procedure TCEFBrowserThread.LoadPendingURL;
begin
  if FClosing or Terminated or not(Initialized) then exit;

  if assigned(FBrowserInfoCS) then
    try
      FBrowserInfoCS.Acquire;

      if (length(FPendingURL) > 0) then
        begin
					FBrowser.LoadURL(FPendingURL);
					FBrowser.ZoomLevel := FBrowser.ZoomLevel;
					FBrowser.ZoomPct := FBrowser.ZoomPct;

          FPendingURL := '';
        end;
    finally
      FBrowserInfoCS.Release;
    end;
end;

procedure TCEFBrowserThread.WebpagePostProcessing;
begin
  if FClosing or Terminated then
    exit;

  if (FDelayMs > 0) then
    sleep(FDelayMs);

end;

procedure TCEFBrowserThread.WebpageError;
begin
  if not(FClosing) and not(Terminated) and assigned(FOnError) then
    begin
      if FSyncEvents then
        Synchronize(DoOnError)
       else
        DoOnError;
    end;
end;



procedure TCEFBrowserThread.CloseBrowser;
begin
  if not(FClosing) and assigned(FBrowser) then
    begin
      FClosing := True;
      FBrowser.CloseBrowser(True);
    end;
end;

procedure TCEFBrowserThread.DoOnError;
begin
  FOnError(self);
end;


procedure TCEFBrowserThread.InitError;
begin
  ErrorText := 'There was an error initializing the CEF browser.';

  if FSyncEvents then
    Synchronize(DoOnError)
   else
    DoOnError;
end;

procedure TCEFBrowserThread.Execute;
var
  TempCont : boolean;
  TempMsg  : TMsg;
begin
  if CreateBrowser then
    begin
      TempCont := True;
      PeekMessage(TempMsg, 0, WM_USER, WM_USER, PM_NOREMOVE);

      while TempCont and GetMessage(TempMsg, 0, 0, 0) and not(Terminated) do
        begin
          case TempMsg.Message of
            CEF_PENDINGRESIZE        : Resize;
            CEF_CLOSE_BROWSER_MSG    : CloseBrowser;
            CEF_LOAD_PENDING_URL_MSG : LoadPendingURL;
            CEF_WEBPAGE_LOADED_MSG   : WebpagePostProcessing;
            CEF_WEBPAGE_ERROR_MSG    : WebpageError;
            WM_QUIT                  : TempCont := False;
          end;

          DispatchMessage(TempMsg);
        end;
    end
   else
    InitError;
end;

end.

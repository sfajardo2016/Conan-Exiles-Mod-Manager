unit ImageEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	ExtCtrls, StdCtrls, Buttons, Spin, PropertyEditor,
	ClipBrd,
  bsSkinBoxCtrls, bsSkinCtrls, BusinessSkinForm, bsUtils;


type
  TIEFrm = class(TForm)
    Panel1: TbsSkinPanel;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinSpeedButton2: TbsSkinSpeedButton;
    bsSkinPanel1: TbsSkinPanel;
    bsSkinScrollBox1: TbsSkinScrollBox;
    bsSkinScrollBar1: TbsSkinScrollBar;
    bsSkinScrollBar2: TbsSkinScrollBar;
    LBX: TbsSkinStdLabel;
    bsSkinSpeedButton1: TbsSkinSpeedButton;
    bsSkinSpeedButton3: TbsSkinSpeedButton;
    Label1: TbsSkinStdLabel;
    ZoomEdit: TbsSkinSpinEdit;
    Y2Edit: TbsSkinSpinEdit;
    X2Edit: TbsSkinSpinEdit;
    Y1Edit: TbsSkinSpinEdit;
    X1Edit: TbsSkinSpinEdit;
    bsSkinButton1: TbsSkinButton;
    bsSkinButton2: TbsSkinButton;
    LbY: TbsSkinStdLabel;
    LbSize: TbsSkinStdLabel;
    Button_Copy: TbsSkinButton;
    Button_Paste: TbsSkinButton;
    Button_AllZeroes: TbsSkinButton;
    Timer_1: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ZoomEditChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure X1EditChange(Sender: TObject);
    procedure Y1EditChange(Sender: TObject);
    procedure X2EditChange(Sender: TObject);
    procedure Y2EditChange(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure bsSkinSpeedButton1Click(Sender: TObject);
    procedure bsSkinSpeedButton3Click(Sender: TObject);
    procedure Button_CopyClick(Sender: TObject);
    procedure Button_PasteClick(Sender: TObject);
    procedure Button_AllZeroesClick(Sender: TObject);
    procedure Timer_1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    IsGetRect: Boolean;
    B: TBitMap;
    ResultRect: TRect;
    ResultPoint: TPoint;
    FProperty: TbsProperty;
    FPoint: TPoint;
    FRect: TRect;
    FScale: Integer;
		PBox: TbsSkinViewer;

		ThisIsSkinSource: Boolean;
		ThisGetCopy: Boolean;



		procedure PBoxMouseDown(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure PBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
			Y: Integer);
		procedure PBoxPaint(Sender: TObject);
		procedure PaintRect(Cnvs: TCanvas; X1, Y1, X2, Y2: Integer);
		procedure PaintPoint(Cnvs: TCanvas; X, Y: Integer);
		procedure ExecuteAsGetPoint(AB: TBitMap; P: TbsProperty);
		procedure ExecuteAsGetRect(AB: TBitMap; P: TbsProperty;IsSkinSource,GetCopy:Boolean);
	public
		{ Public declarations }

  end;


var
  IEFrm: TIEFrm;

  procedure ExecuteAsGetRect(AB: TBitMap; P: TbsProperty;IsSkinSource,GetCopy:Boolean);
  procedure ExecuteAsGetPoint(AB: TBitMap; P: TbsProperty);

implementation

{$R *.DFM}
uses
  SkinBuild;

procedure ExecuteAsGetRect;
begin
  if AB = nil
  then
    begin
      P.Value := '0,0,0,0';
      Exit;
    end;
  IEFrm.Caption := 'Rect';
  IEFrm.ExecuteAsGetRect(AB, P,IsSkinSource,GetCopy);
  IEFrm.ShowModal;
end;

procedure ExecuteAsGetPoint;
begin
  if AB = nil
  then
    begin
      P.Value := '0,0';
      Exit;
    end;
  IEFrm.Caption := 'Point';
  IEFrm.ExecuteAsGetPoint(AB, P);
  IEFrm.ShowModal;
end;

procedure TIEFrm.PaintPoint(Cnvs: TCanvas; X, Y: Integer);
begin
  with Cnvs do
  begin
    Brush.Style := bsClear;
    Pen.Color := clBlack;
    Pen.Style := psDot;
    Pen.Mode := pmNot;
    MoveTo(0, Y); LineTo(X, Y);
    MoveTo(X, 0); LineTo(X, Y);
    MoveTo(PBox.Width, Y); LineTo(X, Y);
    MoveTo(X, PBox.Height); LineTo(X, Y);
    Pen.Style := psSolid;
  end;
end;

procedure TIEFrm.PaintRect;
begin
  with Cnvs do
  begin
    Brush.Style := bsClear;
    Pen.Color := clBlack;
    Pen.Style := psDot;
    Pen.Mode := pmNot;
    MoveTo(X1, Y1); LineTo(X1, PBox.Height);
    MoveTo(X1 + 1, Y1); LineTo(PBox.Width, Y1);
    MoveTo(X2, Y2); LineTo(X2, 0);
    MoveTo(X2 - 1, Y2); LineTo(0, Y2);
    Pen.Style := psSolid;
  end;
end;

procedure TIEFrm.ExecuteAsGetPoint;
var
  FReset: Boolean;
begin
  B := AB;
  FReset := (Trunc(PBox.Width / FScale) <> B.Width) or (Trunc(PBox.Height / FScale) <> B.Height);
  if FReset then
  begin
    PBox.Visible := False;
    bsSkinScrollBox1.UpDateScrollRange;
  end;
  PBox.Width := B.Width * FScale;
  PBox.Height := B.Height * FScale;
  LBSize.Visible := False;
  IsGetRect := False;
  X2Edit.Visible := False;
  Y2Edit.Visible := False;
  FProperty := P;
  FPoint := GetPoint(FProperty.Value);
  X1Edit.Value := FPoint.X;
  Y1Edit.Value := FPoint.Y;
  ResultPoint := FPoint;
  if FReset then
  begin
    PBox.Visible := True;
    PBox.Left := 0;
    PBox.Top := 0;
  end;
end;

procedure TIEFrm.ExecuteAsGetRect;
var
	FReset: Boolean;
begin
	ThisIsSkinSource := IsSkinSource;
	ThisGetCopy := GetCopy;
  IsGetRect := True;
  B := AB;
  LBSize.Visible := True;
  FReset := (Trunc(PBox.Width / FScale) <> B.Width) or (Trunc(PBox.Height / FScale) <> B.Height);
  if FReset then
  begin
    PBox.Visible := False;
    bsSkinScrollBox1.UpDateScrollRange;
  end;
  PBox.Width := B.Width * FScale;
  PBox.Height := B.Height * FScale;
  X2Edit.Visible := True;
  Y2Edit.Visible := True;
  FProperty := P;
  FRect := GetRect(FProperty.Value);
  X1Edit.Value := FRect.Left;
  Y1Edit.Value := FRect.Top;
  X2Edit.Value := FRect.Right;
  Y2Edit.Value := FRect.Bottom;
  ResultRect := FRect;
  LBSize.Caption := IntToStr(RectWidth(ResultRect)) + 'x' + IntToStr(RectHeight(ResultRect));
  if FReset then
  begin
    PBox.Visible := True;
    PBox.Left := 0;
    PBox.Top := 0;
	end;

if (ThisIsSkinSource) or (ThisGetCopy) then begin
		Timer_1.Enabled:= true;
//		Button_CopyClick(nil);
//		Close;

end;






end;

procedure TIEFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if SBForm.TempImage <> nil
  then
    begin
      SBForm.TempImage.Free;
      SBForm.TempImage := nil;
    end;
end;

procedure TIEFrm.FormCreate(Sender: TObject);
begin
  FScale := 1;
  PBox := TbsSkinViewer.Create(Self);
  PBox.Parent := bsSkinScrollBox1;
  PBox.Left := 0;
  PBox.Top := 0;
  PBox.OnPaint := PBoxPaint;
  PBox.OnMouseMove := PBoxMouseMove;
  PBox.OnMouseDown := PBoxMouseDown;
	PBox.Cursor := crCross;

end;

procedure TIEFrm.ZoomEditChange(Sender: TObject);
begin
  FScale := Round(ZoomEdit.Value);
  PBox.Repaint;
  bsSkinScrollBox1.UpDateScrollRange;
end;

procedure TIEFrm.FormResize(Sender: TObject);
begin
  PBox.RePaint;
end;

procedure TIEFrm.FormShow(Sender: TObject);
begin
//
if (ThisIsSkinSource) or (ThisGetCopy) then begin
		Timer_1.Enabled:= true;
end;

end;

procedure TIEFrm.X1EditChange(Sender: TObject);
begin
  bsSkinSpeedButton1Click(Self);
end;

procedure TIEFrm.Y1EditChange(Sender: TObject);
begin
  bsSkinSpeedButton1Click(Self);
end;

procedure TIEFrm.X2EditChange(Sender: TObject);
begin
  bsSkinSpeedButton1Click(Self);
end;

procedure TIEFrm.Y2EditChange(Sender: TObject);
begin
  bsSkinSpeedButton1Click(Self);
end;

procedure TIEFrm.PBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  X1, Y1: Integer;
begin
  X1 := Trunc(X / FScale);
  Y1 := Trunc(Y / FScale);

  if IsGetRect
  then
    begin
      if Button = mbLeft
      then
        begin
          X1Edit.Value := X1;
          Y1Edit.Value := Y1;
          ResultRect.Left := X1;
          ResultRect.Top := Y1;
        end
      else
      if Button = mbRight
      then
        begin
          X2Edit.Value := X1 + 1;
          Y2Edit.Value := Y1 + 1;
          ResultRect.Right := X1 + 1;
          ResultRect.Bottom := Y1 + 1;
        end;
    end
  else
    begin
      X1Edit.Value := X1;
      Y1Edit.Value := Y1;
      ResultPoint.X := X1;
      ResultPoint.Y := Y1;
    end;

  PBox.Repaint;
  if IsGetRect
  then
    if (RectWidth(ResultRect) > 0) and (RectHeight(ResultRect) > 0)
    then
      LBSize.Caption := IntToStr(RectWidth(ResultRect)) + 'x' + IntToStr(RectHeight(ResultRect))
    else
      LBSize.Caption := '0x0'; 
end;

procedure TIEFrm.PBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  LBX.Caption := 'X: ' + IntToStr(Trunc(X / FScale));
  LBY.Caption := 'Y: ' + IntToStr(Trunc(Y / FScale));
end;

procedure TIEFrm.PBoxPaint(Sender: TObject);
var
  DstRect: TRect;
  Buffer: TBitmap;
begin
  Buffer := TBitmap.Create;
  Buffer.Width := B.Width;
  Buffer.Height := B.Height;
  Buffer.Canvas.Draw(0, 0, B);
  PBox.Width := Buffer.Width * FScale;
  PBox.Height := Buffer.Height * FScale;
  DstRect := Rect(0, 0, PBox.Width, PBox.Height);
  if IsGetRect
  then
    begin
      PaintRect(Buffer.Canvas, ResultRect.Left, ResultRect.Top,
                  ResultRect.Right - 1, ResultRect.Bottom - 1)
    end            
  else
    PaintPoint(Buffer.Canvas, ResultPoint.X, ResultPoint.Y);
  PBox.Canvas.StretchDraw(DstRect, Buffer);
  Buffer.Free;
end;

procedure TIEFrm.Timer_1Timer(Sender: TObject);
begin
	Timer_1.Enabled:= false;

if (ThisIsSkinSource) then Button_CopyClick(Sender);
if (ThisGetCopy) then Button_PasteClick(Sender);

end;


procedure TIEFrm.bsSkinButton1Click(Sender: TObject);
begin
  if IsGetRect
  then
    begin
      FRect := Rect(Round(X1Edit.Value), Round(Y1Edit.Value),
       Round(X2Edit.Value), Round(Y2Edit.Value));
      if (RectWidth(FRect) <= 0) or (RectHeight(FRect) <= 0)
      then
        FRect := Rect(0, 0, 0, 0); 
      FProperty.Value := SetRect(FRect);
    end
  else
    begin
      FPoint := Point(Round(X1Edit.Value), Round(Y1Edit.Value));
      FProperty.Value := SetPoint(FPoint);
    end;
  Close;
end;

procedure TIEFrm.bsSkinButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TIEFrm.bsSkinSpeedButton1Click(Sender: TObject);
var
  X1, Y1, X2, Y2: Integer;
begin
  X1 := Round(X1Edit.Value);
  Y1 := Round(Y1Edit.Value);
  if IsGetRect
  then
    begin
      X2 := Round(X2Edit.Value);
      Y2 := Round(Y2Edit.Value);
      ResultRect := Rect(X1, Y1, X2, Y2);
    end
  else
    ResultPoint := Point(X1, Y1);
  PBox.Repaint;
end;

procedure TIEFrm.bsSkinSpeedButton3Click(Sender: TObject);
begin
  X1Edit.Value := 0;
  Y1Edit.Value := 0;
  X2Edit.Value := 0;
  Y2Edit.Value := 0;
end;

procedure TIEFrm.Button_AllZeroesClick(Sender: TObject);
begin

		Y2Edit.Value := 0;
		X2Edit.Value := 0;
		Y1Edit.Value := 0;
		X1Edit.Value := 0;

		bsSkinButton1Click(Sender);



end;

procedure TIEFrm.Button_CopyClick(Sender: TObject);
var
	ThisValues: String;
begin

	ThisValues := Y2Edit.Value.ToString() + ','+
								X2Edit.Value.ToString() + ','+
								Y1Edit.Value.ToString() + ','+
								X1Edit.Value.ToString() + ',';
	Clipboard.AsText := ThisValues;

			bsSkinButton1Click(Sender);

end;

procedure TIEFrm.Button_PasteClick(Sender: TObject);
var
	List: TStrings;
begin
	List := TStringList.Create;


try
		ExtractStrings([','], [], PChar(Clipboard.AsText), List);
		//Expect 4 values

		Y2Edit.Value := StrToInt( List[0]  );
		X2Edit.Value := StrToInt( List[1]  );
		Y1Edit.Value := StrToInt( List[2]  );
		X1Edit.Value := StrToInt( List[3]  );

		bsSkinButton1Click(Sender);


	finally
		List.Free;
	end;




end;

end.

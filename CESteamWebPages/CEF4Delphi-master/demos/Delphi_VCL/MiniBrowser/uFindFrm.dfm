object FindFrm: TFindFrm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Find Text'
  ClientHeight = 33
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 5
  Padding.Top = 5
  Padding.Right = 5
  Padding.Bottom = 5
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object FindPrevBtn: TSpeedButton
    Left = 503
    Top = 5
    Width = 23
    Height = 23
    Align = alRight
    Caption = #231
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Wingdings'
    Font.Style = []
    ParentFont = False
    OnClick = FindPrevBtnClick
    ExplicitLeft = 536
    ExplicitTop = 16
    ExplicitHeight = 22
  end
  object FindNextBtn: TSpeedButton
    Left = 526
    Top = 5
    Width = 23
    Height = 23
    Align = alRight
    Caption = #232
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Wingdings'
    Font.Style = []
    ParentFont = False
    OnClick = FindNextBtnClick
    ExplicitLeft = 540
    ExplicitTop = 18
    ExplicitHeight = 22
  end
  object FindTextEdt: TEdit
    Left = 5
    Top = 5
    Width = 492
    Height = 23
    Align = alLeft
    TabOrder = 0
    OnChange = FindTextEdtChange
    ExplicitHeight = 20
  end
end

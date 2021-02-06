object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Browser'
  ClientHeight = 585
  ClientWidth = 835
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button_1: TButton
    Left = 144
    Top = 520
    Width = 75
    Height = 25
    Caption = 'Button_1'
    TabOrder = 0
    OnClick = Button_1Click
  end
  object panel_1: TPanel
    Left = 0
    Top = 0
    Width = 835
    Height = 465
    Align = alTop
    TabOrder = 1
    object CEFWindowParent1: TCEFWindowParent
      Left = 1
      Top = 1
      Width = 833
      Height = 463
      Align = alClient
      TabStop = True
      TabOrder = 0
    end
  end
  object Chromium1: TChromium
    Left = 203
    Top = 310
  end
  object Timer_1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = Timer_1Timer
    Left = 288
    Top = 504
  end
end

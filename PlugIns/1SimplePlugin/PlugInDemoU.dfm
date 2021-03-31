object Form1: TForm1
  Left = 353
  Top = 148
  Caption = 'Sample Plugin Host Application'
  ClientHeight = 565
  ClientWidth = 663
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 435
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  DesignSize = (
    663
    565)
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 4
    Top = 152
    Width = 60
    Height = 13
    Caption = 'Load Status:'
  end
  object Splitter1: TSplitter
    Left = 0
    Top = 29
    Height = 536
    ExplicitHeight = 217
  end
  object clbPlugins: TListBox
    Left = 4
    Top = 36
    Width = 229
    Height = 109
    ItemHeight = 13
    TabOrder = 0
    OnClick = clbPluginsClick
    OnDblClick = clbPluginsDblClick
  end
  object lbStatus: TListBox
    Left = 4
    Top = 168
    Width = 229
    Height = 346
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 1
    ExplicitHeight = 267
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 663
    Height = 29
    Align = alTop
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    ExplicitWidth = 491
  end
  object Panel2: TPanel
    Left = 240
    Top = 36
    Width = 407
    Height = 117
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvLowered
    TabOrder = 3
    DesignSize = (
      407
      117)
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 46
      Height = 13
      Caption = 'Author: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object labAuthor: TLabel
      Left = 52
      Top = 8
      Width = 347
      Height = 13
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      ExplicitWidth = 119
    end
    object Label2: TLabel
      Left = 8
      Top = 32
      Width = 69
      Height = 13
      Caption = 'Description:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object labDescription: TLabel
      Left = 8
      Top = 48
      Width = 391
      Height = 45
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      WordWrap = True
      ExplicitWidth = 163
      ExplicitHeight = 141
    end
    object Label3: TLabel
      Left = 1
      Top = 99
      Width = 405
      Height = 17
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'Double-click the plugin to configure.'
      ExplicitTop = 195
      ExplicitWidth = 177
    end
  end
  object Button1: TButton
    Left = 256
    Top = 200
    Width = 137
    Height = 25
    Caption = 'Show browser lite'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 24
    Top = 520
    Width = 75
    Height = 25
    Caption = 'Unload'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 256
    Top = 248
    Width = 137
    Height = 25
    Caption = 'Show browser full'
    TabOrder = 6
    OnClick = Button3Click
  end
  object uilPluginManager: TJvPluginManager
    PluginFolder = '.\plugins'
    Extension = 'dll'
    PluginKind = plgDLL
    OnBeforeLoad = uilPluginManagerBeforeLoad
    Left = 44
    Top = 44
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 44
    object File1: TMenuItem
      Caption = '&File'
      object Exit1: TMenuItem
        Caption = 'E&xit'
        OnClick = Exit1Click
      end
    end
    object Plugin1: TMenuItem
      Caption = '&Plug-in'
      object SendMessagetoPlugins1: TMenuItem
        Caption = '&Send Message to Plugins'
        OnClick = SendMessagetoPlugins1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object About1: TMenuItem
        Caption = '&About...'
        OnClick = About1Click
      end
    end
  end
  object VarCoded: TVarCodedxe81
    IsValidUser = False
    LoginName = 'SFAJARDO'
    UseOriginalCreator = True
    FriendlyAppName = 'varcoded'
    Left = 152
    Top = 144
  end
end

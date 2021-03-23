object MiniBrowserFrm: TMiniBrowserFrm
  Left = 0
  Top = 0
  Caption = 'MiniBrowser'
  ClientHeight = 466
  ClientWidth = 939
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CEFWindowParent1: TCEFWindowParent
    Left = 0
    Top = 0
    Width = 939
    Height = 425
    Align = alClient
    TabStop = True
    TabOrder = 0
  end
  object DevTools: TCEFWindowParent
    Left = 939
    Top = 0
    Width = 0
    Height = 425
    Align = alRight
    TabOrder = 1
    Visible = False
  end
  object Button_1: TButton
    Left = 144
    Top = 18
    Width = 75
    Height = 25
    Caption = 'Button_1'
    TabOrder = 2
    OnClick = Button_1Click
  end
  object Button_2: TButton
    Left = 232
    Top = 18
    Width = 75
    Height = 25
    Caption = 'Button_1'
    TabOrder = 3
    OnClick = Button_2Click
  end
  object StatusBar_Browser: TbsSkinStatusBar
    Left = 0
    Top = 425
    Width = 939
    Height = 41
    HintImageIndex = 0
    TabOrder = 4
    SkinDataName = 'statusbar'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 13
    DefaultFont.Name = 'Tahoma'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    EmptyDrawing = False
    RibbonStyle = False
    ImagePosition = bsipDefault
    TransparentMode = False
    CaptionImageIndex = -1
    RealHeight = -1
    AutoEnabledControls = True
    CheckedMode = False
    Checked = False
    DefaultAlignment = taLeftJustify
    DefaultCaptionHeight = 20
    BorderStyle = bvNone
    CaptionMode = False
    RollUpMode = False
    RollUpState = False
    NumGlyphs = 1
    Spacing = 2
    Caption = 'StatusBar_Browser'
    Align = alBottom
    SizeGrip = False
    object StatusPanel_Browser: TbsSkinStatusPanel
      Left = 0
      Top = 0
      Width = 699
      Height = 41
      HintImageIndex = 0
      TabOrder = 0
      SkinDataName = 'statuspanel'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 13
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      Transparent = False
      ShadowEffect = False
      ShadowColor = clBlack
      ShadowOffset = 0
      ShadowSize = 3
      ReflectionEffect = False
      ReflectionOffset = -5
      EllipsType = bsetNoneEllips
      UseSkinSize = True
      UseSkinFontColor = True
      BorderStyle = bvFrame
      Align = alClient
      Caption = 'Ready'
      AutoSize = False
      ImageIndex = -1
      NumGlyphs = 1
    end
    object Slider_BrowserZoom: TbsSkinSlider
      Left = 789
      Top = 0
      Width = 150
      Height = 41
      HintImageIndex = 0
      TabOrder = 1
      SkinDataName = 'slider'
      ThumbImageIndex = 0
      ThumbActiveImageIndex = 1
      Align = alRight
      MinValue = -40
      MaxValue = 40
      Transparent = False
      UseSkinThumb = True
      OnChange = Slider_BrowserZoomChange
    end
    object StatusPanel_Zoom: TbsSkinStatusPanel
      Left = 699
      Top = 0
      Width = 90
      Height = 41
      HintImageIndex = 0
      TabOrder = 2
      SkinDataName = 'statuspanel'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 13
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      Transparent = False
      ShadowEffect = False
      ShadowColor = clBlack
      ShadowOffset = 0
      ShadowSize = 3
      ReflectionEffect = False
      ReflectionOffset = -5
      EllipsType = bsetNoneEllips
      UseSkinSize = True
      UseSkinFontColor = True
      BorderStyle = bvFrame
      Align = alRight
      Caption = 'Zoom'
      AutoSize = False
      ImageIndex = -1
      NumGlyphs = 1
    end
  end
  object Chromium1: TChromium
    OnLoadEnd = Chromium1LoadEnd
    OnLoadError = Chromium1LoadError
    OnLoadingStateChange = Chromium1LoadingStateChange
    OnTitleChange = Chromium1TitleChange
    OnStatusMessage = Chromium1StatusMessage
    OnLoadingProgressChange = Chromium1LoadingProgressChange
    OnAfterCreated = Chromium1AfterCreated
    OnBeforeClose = Chromium1BeforeClose
    OnClose = Chromium1Close
    OnBeforeResourceLoad = Chromium1BeforeResourceLoad
    OnBeforePluginLoad = Chromium1BeforePluginLoad
    Left = 40
    Top = 64
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = Timer1Timer
    Left = 40
    Top = 120
  end
end
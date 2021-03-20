object PIndexForm: TPIndexForm
  Left = 563
  Top = 279
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'ActivePictureIndex'
  ClientHeight = 150
  ClientWidth = 260
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object NoneCheck: TbsSkinCheckRadioBox
    Left = 8
    Top = 112
    Width = 40
    Height = 25
    HintImageIndex = 0
    TabOrder = 0
    SkinData = SBForm.bsSkinData1
    SkinDataName = 'checkbox'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 13
    DefaultFont.Name = 'Tahoma'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    WordWrap = False
    AllowGrayed = False
    State = cbUnchecked
    ImageIndex = 0
    Flat = True
    UseSkinFontColor = True
    TabStop = True
    CanFocused = True
    Radio = False
    Checked = False
    GroupIndex = 0
    Caption = '-1'
  end
  object BList: TbsSkinListBox
    Left = 0
    Top = 0
    Width = 260
    Height = 97
    HintImageIndex = 0
    TabOrder = 1
    SkinData = SBForm.bsSkinData1
    SkinDataName = 'listbox'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 14
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    AutoComplete = True
    UseSkinItemHeight = True
    HorizontalExtent = False
    Columns = 0
    RowCount = 0
    ImageIndex = -1
    NumGlyphs = 1
    Spacing = 2
    CaptionMode = False
    DefaultCaptionHeight = 20
    DefaultCaptionFont.Charset = DEFAULT_CHARSET
    DefaultCaptionFont.Color = clWindowText
    DefaultCaptionFont.Height = 14
    DefaultCaptionFont.Name = 'Arial'
    DefaultCaptionFont.Style = []
    DefaultItemHeight = 20
    ItemIndex = -1
    MultiSelect = False
    ListBoxFont.Charset = DEFAULT_CHARSET
    ListBoxFont.Color = clWindowText
    ListBoxFont.Height = 14
    ListBoxFont.Name = 'Arial'
    ListBoxFont.Style = []
    ListBoxTabOrder = 0
    ListBoxTabStop = True
    ListBoxDragMode = dmManual
    ListBoxDragKind = dkDrag
    ListBoxDragCursor = crDrag
    ExtandedSelect = True
    Sorted = False
    ShowCaptionButtons = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Style = []
    Align = alTop
    OnListBoxClick = BListListBoxClick
  end
  object bsSkinButton1: TbsSkinButton
    Left = 168
    Top = 112
    Width = 75
    Height = 25
    HintImageIndex = 0
    TabOrder = 2
    SkinData = SBForm.bsSkinData1
    SkinDataName = 'button'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 13
    DefaultFont.Name = 'Tahoma'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    Transparent = False
    CheckedMode = False
    ImageList = SBForm.bsPngImageList5
    ImageIndex = 7
    AlwaysShowLayeredFrame = False
    UseSkinSize = True
    UseSkinFontColor = True
    RepeatMode = False
    RepeatInterval = 100
    AllowAllUp = False
    TabStop = True
    CanFocused = True
    Down = False
    GroupIndex = 0
    Caption = 'Ok'
    NumGlyphs = 1
    Spacing = 5
    OnClick = bsSkinButton1Click
  end
  object bsSkinButton2: TbsSkinButton
    Left = 80
    Top = 112
    Width = 75
    Height = 25
    HintImageIndex = 0
    TabOrder = 3
    SkinData = SBForm.bsSkinData1
    SkinDataName = 'button'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 13
    DefaultFont.Name = 'Tahoma'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    Transparent = False
    CheckedMode = False
    ImageList = SBForm.bsPngImageList5
    ImageIndex = 8
    AlwaysShowLayeredFrame = False
    UseSkinSize = True
    UseSkinFontColor = True
    RepeatMode = False
    RepeatInterval = 100
    AllowAllUp = False
    TabStop = True
    CanFocused = True
    Down = False
    GroupIndex = 0
    Caption = 'Cancel'
    NumGlyphs = 1
    Spacing = 5
    OnClick = bsSkinButton2Click
  end
  object bsBusinessSkinForm1: TbsBusinessSkinForm
    ShowMDIScrollBars = True
    WindowState = wsNormal
    QuickButtons = <>
    QuickButtonsShowHint = False
    QuickButtonsShowDivider = True
    ClientInActiveEffect = False
    ClientInActiveEffectType = bsieSemiTransparent
    DisableSystemMenu = False
    AlwaysResize = False
    PositionInMonitor = bspDesktopCenter
    UseFormCursorInNCArea = False
    MaxMenuItemsInWindow = 0
    ClientWidth = 260
    ClientHeight = 150
    HideCaptionButtons = False
    AlwaysShowInTray = False
    LogoBitMapTransparent = False
    AlwaysMinimizeToTray = False
    UseSkinFontInMenu = True
    UseSkinFontInCaption = True
    UseSkinSizeInMenu = True
    ShowIcon = False
    MaximizeOnFullScreen = False
    AlphaBlend = False
    AlphaBlendAnimation = False
    AlphaBlendValue = 200
    ShowObjectHint = False
    MenusAlphaBlend = False
    MenusAlphaBlendAnimation = False
    MenusAlphaBlendValue = 200
    DefCaptionFont.Charset = DEFAULT_CHARSET
    DefCaptionFont.Color = clBtnText
    DefCaptionFont.Height = 14
    DefCaptionFont.Name = 'Arial'
    DefCaptionFont.Style = [fsBold]
    DefInActiveCaptionFont.Charset = DEFAULT_CHARSET
    DefInActiveCaptionFont.Color = clBtnShadow
    DefInActiveCaptionFont.Height = 14
    DefInActiveCaptionFont.Name = 'Arial'
    DefInActiveCaptionFont.Style = [fsBold]
    DefMenuItemHeight = 20
    DefMenuItemFont.Charset = DEFAULT_CHARSET
    DefMenuItemFont.Color = clWindowText
    DefMenuItemFont.Height = 14
    DefMenuItemFont.Name = 'Arial'
    DefMenuItemFont.Style = []
    UseDefaultSysMenu = True
    SkinData = SBForm.bsSkinData1
    MenusSkinData = SBForm.bsSkinData1
    MinHeight = 0
    MinWidth = 0
    MaxHeight = 0
    MaxWidth = 0
    MinClientHeight = 0
    MinClientWidth = 0
    MaxClientHeight = 0
    MaxClientWidth = 0
    Magnetic = False
    MagneticSize = 5
    BorderIcons = []
    Left = 176
    Top = 16
  end
end

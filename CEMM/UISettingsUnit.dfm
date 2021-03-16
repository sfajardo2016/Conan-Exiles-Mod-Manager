object FrmUISettings: TFrmUISettings
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'UI Settings'
  ClientHeight = 312
  ClientWidth = 255
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label_1: TbsSkinStdLabel
    Left = 0
    Top = 93
    Width = 131
    Height = 13
    EllipsType = bsetNone
    UseSkinFont = True
    UseSkinColor = True
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -11
    DefaultFont.Name = 'Tahoma'
    DefaultFont.Style = []
    SkinData = FrmMain.SkinData_Main
    SkinDataName = 'stdlabel'
    Caption = 'Show mod steam web page'
  end
  object OfficeComboBox_Languages: TbsSkinOfficeComboBox
    Left = 0
    Top = 0
    Width = 255
    Height = 41
    HintImageIndex = 0
    TabOrder = 0
    SkinData = FrmMain.SkinData_Main
    SkinDataName = 'combobox'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 13
    DefaultFont.Name = 'Tahoma'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    UseSkinSize = False
    ToolButtonStyle = False
    AlphaBlend = False
    AlphaBlendValue = 0
    AlphaBlendAnimation = False
    AlternateRow = False
    ListBoxHeaderLeftAlignment = False
    ListBoxDefaultFont.Charset = DEFAULT_CHARSET
    ListBoxDefaultFont.Color = clWindowText
    ListBoxDefaultFont.Height = 13
    ListBoxDefaultFont.Name = 'Tahoma'
    ListBoxDefaultFont.Style = []
    ListBoxUseSkinFont = True
    ListBoxWidth = 0
    ListBoxHeight = 0
    ListBoxShowItemTitles = True
    ListBoxSkinDataName = 'listbox'
    ListBoxShowLines = False
    ListBoxItemHeight = 30
    ListBoxHeaderHeight = 20
    HideSelection = True
    ShowItemTitle = True
    ShowItemImage = True
    ShowItemText = True
    DefaultColor = clWindow
    Align = alTop
    Items = <
      item
        Header = True
        Enabled = True
        Title = 'Select a language'
        Caption = 'Select a language'
        Checked = False
      end
      item
        Header = False
        Enabled = True
        Title = 'Language'
        Caption = 'English'
        Checked = False
      end
      item
        Header = False
        Enabled = True
        Title = 'Language'
        Caption = 'Espa'#241'ol'
        Checked = False
      end
      item
        Header = False
        Enabled = True
        Title = 'Language'
        Caption = 'Fran'#231'ais'
        Checked = False
      end
      item
        Header = False
        Enabled = True
        Title = 'Language'
        Caption = 'Deutsch'
        Checked = False
      end>
    ItemIndex = -1
    DropDownCount = 7
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 13
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object OfficeComboBox_Skin: TbsSkinOfficeComboBox
    Left = 0
    Top = 41
    Width = 255
    Height = 46
    HintImageIndex = 0
    TabOrder = 1
    SkinData = FrmMain.SkinData_Main
    SkinDataName = 'combobox'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 13
    DefaultFont.Name = 'Tahoma'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    UseSkinSize = False
    ToolButtonStyle = False
    AlphaBlend = False
    AlphaBlendValue = 0
    AlphaBlendAnimation = False
    AlternateRow = False
    ListBoxHeaderLeftAlignment = False
    ListBoxDefaultFont.Charset = DEFAULT_CHARSET
    ListBoxDefaultFont.Color = clWindowText
    ListBoxDefaultFont.Height = 13
    ListBoxDefaultFont.Name = 'Tahoma'
    ListBoxDefaultFont.Style = []
    ListBoxUseSkinFont = True
    ListBoxWidth = 0
    ListBoxHeight = 0
    ListBoxShowItemTitles = True
    ListBoxSkinDataName = 'listbox'
    ListBoxShowLines = False
    ListBoxItemHeight = 30
    ListBoxHeaderHeight = 20
    HideSelection = True
    ShowItemTitle = True
    ShowItemImage = True
    ShowItemText = True
    DefaultColor = clWindow
    Align = alTop
    Items = <
      item
        Header = True
        Enabled = True
        Title = 'Select a UI theme'
        Caption = 'Select a UI theme'
        Checked = False
      end
      item
        Header = False
        Enabled = True
        Title = 'Theme'
        Caption = 'Light'
        Checked = False
      end
      item
        Header = False
        Enabled = True
        Title = 'Theme'
        Caption = 'Dark'
        Checked = False
      end>
    ItemIndex = -1
    DropDownCount = 7
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 13
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object Panel_SettingsOKButton: TbsSkinPanel
    Left = 0
    Top = 249
    Width = 255
    Height = 63
    HintImageIndex = 0
    TabOrder = 2
    SkinData = FrmMain.SkinData_Main
    SkinDataName = 'panel'
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
    BorderStyle = bvFrame
    CaptionMode = False
    RollUpMode = False
    RollUpState = False
    NumGlyphs = 1
    Spacing = 2
    Caption = 'Panel_SettingsOKButton'
    Align = alBottom
    object Button_SaveSettings: TbsSkinButton
      Left = 1
      Top = 1
      Width = 81
      Height = 61
      HintImageIndex = 0
      TabOrder = 0
      SkinData = FrmMain.SkinData_Main
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
      ImageIndex = -1
      AlwaysShowLayeredFrame = False
      UseSkinSize = False
      UseSkinFontColor = True
      RepeatMode = False
      RepeatInterval = 100
      AllowAllUp = False
      TabStop = True
      CanFocused = True
      Down = False
      GroupIndex = 0
      Caption = '&Save'
      NumGlyphs = 1
      Spacing = 1
      Align = alLeft
      Default = True
      ModalResult = 1
    end
    object Button_CancelSettings: TbsSkinButton
      Left = 159
      Top = 1
      Width = 95
      Height = 61
      HintImageIndex = 0
      TabOrder = 1
      SkinData = FrmMain.SkinData_Main
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
      ImageIndex = -1
      AlwaysShowLayeredFrame = False
      UseSkinSize = False
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
      Spacing = 1
      Align = alRight
      ModalResult = 2
    end
  end
  object ComboBox_ShowWebPage: TbsSkinComboBoxEx
    Left = 137
    Top = 92
    Width = 97
    Height = 20
    HintImageIndex = 0
    TabOrder = 3
    SkinData = FrmMain.SkinData_Main
    SkinDataName = 'combobox'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 13
    DefaultFont.Name = 'Tahoma'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    UseSkinSize = True
    ToolButtonStyle = False
    ItemsEx = <
      item
        Caption = 'Yes'
      end
      item
        Caption = 'No'
      end>
    Style = bscbFixedStyle
    HideSelection = True
    AutoComplete = True
    ListBoxUseSkinFont = True
    ListBoxUseSkinItemHeight = True
    ListBoxWidth = 0
    AlphaBlend = False
    AlphaBlendValue = 0
    AlphaBlendAnimation = False
    ListBoxCaption = 'This caption'
    ListBoxCaptionMode = True
    ListBoxDefaultFont.Charset = DEFAULT_CHARSET
    ListBoxDefaultFont.Color = clWindowText
    ListBoxDefaultFont.Height = 13
    ListBoxDefaultFont.Name = 'Tahoma'
    ListBoxDefaultFont.Style = []
    ListBoxDefaultCaptionFont.Charset = DEFAULT_CHARSET
    ListBoxDefaultCaptionFont.Color = clWindowText
    ListBoxDefaultCaptionFont.Height = 13
    ListBoxDefaultCaptionFont.Name = 'Tahoma'
    ListBoxDefaultCaptionFont.Style = []
    ListBoxDefaultItemHeight = 20
    ListBoxCaptionAlignment = taLeftJustify
    DropDownCount = 8
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 13
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object BusinessSkinForm_Main: TbsBusinessSkinForm
    UseRibbon = False
    ShowMDIScrollBars = False
    WindowState = wsNormal
    QuickButtons = <>
    QuickButtonsShowHint = False
    QuickButtonsShowDivider = True
    ClientInActiveEffect = False
    ClientInActiveEffectType = bsieBlur
    DisableSystemMenu = False
    AlwaysResize = False
    PositionInMonitor = bspDesktopCenter
    UseFormCursorInNCArea = False
    MaxMenuItemsInWindow = 0
    ClientWidth = 0
    ClientHeight = 0
    HideCaptionButtons = False
    HideCloseButton = False
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
    DefCaptionFont.Height = 13
    DefCaptionFont.Name = 'Tahoma'
    DefCaptionFont.Style = [fsBold]
    DefInActiveCaptionFont.Charset = DEFAULT_CHARSET
    DefInActiveCaptionFont.Color = clBtnShadow
    DefInActiveCaptionFont.Height = 13
    DefInActiveCaptionFont.Name = 'Tahoma'
    DefInActiveCaptionFont.Style = [fsBold]
    DefMenuItemHeight = 20
    DefMenuItemFont.Charset = DEFAULT_CHARSET
    DefMenuItemFont.Color = clWindowText
    DefMenuItemFont.Height = 13
    DefMenuItemFont.Name = 'Tahoma'
    DefMenuItemFont.Style = []
    UseDefaultSysMenu = True
    SkinData = FrmMain.SkinData_Main
    MinimizeApplication = False
    MenusSkinData = FrmMain.SkinData_Main
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
    BorderIcons = [biSystemMenu]
    Left = 184
    Top = 152
  end
  object LangLinked_1: TsiLangLinked
    Version = '7.6.0.1'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 4
    LangDispatcher = FrmMain.LangDispatcher_Main
    LangDelim = 1
    LangNames.Strings = (
      'English'
      'Spanish'
      'French'
      'German')
    Language = 'English'
    ExcludedProperties.Strings = (
      'Category'
      'SecondaryShortCuts'
      'HelpKeyword'
      'InitialDir'
      'HelpKeyword'
      'ActivePage'
      'ImeName'
      'DefaultExt'
      'FileName'
      'FieldName'
      'PickList'
      'DisplayFormat'
      'EditMask'
      'KeyList'
      'LookupDisplayFields'
      'DropDownSpecRow'
      'TableName'
      'DatabaseName'
      'IndexName'
      'MasterFields')
    Left = 144
    Top = 152
    TranslationData = {
      73007400430061007000740069006F006E0073005F0055006E00690063006F00
      640065000D000A0054004D00440049004300680069006C00640001004D004400
      490020004300680069006C00640001000100010001000D000A00730074004800
      69006E00740073005F0055006E00690063006F00640065000D000A0054004D00
      440049004300680069006C006400010001000100010001000D000A004D006500
      6D006F003100010001000100010001000D000A00730074004400690073007000
      6C00610079004C006100620065006C0073005F0055006E00690063006F006400
      65000D000A007300740046006F006E00740073005F0055006E00690063006F00
      640065000D000A0054004D00440049004300680069006C00640001004D005300
      2000530061006E00730020005300650072006900660001005400610068006F00
      6D00610001005400610068006F006D00610001005400610068006F006D006100
      01000D000A00730074004D0075006C00740069004C0069006E00650073005F00
      55006E00690063006F00640065000D000A004D0065006D006F0031002E004C00
      69006E0065007300010001000100010001000D000A0073007400530074007200
      69006E00670073005F0055006E00690063006F00640065000D000A0073007400
      4F00740068006500720053007400720069006E00670073005F0055006E006900
      63006F00640065000D000A0054004D00440049004300680069006C0064002E00
      480065006C007000460069006C006500010001000100010001000D000A007300
      740043006F006C006C0065006300740069006F006E0073005F0055006E006900
      63006F00640065000D000A007300740043006800610072005300650074007300
      5F0055006E00690063006F00640065000D000A0054004D004400490043006800
      69006C006400010041004E00530049005F004300480041005200530045005400
      010041004E00530049005F004300480041005200530045005400010041004E00
      530049005F004300480041005200530045005400010052005500530053004900
      41004E005F00430048004100520053004500540001000D000A00}
  end
end

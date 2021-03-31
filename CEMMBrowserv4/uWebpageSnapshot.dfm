object WebpageSnapshotFrm: TWebpageSnapshotFrm
  Left = 0
  Top = 0
  Caption = 'Web page snapshot'
  ClientHeight = 737
  ClientWidth = 1032
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
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 718
    Width = 1032
    Height = 19
    Panels = <
      item
        Width = 1000
      end>
  end
  object NavigationPnl: TPanel
    Left = 0
    Top = 0
    Width = 1032
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    TabOrder = 1
    object GoBtn: TButton
      Left = 955
      Top = 2
      Width = 75
      Height = 21
      Align = alRight
      Caption = 'Go'
      TabOrder = 0
      OnClick = GoBtnClick
    end
  end
  object Button_1: TButton
    Left = 896
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Button_1'
    TabOrder = 2
    OnClick = Button_1Click
  end
  object Button_2: TButton
    Left = 896
    Top = 119
    Width = 91
    Height = 25
    Caption = 'second method'
    TabOrder = 3
    OnClick = Button_2Click
  end
  object HtmlViewer1: THtmlViewer
    Left = 8
    Top = 40
    Width = 833
    Height = 513
    BorderStyle = htFocused
    HistoryMaxCount = 0
    NoSelect = False
    PrintMarginBottom = 2.000000000000000000
    PrintMarginLeft = 2.000000000000000000
    PrintMarginRight = 2.000000000000000000
    PrintMarginTop = 2.000000000000000000
    PrintScale = 1.000000000000000000
    Text = ''
    TabOrder = 4
    Touch.InteractiveGestures = [igPan]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia]
  end
  object idhttp_1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    CookieManager = idCookieManager_1
    Left = 432
    Top = 328
  end
  object idCookieManager_1: TIdCookieManager
    Left = 552
    Top = 280
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 552
    Top = 392
  end
end

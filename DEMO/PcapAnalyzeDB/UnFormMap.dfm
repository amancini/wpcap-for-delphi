object FormMap: TFormMap
  Left = 0
  Top = 0
  Caption = 'Map'
  ClientHeight = 608
  ClientWidth = 961
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dxMapControl1: TdxMapControl
    Left = 0
    Top = 0
    Width = 961
    Height = 608
    Align = alClient
    NavigationPanel.Style.CoordinateFont.Charset = DEFAULT_CHARSET
    NavigationPanel.Style.CoordinateFont.Color = clWindowText
    NavigationPanel.Style.CoordinateFont.Height = -21
    NavigationPanel.Style.CoordinateFont.Name = 'Tahoma'
    NavigationPanel.Style.CoordinateFont.Style = []
    NavigationPanel.Style.ScaleFont.Charset = DEFAULT_CHARSET
    NavigationPanel.Style.ScaleFont.Color = clWindowText
    NavigationPanel.Style.ScaleFont.Height = -16
    NavigationPanel.Style.ScaleFont.Name = 'Tahoma'
    NavigationPanel.Style.ScaleFont.Style = []
    TabOrder = 0
    object dxMapControl1ImageTileLayer1: TdxMapImageTileLayer
      ProviderClassName = 'TdxMapControlOpenStreetMapImageryDataProvider'
      Provider.Subdomains.Strings = (
        'a'
        'b'
        'c')
      Provider.UrlTemplate = 'http://[subdomain].tile.openstreetmap.org/[z]/[x]/[y].png'
    end
    object dxMapControl1ItemLayer1: TdxMapItemLayer
      ProjectionClassName = 'TdxMapControlSphericalMercatorProjection'
    end
  end
  object ImgCell: TcxImage
    Left = 744
    Top = 368
    Picture.Data = {
      0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
      2220656E636F64696E673D225554462D38223F3E0D0A3C737667207665727369
      6F6E3D22312E31222069643D224C617965725F312220786D6C6E733D22687474
      703A2F2F7777772E77332E6F72672F323030302F7376672220786D6C6E733A78
      6C696E6B3D22687474703A2F2F7777772E77332E6F72672F313939392F786C69
      6E6B2220783D223070782220793D22307078222076696577426F783D22302030
      20333220333222207374796C653D22656E61626C652D6261636B67726F756E64
      3A6E6577203020302033322033323B2220786D6C3A73706163653D2270726573
      65727665223E262331333B262331303B3C7374796C6520747970653D22746578
      742F6373732220786D6C3A73706163653D227072657365727665223E2E426C75
      657B66696C6C3A233131373744373B7D262331333B262331303B2623393B2E47
      7265656E7B66696C6C3A233033394332333B7D262331333B262331303B262339
      3B2E59656C6C6F777B66696C6C3A234646423131353B7D262331333B26233130
      3B2623393B2E426C61636B7B66696C6C3A233732373237323B7D262331333B26
      2331303B2623393B2E57686974657B66696C6C3A234646464646463B7D262331
      333B262331303B2623393B2E5265647B66696C6C3A234431314331433B7D2623
      31333B262331303B2623393B2E7374307B6F7061636974793A302E37353B7D3C
      2F7374796C653E0D0A3C672069643D2242616E6B223E0D0A09093C706F6C7967
      6F6E20636C6173733D22426C61636B2220706F696E74733D2231362C3420322C
      31322033302C3132202623393B222F3E0D0A09093C7265637420783D22313422
      20793D2231342220636C6173733D22426C61636B222077696474683D22342220
      6865696768743D2238222F3E0D0A09093C7265637420783D2232302220793D22
      31342220636C6173733D22426C61636B222077696474683D2234222068656967
      68743D2238222F3E0D0A09093C7265637420783D22342220793D223234222063
      6C6173733D22426C61636B222077696474683D22323422206865696768743D22
      34222F3E0D0A09093C7265637420783D22382220793D2231342220636C617373
      3D22426C61636B222077696474683D223422206865696768743D2238222F3E0D
      0A093C2F673E0D0A3C2F7376673E0D0A}
    TabOrder = 1
    Visible = False
    Height = 24
    Width = 24
  end
end

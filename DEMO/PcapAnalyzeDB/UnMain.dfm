object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'PCAP Analisys'
  ClientHeight = 666
  ClientWidth = 1201
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GridPcap: TcxGrid
    Left = 0
    Top = 65
    Width = 656
    Height = 582
    Align = alClient
    TabOrder = 0
    LockedStateImageOptions.Effect = lsieDark
    LockedStateImageOptions.ShowText = True
    ExplicitHeight = 580
    object GridPcapDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.Layout = fplCompact
      FindPanel.Location = fplGroupByBox
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = GridPcapDBTableView1CustomDrawCell
      OnFocusedRecordChanged = GridPcapDBTableView1FocusedRecordChanged
      DataController.DataSource = DsGrid
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Kind = skCount
          Column = GridPcapDBTableView1NPACKET
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          OnGetText = GridPcapTableView1TcxGridDataControllerTcxDataSummaryFooterSummaryItems0GetText
          Column = GridPcapDBTableView1PACKET_LEN
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.CellHints = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsCustomize.ColumnsQuickCustomizationSorted = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.CellEndEllipsis = True
      OptionsView.DataRowHeight = 20
      OptionsView.Footer = True
      OptionsView.GridLines = glHorizontal
      OptionsView.HeaderEndEllipsis = True
      OptionsView.Indicator = True
      OptionsView.ShowColumnFilterButtons = sfbAlways
      object GridPcapDBTableView1NPACKET: TcxGridDBColumn
        Caption = 'Count'
        DataBinding.FieldName = 'NPACKET'
        Width = 82
      end
      object GridPcapDBTableView1PACKET_DATE: TcxGridDBColumn
        Caption = 'Date'
        DataBinding.FieldName = 'PACKET_DATE'
        Width = 120
      end
      object GridPcapDBTableView1IP_SRC: TcxGridDBColumn
        Caption = 'Source'
        DataBinding.FieldName = 'IP_SRC'
        Width = 150
      end
      object GridPcapDBTableView1PORT_SRC: TcxGridDBColumn
        Caption = 'Port src'
        DataBinding.FieldName = 'PORT_SRC'
      end
      object GridPcapDBTableView1IP_DST: TcxGridDBColumn
        Caption = 'Dest'
        DataBinding.FieldName = 'IP_DST'
        Width = 150
      end
      object GridPcapDBTableView1PORT_DST: TcxGridDBColumn
        Caption = 'Port dst'
        DataBinding.FieldName = 'PORT_DST'
        Width = 70
      end
      object GridPcapDBTableView1PROTOCOL: TcxGridDBColumn
        Caption = 'Protocol'
        DataBinding.FieldName = 'PROTOCOL'
        Width = 77
      end
      object GridPcapDBTableView1PACKET_LEN: TcxGridDBColumn
        Caption = 'Len'
        DataBinding.FieldName = 'PACKET_LEN'
        Width = 73
      end
      object GridPcapDBTableView1ETH_TYPE: TcxGridDBColumn
        DataBinding.FieldName = 'ETH_TYPE'
        Visible = False
        Width = 109
      end
      object GridPcapDBTableView1ETH_ACRONYM: TcxGridDBColumn
        Caption = 'Eth type'
        DataBinding.FieldName = 'ETH_ACRONYM'
      end
      object GridPcapDBTableView1MAC_SRC: TcxGridDBColumn
        Caption = 'Mac src'
        DataBinding.FieldName = 'MAC_SRC'
        Width = 150
      end
      object GridPcapDBTableView1MAC_DST: TcxGridDBColumn
        Caption = 'Mac dst'
        DataBinding.FieldName = 'MAC_DST'
        Width = 150
      end
      object GridPcapDBTableView1IPPROTO: TcxGridDBColumn
        DataBinding.FieldName = 'IPPROTO'
        Visible = False
      end
      object GridPcapDBTableView1PROTO_DETECT: TcxGridDBColumn
        DataBinding.FieldName = 'PROTO_DETECT'
        Visible = False
        VisibleForCustomization = False
      end
      object GridPcapDBTableView1IANA_PROTO: TcxGridDBColumn
        Caption = 'IANA_Protocol'
        DataBinding.FieldName = 'IANA_PROTO'
      end
    end
    object GridPcapLevel1: TcxGridLevel
      GridView = GridPcapDBTableView1
    end
  end
  object cxProgressBar1: TcxProgressBar
    Left = 0
    Top = 647
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 645
    Width = 1201
  end
  object cxSplitter1: TcxSplitter
    Left = 656
    Top = 65
    Width = 10
    Height = 582
    AlignSplitter = salRight
    Control = PHexMemo
  end
  object cxGroupBox1: TcxGroupBox
    Left = 0
    Top = 22
    Align = alTop
    PanelStyle.Active = True
    TabOrder = 4
    Height = 43
    Width = 1201
    object cxLabel1: TcxLabel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Align = alLeft
      Caption = 'Filter by WinPCAP API:'
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      AnchorY = 22
    end
    object EFilter: TcxTextEdit
      AlignWithMargins = True
      Left = 127
      Top = 7
      Align = alClient
      ParentShowHint = False
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Properties.OnValidate = EFilterPropertiesValidate
      ShowHint = True
      TabOrder = 1
      Width = 1067
    end
  end
  object PHexMemo: TcxGroupBox
    Left = 666
    Top = 65
    Align = alRight
    PanelStyle.Active = True
    TabOrder = 8
    ExplicitHeight = 580
    Height = 582
    Width = 535
    object MemoHex: TcxMemo
      Left = 4
      Top = 328
      Align = alBottom
      Lines.Strings = (
        '')
      ParentShowHint = False
      Properties.ReadOnly = True
      Properties.ScrollBars = ssBoth
      ShowHint = True
      TabOrder = 0
      Height = 250
      Width = 527
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 4
      Top = 4
      Width = 527
      Height = 22
      Align = dalTop
      BarManager = dxBarManager1
    end
    object cxSplitter2: TcxSplitter
      Left = 4
      Top = 318
      Width = 527
      Height = 10
      AlignSplitter = salBottom
      Control = MemoHex
    end
    object ListPacketDetail: TcxTreeList
      Left = 4
      Top = 26
      Width = 527
      Height = 292
      Align = alClient
      Bands = <
        item
        end>
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.Layout = fplCompact
      Navigator.Buttons.CustomButtons = <>
      OptionsBehavior.CellHints = True
      OptionsData.CancelOnExit = False
      OptionsData.Editing = False
      OptionsData.Deleting = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      ScrollbarAnnotations.CustomAnnotations = <>
      TabOrder = 3
      object ListPacketDetailColumn1: TcxTreeListColumn
        Width = 290
        Position.ColIndex = 0
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
      object ListPacketDetailColumn2: TcxTreeListColumn
        Width = 118
        Position.ColIndex = 1
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
      object ListPacketDetailColumn3: TcxTreeListColumn
        Width = 117
        Position.ColIndex = 2
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 272
    Top = 80
  end
  object DsGrid: TDataSource
    Left = 1056
    Top = 488
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = cxImageList1
    PopupMenuLinks = <>
    Style = bmsUseLookAndFeel
    UseSystemFont = True
    Left = 416
    Top = 160
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      22
      0)
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      Caption = 'MainMenu'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1229
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'BStartRecording'
        end
        item
          Visible = True
          ItemName = 'BLoadPCAP'
        end
        item
          Visible = True
          ItemName = 'BSavePCAP'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRecentItems = False
      UseRestSpace = True
      Visible = True
      WholeRow = True
    end
    object dxBarManager1Bar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'MenuHex'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1128
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'BSavePacket'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object BSavePCAP: TdxBarButton
      Caption = 'Save PCAP'
      Category = 0
      Enabled = False
      Hint = 'Save PCAP'
      Visible = ivAlways
      ImageIndex = 1
      PaintStyle = psCaptionGlyph
      ShortCut = 16467
      OnClick = BSavePCAPClick
    end
    object BLoadPCAP: TdxBarButton
      Caption = 'Load PCAP'
      Category = 0
      Hint = 'Load PCAP'
      Visible = ivAlways
      ImageIndex = 0
      PaintStyle = psCaptionGlyph
      OnClick = BLoadPCAPClick
    end
    object BStartRecording: TdxBarButton
      Caption = 'Capture'
      Category = 0
      Hint = 'Capture'
      Visible = ivAlways
      ImageIndex = 2
      PaintStyle = psCaptionGlyph
      OnClick = BStartRecordingClick
    end
    object BSavePacket: TdxBarButton
      Caption = 'Save packet'
      Category = 0
      Enabled = False
      Hint = 'Save packet'
      Visible = ivAlways
      ImageIndex = 1
      PaintStyle = psCaptionGlyph
      OnClick = BSavePacketClick
    end
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    Left = 424
    Top = 240
    Bitmap = {
      494C010103000800040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B57936FFB57936FFB579
      36FFB57936FFB57936FFB57936FFB57936FFB57936FFB57936FFB57936FFB579
      36FFB57936FFB57936FFB57936FF000000000000000000000000000000000000
      00000000021A07073A88131392D51B1BC9FB1B1BCAFB141494D708083C8A0000
      021B000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B57936FFB57936FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFB57936FFB57936FF000000000000000000000000000000000303
      18581919BCF21B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1919
      BDF303031A5C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000002031E0B638FBF14B1
      FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF14B1FFFF073F5C99000000000000000000000000B57936FFB57936FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFB57936FFB57936FF000000000000000000000000030318571B1B
      CEFD1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1B
      D1FF1B1BCFFE03031A5C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000004253676010E144814B1
      FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14AAF5FA0002031E0000000000000000B57936FFB57936FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFB57936FFB57936FF0000000000000000000001181818BAF11B1B
      D1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1B
      D1FF1B1BD1FF1919BDF30000021B000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B5F87BA000101140D75
      A9D014B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF0637508F0000000000000000B57936FFB57936FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFB57936FFB57936FF0000000000000000070738851B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF08083C8A000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B638FBF031C28660215
      1E5914B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF12A1E7F30000011200000000B57936FFB57936FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFB57936FFB57936FF000000000000000012128DD21B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF131394D7000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B638FBF0A577DB30000
      000E0F86C1DE14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF14B1FFFF04293B7B00000000B57936FFB57936FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFB57936FFB57936FF00000000000000001919C2F61B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF1A1ACAFB000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B638FBF0B638FBF0214
      1D57031E2B6A14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF14B1FFFF108CCAE300000000B57936FFB57936FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFB57936FFB57936FF00000000000000001919C1F51B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF1A1AC9FB000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B638FBF0B638FBF094F
      71AA000001120000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B57936FFB57936FFB579
      36FFB57936FFB57936FFB57936FFB57936FFB57936FFB57936FFB57936FFB579
      36FFB57936FFB57936FFB57936FF000000000000000012128AD01B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF131392D5000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B638FBF0B638FBF0B63
      8FBF0B638FBF0B638FBF0B638FBF0B638FBF0B638FBF0B638FBF0B638FBF0B63
      8FBF0B638FBF00000000000000000000000000000000B57936FFB57936FFE1CA
      AFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CA
      AFFFB57936FFB57936FFB57936FF0000000000000000070736831B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF07073A88000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B638FBF0B638FBF0B63
      8FBF0B638FBF0B638FBF0B638FBF0B638FBF0B638FBF0B638FBF0B638FBF0B63
      8FBF0A5980B500000000000000000000000000000000B57936FFB57936FFE1CA
      AFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFB57936FFE1CA
      AFFFB57936FFB57936FFB57936FF0000000000000000000001171818B8F01B1B
      D1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1B
      D1FF1B1BD1FF1919BCF20000021A000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B638FBF0B638FBF0B63
      8FBF0B638FBF0B638FBF00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B57936FFB57936FFE1CA
      AFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFB57936FFE1CA
      AFFFB57936FFB57936FFB57936FF000000000000000000000000020216531B1B
      CDFD1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1B
      D1FF1B1BCEFD0303185800000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000A577DB30B638FBF0B63
      8FBF0B638FBF0A5980B500000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B57936FFB57936FFE1CA
      AFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFB57936FFE1CA
      AFFFB57936FFB57936FF2B1D0D7D000000000000000000000000000000000202
      16531818B8F01B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1818
      BAF1030318570000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B57936FFB57936FFE1CA
      AFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFE1CAAFFFB57936FFE1CA
      AFFFB57936FF2B1D0D7D00000000000000000000000000000000000000000000
      0000000001170707368312128AD01919C1F51919C2F612128CD1070737840000
      0118000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
    DesignInfo = 15729064
    ImageInfo = <
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224F
          70656E2220786D6C6E733D22687474703A2F2F7777772E77332E6F72672F3230
          30302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F7777772E
          77332E6F72672F313939392F786C696E6B2220783D223070782220793D223070
          78222076696577426F783D2230203020333220333222207374796C653D22656E
          61626C652D6261636B67726F756E643A6E6577203020302033322033323B2220
          786D6C3A73706163653D227072657365727665223E262331333B262331303B3C
          7374796C6520747970653D22746578742F6373732220786D6C3A73706163653D
          227072657365727665223E2E59656C6C6F777B66696C6C3A234646423131353B
          7D262331333B262331303B2623393B2E7374307B6F7061636974793A302E3735
          3B7D3C2F7374796C653E0D0A3C6720636C6173733D22737430223E0D0A09093C
          7061746820636C6173733D2259656C6C6F772220643D224D322E322C32352E32
          6C352E352D313263302E332D302E372C312D312E322C312E382D312E32483236
          563963302D302E362D302E342D312D312D31483132563563302D302E362D302E
          342D312D312D31483343322E342C342C322C342E342C322C3576323020202623
          393B2623393B63302C302E322C302C302E332C302E312C302E3443322E312C32
          352E332C322E322C32352E332C322E322C32352E327A222F3E0D0A093C2F673E
          0D0A3C7061746820636C6173733D2259656C6C6F772220643D224D33312E332C
          313448392E364C342C32366832312E3863302E352C302C312E312D302E332C31
          2E332D302E374C33322C31342E374333322E312C31342E332C33312E382C3134
          2C33312E332C31347A222F3E0D0A3C2F7376673E0D0A}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
          2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
          22307078222076696577426F783D223020302033322033322220656E61626C65
          2D6261636B67726F756E643D226E6577203020302033322033322220786D6C3A
          73706163653D227072657365727665223E262331333B262331303B3C706F6C79
          676F6E2066696C6C3D22233337374142352220706F696E74733D22322C322032
          2C33302033302C33302033302C362032362C3220222F3E0D0A3C726563742078
          3D22362220793D223134222066696C6C3D222346464646464622207769647468
          3D22323022206865696768743D223134222F3E0D0A3C7265637420783D223622
          20793D223222206F7061636974793D22302E36222066696C6C3D222346464646
          46462220656E61626C652D6261636B67726F756E643D226E6577202020202220
          77696474683D22313822206865696768743D223130222F3E0D0A3C7265637420
          783D2232302220793D2232222066696C6C3D2223333737414235222077696474
          683D223222206865696768743D2238222F3E0D0A3C2F7376673E0D0A}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
          2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
          22307078222076696577426F783D2230203020333220333222207374796C653D
          22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
          3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
          303B3C7374796C6520747970653D22746578742F637373223E2E5265647B6669
          6C6C3A234431314331433B7D3C2F7374796C653E0D0A3C7061746820636C6173
          733D225265642220643D224D31362C3243382E332C322C322C382E332C322C31
          3673362E332C31342C31342C31347331342D362E332C31342D31345332332E37
          2C322C31362C327A222F3E0D0A3C2F7376673E0D0A}
      end>
  end
  object SaveDialog1: TSaveDialog
    Left = 320
    Top = 144
  end
  object dxSkinController1: TdxSkinController
    SkinName = 'Basic'
    SkinPaletteName = 'Violet Dark'
    Left = 984
    Top = 168
  end
end

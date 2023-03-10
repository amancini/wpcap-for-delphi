unit UnMain;

interface
                                                            
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,System.UITypes,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Wpcap.types, 
  Vcl.StdCtrls, cxGraphics, cxControls, cxCustomData, wpcap.Pcap,wpcap.Graphics,
  cxGridCustomTableView, cxGridTableView, cxGridLevel, cxClasses,DateUtils,
  cxGrid,  cxLookAndFeels,wpcap.Wrapper,wpcap.Filter,System.Generics.Collections,
  cxLookAndFeelPainters, dxSkinsCore, cxStyles, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxGridCustomView,
  cxContainer, cxProgressBar,wpcap.Pcap.SQLite,wpcap.StrUtils, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,UnitGridUtils,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, UnFormFlow,
  FireDAC.DApt, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,wpcap.GEOLite2,
  FireDAC.Phys.SQLiteDef, Data.DB, cxDBData, cxGridDBTableView, wpcap.DB.SQLite.Packet,
  FireDAC.Phys.SQLite, FireDAC.Comp.DataSet, FireDAC.Comp.Client,wpcap.Protocol,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,
  cxTextEdit, cxMemo, cxSplitter, dxBar, System.ImageList, Vcl.ImgList,
  cxImageList, dxSkinBasic, dxCore, dxSkinsForm, cxLabel, cxGroupBox, cxTL,
  cxTLdxBarBuiltInMenu, cxInplaceContainer, dxBarBuiltInMenu,UnFormMap,
  cxGridCustomPopupMenu, cxGridPopupMenu, cxCheckBox, dxToggleSwitch,
  cxBarEditItem,wpcap.Geometry, Vcl.Menus, cxButtons;

type
  TFormMain = class(TForm)
    OpenDialog1: TOpenDialog;
    GridPcapLevel1: TcxGridLevel;
    GridPcap: TcxGrid;
    GridPcapDBTableView1: TcxGridDBTableView;
    DsGrid: TDataSource;
    GridPcapDBTableView1NPACKET: TcxGridDBColumn;
    GridPcapDBTableView1PACKET_LEN: TcxGridDBColumn;
    GridPcapDBTableView1PACKET_DATE: TcxGridDBColumn;
    GridPcapDBTableView1ETH_TYPE: TcxGridDBColumn;
    GridPcapDBTableView1ETH_ACRONYM: TcxGridDBColumn;
    GridPcapDBTableView1MAC_SRC: TcxGridDBColumn;
    GridPcapDBTableView1MAC_DST: TcxGridDBColumn;
    GridPcapDBTableView1IPPROTO: TcxGridDBColumn;
    GridPcapDBTableView1PROTOCOL: TcxGridDBColumn;
    GridPcapDBTableView1IP_SRC: TcxGridDBColumn;
    GridPcapDBTableView1IP_DST: TcxGridDBColumn;
    GridPcapDBTableView1PORT_SRC: TcxGridDBColumn;
    GridPcapDBTableView1PORT_DST: TcxGridDBColumn;
    cxSplitter1: TcxSplitter;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    BSavePCAP: TdxBarButton;
    BLoadPCAP: TdxBarButton;
    cxImageList1: TcxImageList;
    SaveDialog1: TSaveDialog;
    dxSkinController1: TdxSkinController;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    EFilter: TcxTextEdit;
    BStartRecording: TdxBarButton;
    PHexMemo: TcxGroupBox;
    MemoHex: TcxMemo;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar2: TdxBar;
    BSavePacket: TdxBarButton;
    GridPcapDBTableView1PROTO_DETECT: TcxGridDBColumn;
    GridPcapDBTableView1IANA_PROTO: TcxGridDBColumn;
    cxSplitter2: TcxSplitter;
    ListPacketDetail: TcxTreeList;
    ListPacketDetailColumn1: TcxTreeListColumn;
    ListPacketDetailColumn2: TcxTreeListColumn;
    ListPacketDetailColumn3: TcxTreeListColumn;
    BSaveListPacket: TdxBarButton;
    BSaevGrid: TdxBarButton;
    cxGridPopupMenu1: TcxGridPopupMenu;
    PopupGrid: TdxBarPopupMenu;
    BCopyGrid: TdxBarButton;
    GridPcapDBTableView1IPPROTO_STR: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    GridPcapDBTableView1ORGANIZZATION: TcxGridDBColumn;
    GridPcapDBTableView1ASN: TcxGridDBColumn;
    GridPcapDBTableView1DST_ASN: TcxGridDBColumn;
    GridPcapDBTableView1DstORGANIZZATION: TcxGridDBColumn;
    TActiveGEOIP: TcxBarEditItem;
    BSubTools: TdxBarSubItem;
    dxBarSeparator1: TdxBarSeparator;
    GridPcapDBTableView1SRC_LATITUDE: TcxGridDBColumn;
    GridPcapDBTableView1SRC_LONGITUDE: TcxGridDBColumn;
    GridPcapDBTableView1DST_LATITUDE: TcxGridDBColumn;
    GridPcapDBTableView1DST_LONGITUDE: TcxGridDBColumn;
    BMap: TdxBarButton;
    FDConnection1: TFDConnection;
    pProgressImport: TcxGroupBox;
    cxProgressBar1: TcxProgressBar;
    cxButton1: TcxButton;
    BFlow: TdxBarButton;
    procedure GridPcapTableView1TcxGridDataControllerTcxDataSummaryFooterSummaryItems0GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure EFilterPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure GridPcapDBTableView1FocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BLoadPCAPClick(Sender: TObject);
    procedure BSavePCAPClick(Sender: TObject);
    procedure BStartRecordingClick(Sender: TObject);
    procedure GridPcapDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure BSavePacketClick(Sender: TObject);
    procedure BSaevGridClick(Sender: TObject);
    procedure BSaveListPacketClick(Sender: TObject);
    procedure BCopyGridClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure EFilterKeyPress(Sender: TObject; var Key: Char);
    procedure BMapClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure BFlowClick(Sender: TObject);
  private
    { Private declarations }
    FWPcapDBSqLite : TWPcapDBSqLitePacket;
    FWpcapGeoLite  : TWpcapGEOLITE;
    FPCAPUtils     : TPCAPUtils;
    FFFormMap      : TFormMap;
    FPcapImport    : TPCAP2SQLite;
    FLastPercProg  : Byte;
    FLastFileOpened: String;
    procedure OpenPcap(const aFileName: String);
    procedure SetPositionProgressBar(aNewPos: Int64);
    procedure DoPCAPOfflineCallBackEnd(const aFileName: String);
    procedure DoPCAPOfflineCallBackError(const aFileName, aError: String);
    procedure DoPCAPOfflineCallBackProgress(aTotalSize, aCurrentSize: Int64);
    function GetGeoLiteDatabaseName: String;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses UnFormRecording,UnFormImportGeoLite;

{$R *.dfm}

Procedure TFormMain.SetPositionProgressBar(aNewPos : Int64);
var LPercProg: Byte;
begin
  cxProgressBar1.Position := aNewPos;

  LPercProg := Trunc( (aNewPos * 100) / cxProgressBar1.Properties.Max);

  if (LPercProg Mod 5 = 0) and (FLastPercProg <> LPercProg) then                
    cxProgressBar1.Update;
  FLastPercProg := LPercProg;
end;
                                                                                                  
procedure TFormMain.DoPCAPOfflineCallBackError(const aFileName,aError:String);
begin
  MessageDlg(Format('PCAP %s Error %s',[aFileName,aError]),mtError,[mbOK],0);
  pProgressImport.Visible := False;  
end;

procedure TFormMain.DoPCAPOfflineCallBackProgress(aTotalSize,aCurrentSize:Int64);
begin
  cxProgressBar1.Properties.Max := aTotalSize; 
  SetPositionProgressBar(aCurrentSize);
end;

procedure TFormMain.DoPCAPOfflineCallBackEnd(const aFileName:String);
begin
  FWPcapDBSqLite.OpenDatabase(ChangeFileExt(aFileName,'.db'));

  if FWPcapDBSqLite.Connection.Connected then  
  begin
    DsGrid.DataSet := FWPcapDBSqLite.FDQueryGrid;
    FWPcapDBSqLite.FDQueryGrid.Open;
    BSavePCAP.Enabled := True;
    BSaevGrid.Enabled := True;
  end;
  pProgressImport.Visible := False;    
end;

procedure TFormMain.OpenPcap(const aFileName:String);

begin
  Caption           := Format('PCAP Analisys %s - %s',[ExtractFileName(aFileName),PacketGetVersion]);
  BSavePCAP.Enabled := False;
  BSaevGrid.Enabled := False;
  FWPcapDBSqLite.Connection.Close;
  FWPcapDBSqLite.FDQueryGrid.Close;
  SetPositionProgressBar(0);
  FLastFileOpened := aFileName;
  {TODO 
    Thread with syncronize
    Query bulder 
    Packet detail [TreeView Like wireshark with syncronize with memo ???? HOW ?]
    ChartStatistics by protocol
      
  }
  // filter example dst host 192.0.2.1 but doesn't work  TODO check structure and function definition
  DeleteFile(ChangeFileExt(aFileName,'.db'));
  if Not Trim(EFilter.Text).IsEmpty then
  begin
    if not EFilter.ValidateEdit(False) then
    begin
      MessageDlg('Invalid filter',mtWarning,[mbOK],0);
      Exit;
    end;
  end;
  if Boolean(TActiveGEOIP.EditValue ) and FileExists(GetGeoLiteDatabaseName) then
    FWpcapGeoLite.OpenDatabase(GetGeoLiteDatabaseName)
  else
    FWPcapDBSqLite.Connection.Connected := False;

  if not Assigned(FPcapImport) then 
    FPcapImport := TPCAP2SQLite.Create;
  FPcapImport.PCAP2SQLite(aFileName,ChangeFileExt(aFileName,'.db'),EFilter.Text,FWpcapGeoLite,DoPCAPOfflineCallBackError,DoPCAPOfflineCallBackEnd,DoPCAPOfflineCallBackProgress);

end;

procedure TFormMain.GridPcapTableView1TcxGridDataControllerTcxDataSummaryFooterSummaryItems0GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  if VarIsNull(AValue) then Exit;
  
  AText := SizeToStr(AValue)
end;

procedure TFormMain.EFilterPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
   if VarIsNull(DisplayValue) then Exit;

   if not ValidateWinPCAPFilterExpression(DisplayValue) then
   begin
      ErrorText := 'Invalid filter';
      Error     := True;
   end;    
end;

procedure TFormMain.GridPcapDBTableView1FocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
var LHexList    : TArray<String>;
    I           : Integer;
    LListDetail : TListHeaderString;
    LParentNode : TcxTreeListNode;
    LCurrentNode: TcxTreeListNode;
    function FindParentNode(Level: Integer): TcxTreeListNode;
    var
      I: Integer;
    begin
      Result := nil;
      for I := ListPacketDetail.AbsoluteCount - 1 downto 0 do
      begin
        if (ListPacketDetail.AbsoluteItems[I].Level = Level) then
        begin
          Result := ListPacketDetail.AbsoluteItems[I];
          Break;
        end;
      end;
    end;
    
begin
  MemoHex.Lines.Clear;
  ListPacketDetail.Clear;
  LCurrentNode := nil;
  if Assigned(AFocusedRecord) and AFocusedRecord.HasCells then
  begin
    LListDetail := TListHeaderString.Create;
    Try
     LHexList := FWPcapDBSqLite.GetListHexPacket(AFocusedRecord.Values[GridPcapDBTableView1NPACKET.Index],LListDetail);

      if Assigned(LListDetail) then
      begin
        ListPacketDetail.BeginUpdate;
        Try
          for I := 0 to LListDetail.Count -1 do
          begin
            if LListDetail[I].Level > 0 then
              LParentNode := FindParentNode(LListDetail[I].Level - 1)
            else
              LParentNode := nil;
            
            LCurrentNode           := ListPacketDetail.AddChild(LParentNode);
            LCurrentNode.Values[0] := LListDetail[I].Description;
            LCurrentNode.Values[1] := LListDetail[I].Value;
            LCurrentNode.Values[2] := LListDetail[I].Hex;         
          end;
        finally
          ListPacketDetail.EndUpdate;
        end;                 
      end;
    finally
      FreeAndNil(LListDetail);
    end;

    if Assigned(LCurrentNode) then
    begin
      LParentNode := FindParentNode(0);
      if Assigned(LParentNode) then
        LParentNode.Expand(True)        
    end;  
    
    MemoHex.Lines.BeginUpdate;
    Try 
      for I := Low(LHexList) to High(LHexList) do
        MemoHex.Lines.Add(LHexList[I]);  
    finally
      MemoHex.Lines.EndUpdate
    end
  end;  
  
  BSavePacket.Enabled     := MemoHex.Lines.Count >0;  
  BSaveListPacket.Enabled := MemoHex.Lines.Count >0;  
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  MemoHex.Style.Font.Name := 'Courier New';
  MemoHex.Style.Font.Size := 10;
  FWPcapDBSqLite          := TWPcapDBSqLitePacket.Create;
  FWpcapGeoLite           := TWpcapGEOLITE.Create;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  if Assigned(FFFormMap) then
    FreeAndNil(FFFormMap);
  FreeAndNil(FWpcapGeoLite);
  FreeAndNil(FWPcapDBSqLite);
  if Assigned(FPcapImport) then 
    FreeAndNil(FPcapImport);  
  
end;

procedure TFormMain.BLoadPCAPClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Pcap file|*.pcap|All files|*.*';
  if OpenDialog1.Execute then
  begin
    pProgressImport.Visible := True;
    OpenPcap(OpenDialog1.FileName);
  end;
end;

procedure TFormMain.BSavePCAPClick(Sender: TObject);
var I                : Integer;
    LListPacket      : TList<PTPacketToDump>;
    LPacket          : PByte;
    LPcketSize       : Integer;
    LPacketToDump    : PTPacketToDump;
begin
  SaveDialog1.Filter     := 'Pcap file|*.pcap';
  SaveDialog1.DefaultExt := '.pcap'; 
  if SaveDialog1.Execute then
  begin
    LListPacket := TList<PTPacketToDump>.Create;
    Try
      for I := 0 to GridPcapDBTableView1.DataController.RecordCount -1 do
      begin
          
        LPacket := FWPcapDBSqLite.GetPacketDataFromDatabase(GridPcapDBTableView1.DataController.Values[I,GridPcapDBTableView1NPACKET.Index],LPcketSize);
        if Assigned(LPacket) then
        begin
          New(LPacketToDump);
          LPacketToDump.PacketLen := LPcketSize;
          LPacketToDump.packet    := LPacket;
          LPacketToDump.tv_sec    := DateTimeToUnix(StrToDateTime(GridPcapDBTableView1.DataController.Values[I,GridPcapDBTableView1PACKET_DATE.Index]),False);            
          LListPacket.Add(LPacketToDump);        
        end;
      end;

      if LListPacket.Count > 0 then
        FPCAPUtils.SavePacketListToPcapFile(LListPacket,SaveDialog1.FileName);      
    Finally
      FreeAndNil(LListPacket);
    End;
  end;
end;

procedure TFormMain.BStartRecordingClick(Sender: TObject);
var aFormRecording: TFormRecording;
begin
   aFormRecording := TFormRecording.Create(nil);
   Try   
      aFormRecording.ShowModal;
      if aFormRecording.ModalResult = mrOK then
      begin
        FWPcapDBSqLite.OpenDatabase(aFormRecording.CurrentDBName);
        if FWPcapDBSqLite.Connection.Connected then  
        begin
          DsGrid.DataSet := FWPcapDBSqLite.FDQueryGrid;
          FWPcapDBSqLite.FDQueryGrid.Open;
          BSavePCAP.Enabled := True;
          BSaevGrid.Enabled := True;
        end;    
      end;
      
   Finally
     FreeAndNil(aFormRecording);
   End;
end;

procedure TFormMain.GridPcapDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var LColor     : TColor;
    LFontColor : TColor;
begin
  if AViewInfo.GridRecord.Selected then Exit;
  if not GetProtocolColor(AViewInfo.GridRecord.Values[GridPcapDBTableView1ETH_TYPE.Index],
                          AViewInfo.GridRecord.Values[GridPcapDBTableView1IPPROTO.Index],
                          AViewInfo.GridRecord.Values[GridPcapDBTableView1PROTO_DETECT.Index],LColor,LFontColor) then exit;

  ACanvas.Brush.Color := LColor;
  ACanvas.Font.Color  := LFontColor;
end;

procedure TFormMain.BSavePacketClick(Sender: TObject);
var LListPacket      : TList<PTPacketToDump>;
    LPacket          : PByte;
    LPcketSize       : Integer;
    LPacketToDump    : PTPacketToDump;
begin
  SaveDialog1.Filter     := 'Pcap file|*.pcap|Text file|*.txt';
  SaveDialog1.DefaultExt := '.pcap'; 
  if SaveDialog1.Execute then
  begin
    case SaveDialog1.FilterIndex of
      1 : begin
            if GridPcapDBTableView1.Controller.SelectedRowCount = 0 then
            begin
              MessageDlg('No row selected',mtWarning,[mbOK],0);
              Exit;
            end;
        
            LListPacket := TList<PTPacketToDump>.Create;
            Try
              LPacket := FWPcapDBSqLite.GetPacketDataFromDatabase(GridPcapDBTableView1.Controller.SelectedRows[0].Values[GridPcapDBTableView1NPACKET.Index],LPcketSize);
              if Assigned(LPacket) then
              begin
                New(LPacketToDump);
                LPacketToDump.PacketLen := LPcketSize;
                LPacketToDump.packet    := LPacket;
                LPacketToDump.tv_sec    := DateTimeToUnix(StrToDateTime(GridPcapDBTableView1.Controller.SelectedRows[0].Values[GridPcapDBTableView1PACKET_DATE.Index]),False);            
                LListPacket.Add(LPacketToDump);        
              end;

              if LListPacket.Count > 0 then
                FPCAPUtils.SavePacketListToPcapFile(LListPacket,SaveDialog1.FileName);      
            Finally
              FreeAndNil(LListPacket);
            End;
      
          end;
      2: MemoHex.Lines.SaveToFile(ChangeFileExt(SaveDialog1.FileName,'.txt'));
    end;
  end;
end;

procedure TFormMain.BSaevGridClick(Sender: TObject);
begin
  SaveGrid(GridPcap,SaveDialog1);
end;

procedure TFormMain.BSaveListPacketClick(Sender: TObject);
begin
  SaveList(ListPacketDetail,SaveDialog1);
end;

procedure TFormMain.BCopyGridClick(Sender: TObject);
begin
  CopyCellValue(GridPcapDBTableView1);
end;

procedure TFormMain.dxBarButton1Click(Sender: TObject);
begin
  FormImportGeoLite := TFormImportGeoLite.Create(nil);
  Try
    FormImportGeoLite.DatabaseOutPut := GetGeoLiteDatabaseName;
    FormImportGeoLite.ShowModal;
  Finally
    FreeAndNil(FormImportGeoLite);
  End;
end;

Function TFormMain.GetGeoLiteDatabaseName:String;
begin
  Result := Format('%s\GeoLite\GeoLite.db',[ExtractFilePath(Application.ExeName)])
end;

procedure TFormMain.EFilterKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(key) = VK_RETURN then
  begin
    if FLastFileOpened.IsEmpty then Exit;
    
    if Trim(EFilter.Text).isEmpty  or EFilter.ValidateEdit(False) then
      OpenPcap(FLastFileOpened);    
  end;
end;

procedure TFormMain.BMapClick(Sender: TObject);


  Procedure AddCoordinate(IndexLat,IndexLong:byte);
  var aCoordinate : PTMapCoordinate;
  begin
    New(aCoordinate);
    aCoordinate.Latitude  := 0;
    aCoordinate.Longitude := 0;
    
    if not VarIsNull(GridPcapDBTableView1.Controller.FocusedRow.Values[IndexLat]) then      
      aCoordinate.Latitude  := StrToFloatDef(VarToStrDef( GridPcapDBTableView1.Controller.FocusedRow.Values[IndexLat],String.Empty),0); 
    if not VarIsNull(GridPcapDBTableView1.Controller.FocusedRow.Values[IndexLong]) then             
      aCoordinate.Longitude := StrToFloatDef(VarToStrDef(GridPcapDBTableView1.Controller.FocusedRow.Values[IndexLong],String.Empty),0); 
      
    aCoordinate.DateTime  := StrToDateTime( GridPcapDBTableView1.Controller.FocusedRow.Values[GridPcapDBTableView1PACKET_DATE.Index]);  
    aCoordinate.Info      := VarToStrDef(GridPcapDBTableView1.Controller.FocusedRow.Values[GridPcapDBTableView1ASN.Index],String.Empty)+';';
    if (aCoordinate.Latitude <> 0) and (aCoordinate.Longitude <> 0) then    
      FFFormMap.CurrentCoordinates.Add(aCoordinate);   
  end;
begin
  if Assigned(GridPcapDBTableView1.Controller.FocusedRow) then
  begin
    if Not Assigned(FFFormMap) then
      FFFormMap := TFormMap.Create(nil);

    FFFormMap.CurrentCoordinates.Clear;
    AddCoordinate(GridPcapDBTableView1SRC_LATITUDE.Index,GridPcapDBTableView1SRC_LONGITUDE.Index);
    AddCoordinate(GridPcapDBTableView1DST_LATITUDE.Index,GridPcapDBTableView1DST_LONGITUDE.Index);
      
    if FFFormMap.CurrentCoordinates.Count > 0 then
    begin
      FFFormMap.DrawGeoIp(True,True);
      FFFormMap.Show;    
    end;
  end;
end;

procedure TFormMain.cxButton1Click(Sender: TObject);
begin
  if Assigned(FPcapImport) then
    FPcapImport.Abort := True;
  
end;

procedure TFormMain.BFlowClick(Sender: TObject);
var LFormFlow : TFormFlow;
begin
  if Assigned(GridPcapDBTableView1.Controller.FocusedRow) then
  begin
    LFormFlow := TFormFlow.Create(nil);
    Try
      LFormFlow.LoadHTML(
      FWPcapDBSqLite.GetFlowString( GridPcapDBTableView1.Controller.FocusedRow.Values[GridPcapDBTableView1IP_SRC.Index],
                                    GridPcapDBTableView1.Controller.FocusedRow.Values[GridPcapDBTableView1IP_DST.Index],
                                    GridPcapDBTableView1.Controller.FocusedRow.Values[GridPcapDBTableView1PORT_SRC.Index],
                                    GridPcapDBTableView1.Controller.FocusedRow.Values[GridPcapDBTableView1PORT_DST.Index],
                                    GridPcapDBTableView1.Controller.FocusedRow.Values[GridPcapDBTableView1IPPROTO.Index],
                                    clRed,clBlue
                                  ).Text);
      LFormFlow.ShowModal;
    Finally
      FreeAndNil(LFormFlow);
    End;
  end;
end;

end.

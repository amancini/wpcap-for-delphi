unit wpcap.Pcap;

interface

uses
  wpcap.Wrapper, wpcap.Types, wpcap.StrUtils, wpcap.Conts, wpcap.IANA.DbPort,
  System.Threading, WinApi.Windows, wpcap.Packet, wpcap.IOUtils, System.SysUtils,
  System.DateUtils, System.Classes, Winsock, wpcap.Level.Eth, wpcap.BufferUtils,
  Forms, System.Math, System.Types, System.Generics.Collections, System.Variants,
  wpcap.GEOLite2, wpcap.IPUtils,wpcap.Filter;

type

  TPacketToDump = record 
    tv_sec    : LongInt;
    PacketLen : Integer;
    packet    : pbyte;
  end;
  PTPacketToDump = ^TPacketToDump;

  function  PacketHandlerRealtime ( aUser: PAnsiChar;const aHeader: PTpcap_pkthdr;const aPacketData: Pbyte): Integer; cdecl;  
 type 

  TThreaPcap = class( TThread)
  private         
    FAbort                  : Boolean; 
    FOnPCAPCallBackPacket   : TPCAPCallBackPacket;
    FOnPCAPCallBackError    : TPCAPCallBackError;
    FOnPCAPCallBackProgress : TPCAPCallBackProgress;      
  protected
    FFilename               : string;
    FFilter                 : string;  
    FOwner                  : TObject;
    procedure DoError(const aFileName, aErrorMessage: string); 
  public
    procedure Stop;
    procedure DoProgress(aTotalSize,aCurrentSize:Int64);
    procedure DoPacket(const aInternalPacket : PTInternalPacket);
    Property Abort                  : Boolean                 read FAbort;
    property OnPCAPCallBackError    : TPCAPCallBackError      read FOnPCAPCallBackError     write FOnPCAPCallBackError;
    property OnPCAPCallBackProgress : TPCAPCallBackProgress   read FOnPCAPCallBackProgress  write FOnPCAPCallBackProgress;
    property OnPCAPCallBackPacket   : TPCAPCallBackPacket     read FOnPCAPCallBackPacket    write FOnPCAPCallBackPacket;    
  end;

  TPCAPCaptureRT = class( TThreaPcap)
  private
    FInterfaceName          : string;
    FIP                     : string;
    FPromisc                : Boolean;
    FSavePcapDump           : Boolean;
    FTimeoutMs              : Integer;
    FMaxSizePacket          : Integer;
    FTimeRecoStop           : TTime;  
    FTimeRecCheck           : TDatetime;
    FPCapRT                 : Ppcap_t;    
    FDataLink               : Integer;      
  protected
    procedure Execute; override;
  public
    constructor Create(const aOwner : Tobject;const aFilename, aFilter, aInterfaceName, aIP: string; aPromisc, aSavePcapDump: Boolean;aTimeoutMs: Integer = 1000;aMaxSizePacket: Integer = MAX_PACKET_SIZE; aTimeRecoStop: TTime = 0);
    {Property}
    Property PCapRT   : Ppcap_t     Read FPCapRT; 
    property DataLink : Integer     read FDataLink;
  end;

  
  TPCAPLoadFile = class( TThreaPcap)
  private
    FGeoLiteDB              : TWpcapGEOLITE;
    FOnPCAPCallBackEnd      : TPCAPCallBackEnd;    
  protected
    procedure Execute; override;
  public
    constructor Create(const aOwner : Tobject;const aFilename, aFilter:String;aGeoLiteDB : TWpcapGEOLITE );
    property OnPCAPCallBackEnd      : TPCAPCallBackEnd        read FOnPCAPCallBackEnd       write FOnPCAPCallBackEnd;     
  end;  

 
  TPCAPUtils = class
  strict private
    var FAbort                  : Boolean; 
    var FThreadCaptureRT        : TPCAPCaptureRT;    
    var FThreadLoadFile         : TPCAPLoadFile;        
    var FOnPCAPCallBackEnd      : TPCAPCallBackEnd;
    var FOnPCAPCallBackPacket   : TPCAPCallBackPacket;
    var FOnPCAPCallBackError    : TPCAPCallBackError;
    var FOnPCAPCallBackProgress : TPCAPCallBackProgress;
  private
    procedure DoOnTerminateRT(sender:Tobject);
    procedure DoOnTerminateOffline(sender:Tobject);    
    procedure SetAbort(const aValue: Boolean);
  public
    ///<summary>
    /// Analyzes an packet capture file using a specified set of callbacks.
    ///</summary>
    ///<param name="aFileName">
    /// The name of the file to be analyzed.
    ///<param name="afilter">
    /// Optional filter in string format on PCAP file 
    ///</param>
    ///</param>
    ///<param name="aPCAPCallBackPacket">
    /// A callback procedure to be called for each packet in the capture file.
    ///</param>
    ///<param name="aPCAPCallBackError">
    /// A callback procedure to be called in case of errors during packet processing.
    ///</param>
    ///<param name="aPCAPCallBackEnd">
    /// A callback procedure to be called when packet processing is complete.
    ///</param>
    ///<param name="aPCAPCallBackProgress">
    /// A callback procedure to be called to report progress during packet processing.

    ///</param>
    ///<remarks>
    /// This procedure analyzes an packet capture file using a specified set of callbacks. The specified callbacks are responsible for processing packets, 
    /// handling errors, and reporting progress to the user. 
    /// The procedure reads the capture file packet by packet, calling the appropriate callback procedure for each packet. 
    /// The progress callback is optional and can be used to report progress to the user during long-running capture file analysis.
    ///</remarks>
    procedure AnalyzePCAPOffline( const aFilename, aFilter: String;
                                        aGeoLiteDB : TWpcapGEOLITE); 


    /// <summary>
    ///   Starts recording a PCAP file with the given filename and packet filter.
    /// </summary>
    /// <param name="aFilename">
    ///   The name of the file to record to.
    /// </param>
    /// <param name="aFilter">
    ///   The packet filter to apply to the captured packets, or an empty string to capture all packets.
    /// </param>
    /// <param name="aInterfaceName">
    ///   The name of interface where start recording.
    /// </param>
    /// <param name="aPromisc">
    ///   Use promisc in interface
    /// </param>
    /// <param name="aSevePcapDump">
    ///   save DB and PCAP dump 
    /// </param>
    /// <param name="aPCAPCallBackPacket">
    ///  A callback procedure to be called for each packet in the capture file.
    /// </param>
    /// <param name="aPCAPCallBackError">
    ///  A callback procedure to be called in case of errors during packet processing.
    /// </param>
    /// <param name="aPCAPCallBackProgress">
    ///  A callback procedure to be called to report progress during packet processing.
    /// </param>
    /// <param name="aTimeOut">
    ///  Timeout in millisecond for data collection
    /// </param>
    /// <param name="aMaxSizePakcet">
    ///  Max size in byte for capture packet 
    /// </param>
    /// <param name="aTimeRecoStop">
    ///  Time recording stopping 0 disable 
    /// </param>
    procedure AnalyzePCAPRealtime(  const aFilename, aFilter,aInterfaceName,aIP: string;
                                          aPromisc,aSevePcapDump:Boolean;
                                          aTimeOutMs:Integer=1000;
                                          aMaxSizePakcet:Integer = MAX_PACKET_SIZE;
                                          aTimeRecoStop : TTime = 0); 
    
    ///  <summary>
    ///    Saves a list of packets to a pcap file.
    ///  </summary>
    ///  <param name="aPacketList">
    ///    The list of packets to save.
    ///  </param>
    ///  <param name="aFilename">
    ///    The name of the pcap file to save to.
    ///  </param>
    ///
    procedure SavePacketListToPcapFile(aPacketList: TList<PTPacketToDump>; aFilename: String);
    property Abort                  : Boolean                 read FAbort                   write SetAbort;
    property OnPCAPCallBackError    : TPCAPCallBackError      read FOnPCAPCallBackError     write FOnPCAPCallBackError;
    property OnPCAPCallBackProgress : TPCAPCallBackProgress   read FOnPCAPCallBackProgress  write FOnPCAPCallBackProgress;
    property OnPCAPCallBackPacket   : TPCAPCallBackPacket     read FOnPCAPCallBackPacket    write FOnPCAPCallBackPacket;
    property OnPCAPCallBackEnd      : TPCAPCallBackEnd        read FOnPCAPCallBackEnd       write FOnPCAPCallBackEnd; 
    property ThreadCaptureRT        : TPCAPCaptureRT          read FThreadCaptureRT;
  end;

  /// <summary>
  /// This is a function that analyzes a packet. It takes two parameters: a pointer to the packet data and a pointer to the packet header.
  /// </summary>
  /// <param name="aPacketData">A pointer to the packet data.</param>
  /// <param name="aHeader">A pointer to the packet header.</param>
  function AnalyzePacketCallBack(const aPacketData: PByte; aHeader: PTpcap_pkthdr;aGeoLiteDB : TWpcapGEOLITE): PTInternalPacket;


implementation

function AnalyzePacketCallBack(const aPacketData : Pbyte;aHeader:PTpcap_pkthdr;aGeoLiteDB : TWpcapGEOLITE) : PTInternalPacket;
begin
  Result := nil;
  if not Assigned(aPacketData) then Exit;
  
  New(Result); 

  Result.PacketDate := UnixToDateTime(aHeader.ts.tv_sec,false);    
  TWpcapEthHeader.InternalPacket(aPacketData,aHeader.len,FIANADictionary,Result);  

  Result.IP.SrcGeoIP.ASNumber        := String.Empty;
  Result.IP.SrcGeoIP.ASOrganization  := String.Empty;
  Result.IP.SrcGeoIP.Location        := String.Empty;            
  Result.IP.SrcGeoIP.Latitude        := 0;
  Result.IP.SrcGeoIP.Longitude       := 0;

  Result.IP.DestGeoIP.ASNumber       := String.Empty;
  Result.IP.DestGeoIP.ASOrganization := String.Empty;
  Result.IP.DestGeoIP.Location       := String.Empty;            
  Result.IP.DestGeoIP.Latitude       := 0;
  Result.IP.DestGeoIP.Longitude      := 0;
    
  if Assigned(aGeoLiteDB) and aGeoLiteDB.Connection.Connected then
  begin
    if ( Result.Eth.EtherType = ETH_P_IP ) or
       ( Result.Eth.EtherType = ETH_P_IPV6 ) 
    then
    begin
      if IsValidPublicIP(Result.IP.Src) then        
        aGeoLiteDB.GetGeoIPByIp(Result.IP.Src,@Result.IP.SrcGeoIP);
      if IsValidPublicIP(Result.IP.Dst) then        
        aGeoLiteDB.GetGeoIPByIp(Result.IP.Dst,@Result.IP.DestGeoIP);
    end;
  end;
end;

procedure TPCAPUtils.SetAbort(const aValue: Boolean);
begin
  FAbort := aValue;
  if Assigned(FThreadCaptureRT) and aValue then
    FThreadCaptureRT.Stop;
  if Assigned(FThreadLoadFile) and aValue then
    FThreadLoadFile.Stop;    
end;

procedure TPCAPUtils.AnalyzePCAPRealtime( const aFilename, aFilter,aInterfaceName,aIP: string;
                                                aPromisc,aSevePcapDump:Boolean;
                                                aTimeOutMs:Integer=1000;
                                                aMaxSizePakcet:Integer = MAX_PACKET_SIZE;
                                                aTimeRecoStop : TTime = 0 
                                             );
begin
  if not Assigned(FOnPCAPCallBackError) then
    raise Exception.Create('Callback event for error not assigned');

  if aFilename.Trim.IsEmpty then
  begin
    FOnPCAPCallBackError(aFilename,'filename is empty');
    Exit;    
  end;

  if not FileExists(aFilename) then
  begin
    FOnPCAPCallBackError(aFilename,'filename not exists');
    Exit;    
  end;
        
  if not Assigned(FOnPCAPCallBackPacket) then
  begin
    FOnPCAPCallBackError(aFilename,'Callback event for packet not assigned');
    Exit;
  end;

  if aInterfaceName.Trim.IsEmpty then
  begin
    FOnPCAPCallBackError(aFilename,'Interface name is empty');
    Exit;
  end;  

  FThreadCaptureRT                        := TPCAPCaptureRT.Create(self,aFilename, aFilter,aInterfaceName,aIP,aPromisc,aSevePcapDump,aTimeOutMs,aMaxSizePakcet,aTimeRecoStop);
  FThreadCaptureRT.OnPCAPCallBackError    := FOnPCAPCallBackError; 
  FThreadCaptureRT.OnPCAPCallBackProgress := FOnPCAPCallBackProgress;
  FThreadCaptureRT.OnPCAPCallBackPacket   := FOnPCAPCallBackPacket; 
  FThreadCaptureRT.OnTerminate            := DoOnTerminateRT;
  FThreadCaptureRT.FreeOnTerminate        := True;
  FThreadCaptureRT.Start;     
end;

procedure TPCAPUtils.DoOnTerminateRT(sender: Tobject);
begin
  FThreadCaptureRT := nil;
end;

procedure TPCAPUtils.AnalyzePCAPOffline( const aFilename,aFilter:String;aGeoLiteDB : TWpcapGEOLITE);                            
begin
  if not Assigned(FOnPCAPCallBackError) then
    raise Exception.Create('Callback event for error not assigned');

  if aFilename.Trim.IsEmpty then
  begin
    FOnPCAPCallBackError(aFileName,'filename is empty');
    Exit;    
  end;

  if not FileExists(aFilename) then
  begin
    FOnPCAPCallBackError(aFileName,'filename not exists');
    Exit;    
  end;
        
  if not Assigned(FOnPCAPCallBackPacket) then
  begin
    FOnPCAPCallBackError(aFileName,'Callback event for packet not assigned');
    Exit;
  end;

  if not Assigned(FOnPCAPCallBackEnd) then
  begin
    FOnPCAPCallBackError(aFileName,'Callback event for end analyze not assigned');
    Exit;
  end;  

  FThreadLoadFile                        := TPCAPLoadFile.Create(self,aFilename, aFilter,aGeoLiteDB);
  FThreadLoadFile.OnPCAPCallBackError    := FOnPCAPCallBackError; 
  FThreadLoadFile.OnPCAPCallBackProgress := FOnPCAPCallBackProgress;
  FThreadLoadFile.OnPCAPCallBackPacket   := FOnPCAPCallBackPacket; 
  FThreadLoadFile.OnPCAPCallBackEnd      := FOnPCAPCallBackEnd;   
  FThreadLoadFile.OnTerminate            := DoOnTerminateOffline;
  FThreadLoadFile.FreeOnTerminate        := True;
  FThreadLoadFile.Start;      
end;

procedure TPCAPUtils.DoOnTerminateOffline(sender:Tobject);   
begin
  FThreadLoadFile := nil;
end;

procedure TPCAPUtils.SavePacketListToPcapFile(aPacketList: TList<PTPacketToDump>; aFilename: String);
var LPcap        : Ppcap_t;
    LPcapDumper  : ppcap_dumper_t ;
    LPacket      : PByte;
    LPacketHeader: Tpcap_pkthdr;
    I            : Integer;
begin
  LPcap := pcap_open_dead(DLT_EN10MB, MAX_PACKET_SIZE);

  if LPcap = nil then
    raise Exception.Create('Failed to open PCAP');

  Try
    // Open the PCAP file for writing
    LPcapDumper := pcap_dump_open(LPcap, PAnsiChar(AnsiString(aFilename)));

    if LPcapDumper = nil then
      raise Exception.CreateFmt('Failed to open PCAP dump %s',[string(pcap_geterr(LPcap))]);

    try
      // Write each packet in the list to the PCAP file
      for I := 0 to aPacketList.Count -1 do
      begin
        LPacket                  := aPacketList[I].Packet;
        // Get the packet header
        LPacketHeader.ts.tv_sec  := aPacketList[I].tv_sec;
        LPacketHeader.ts.tv_usec := aPacketList[I].tv_sec;
        LPacketHeader.caplen     := aPacketList[I].PacketLen;
        LPacketHeader.len        := aPacketList[I].PacketLen;

        // Write the packet header and data to the PCAP file
        pcap_dump(LPcapDumper, @LPacketHeader, LPacket);
      end;
    finally
      // Close the PCAP file
      pcap_dump_close(LPcapDumper);
    end;
  Finally
    pcap_close(LPcap);
  End;
end;


{ TThreaPcap }
procedure TThreaPcap.DoError(const aFileName, aErrorMessage: string);
begin
  TThread.Synchronize(nil,
    procedure
    begin         
        OnPCAPCallBackError(aFileName,aErrorMessage);
    end);  
end;

procedure TThreaPcap.DoProgress(aTotalSize,aCurrentSize:Int64);
begin
  TThread.Synchronize(nil,
    procedure
    begin    
      if Assigned(OnPCAPCallBackProgress) then
        OnPCAPCallBackProgress(aTotalSize,aCurrentSize);
    end);        
end;

procedure TThreaPcap.Stop;
begin
  Fabort := True;
end;

procedure TThreaPcap.DoPacket(const aInternalPacket : PTInternalPacket);
begin
  TThread.Synchronize(nil,
    procedure
    begin                    
      OnPCAPCallBackPacket(aInternalPacket);
    end);
end;

{ TPCAPUtilsThread }

function PacketHandlerRealtime ( aUser: PAnsiChar;const aHeader: PTpcap_pkthdr;const aPacketData: Pbyte): Integer; 
var PacketBuffer     : TBytes;
    LPacketLen       : Word;
    aNewHeader       : PTpcap_pkthdr;
    LTInternalPacket : PTInternalPacket;
begin
  if Assigned(aPacketData) then
  begin
    LPacketLen  := wpcapntohs(aHeader^.len);
    TPCAPCaptureRT(aUser).DoProgress(-1,LPacketLen); 
    new(aNewHeader);
    Try
      aNewHeader.ts     := aHeader.ts;
      aNewHeader.caplen := (aHeader.caplen);

      SetLength(PacketBuffer,LPacketLen);
      Move(aPacketData^, PacketBuffer[0], LPacketLen);
      
      if RemovePendingBytesFromPacketData(PacketBuffer,LPacketLen) then
      begin
        SetLength(PacketBuffer,LPacketLen);
      end;
      aNewHeader.len   := LPacketLen ;
      LTInternalPacket := AnalyzePacketCallBack(@PacketBuffer[0],aNewHeader,nil);
      
      if Assigned(LTInternalPacket) then
      begin
        Try
          TPCAPCaptureRT(aUser).DoPacket(LTInternalPacket);
        finally
          Dispose(LTInternalPacket)
        end; 
      end;              
    Finally
      dispose(aNewHeader);
    End;
  end;
  
  if ( TPCAPCaptureRT(aUser).Abort) or 
      ( ( TPCAPCaptureRT(aUser).FTimeRecCheck>0 ) and (Now> TPCAPCaptureRT(aUser).FTimeRecCheck) ) 
  then
    pcap_breakloop(TPCAPCaptureRT(aUser).PCapRT);                             

  Result := 0;
end;

constructor TPCAPCaptureRT.Create(const aOwner: Tobject;const aFilename, aFilter, aInterfaceName,aIP: string; aPromisc, aSavePcapDump: Boolean; aTimeoutMs,aMaxSizePacket: Integer; aTimeRecoStop: TTime);
begin
  inherited Create(True);
  FFilename      := aFilename;
  FOwner         := aOwner;
  FFilter        := aFilter;
  FInterfaceName := aInterfaceName;
  FIP            := aIP;
  FPromisc       := aPromisc;
  FSavePcapDump  := aSavePcapDump;
  FTimeoutMs     := aTimeoutMs;
  FMaxSizePacket := aMaxSizePacket;
  FTimeRecoStop  := aTimeRecoStop;
  FAbort         := False;
end;

procedure TPCAPCaptureRT.Execute;
var Lerrbuf      : array[0..PCAP_ERRBUF_SIZE-1] of AnsiChar;
    LPcapDumper  : ppcap_dumper_t;
    LLoopResult  : Integer;
begin
  inherited;
  FTimeRecCheck := 0;
  if FTimeRecoStop > 0 then
  begin
    FTimeRecCheck := now;
    ReplaceTime(FTimeRecCheck,FTimeRecoStop);    
    if CompareTime(FTimeRecoStop,now) <> GreaterThanValue then
      FTimeRecCheck := IncDay(FTimeRecCheck,1)
  end;
  
  // Open the network adapter for capturing
  FPcapRT := pcap_open_live(PAnsiChar(AnsiString(FInterfaceName)), FMaxSizePacket, ifthen(FPromisc,1,0), FTimeOutMs, Lerrbuf);
  if not Assigned(FPcapRT) then
  begin
    DoError(FFilename,Format('Error opening network adapter: %s', [Lerrbuf]));
    Exit;
  end;
  
  Try          
    // Open the PCAP file for writing
    if FSavePcapDump then    
    begin
      LPcapDumper := pcap_dump_open(FPcapRT, PAnsiChar(AnsiString(ChangeFileExt(FFilename,'.pcap'))));

      if LPcapDumper = nil then
      begin
        DoError(FFilename,Format('Failed to open PCAP dump %s',[string(pcap_geterr(FPcapRT))]));
        Exit;
      end;      
    end;

    Try  
      
      //5mb todo by parameter???
      if  pcap_set_buffer_size(FPcapRT,5*1024*1024) = -1 then
      begin
        DoError(FFilename,Format('Failed to set buffer size %s',[string(pcap_geterr(FPcapRT))]));
        exit;      
      end;

      // Set the packet filter if one was provided
      if not CheckWPcapFilter(FPcapRT,FFilename,FFilter,FIP,DoError) then exit;

      FDataLink  := pcap_datalink(FPCapRT);
      
      if pcap_set_datalink(FPCapRT,FDataLink) = -1 then
      begin
        DoError(FFilename,Format('Failed to set datalink %s',[string(pcap_geterr(FPcapRT))]));
        exit;      
      end;

      // Start capturing packets and writing them to the output file
      LLoopResult := pcap_loop(FPcapRT, -1, @PacketHandlerRealtime, PAnsiChar(Self));
      case LLoopResult  of
        0  :; //Cnt end
        -1 : DoError(FFilename,Format('pcap_loop ended because of an error %s',[string(pcap_geterr(FPcapRT))])); 
        -2 : //Normal
      else
         DoError(FFilename,Format('pcap_loop ended unknow return code [%d] error %s',[LLoopResult,string(pcap_geterr(FPcapRT))]));
      end;

    Finally
      // Close the output file and the network adapter
      if FSavePcapDump then     
        pcap_dump_close(LPcapDumper);
    End;        
  Finally
    pcap_close(FPcapRT);
  End;
end;

{ TPCAPLoadFile }
constructor TPCAPLoadFile.Create(const aOwner: Tobject; const aFilename,aFilter:String; aGeoLiteDB: TWpcapGEOLITE);
begin
  inherited Create(True);
  FFilename      := aFilename;
  FOwner         := aOwner;
  FFilter        := aFilter;
  FGeoLiteDB     := aGeoLiteDB;
end;

procedure TPCAPLoadFile.Execute;
var LHandlePcap      : Ppcap_t;
    LErrbuf          : array[0..PCAP_ERRBUF_SIZE-1] of AnsiChar;
    LHeader          : PTpcap_pkthdr;
    LPktData         : PByte;
    LResultPcapNext  : Integer;
    LLenAnalyze      : Int64;
    LTolSizePcap     : Int64;
    LTInternalPacket : PTInternalPacket;
begin
  FAbort               := False;
  LTolSizePcap         := FileGetSize(FFileName);  
  LLenAnalyze          := 0;
  DoProgress(LTolSizePcap,0);
  
  LHandlePcap := pcap_open_offline(PAnsiChar(AnsiString(FFileName)), LErrbuf);
  
  if LHandlePcap = nil then
  begin
    FOnPCAPCallBackError(FFileName,string(LErrbuf));
    Exit;
  end;
  
  try
    if not CheckWPcapFilter(LHandlePcap,FFileName,FFilter,String.Empty,FOnPCAPCallBackError) then exit;
    // Loop over packets in PCAP file
    while True do
    begin
      if Terminated then exit;
      
      // Read the next packet
      LResultPcapNext := pcap_next_ex(LHandlePcap, LHeader, @LPktData);
      case LResultPcapNext of
        1:  // packet read correctly
          begin      
            LTInternalPacket := AnalyzePacketCallBack(LPktData,LHeader,FGeoLiteDB);              
            if Assigned(LTInternalPacket) then
            begin
              Try
                DoPacket(LTInternalPacket);
              finally
                Dispose(LTInternalPacket)
              end; 
            end;   
            Inc(LLenAnalyze,LHeader^.Len);
            DoProgress(LTolSizePcap,LLenAnalyze);

            if FAbort then break;
            
          end;
        0: 
          begin
            // No packets available at the moment
            Continue;
          end;
        -1: 
          begin
            // Error reading packet
            DoError(FFileName,string(pcap_geterr(LHandlePcap)));
            Break;
          end;
        -2:
          begin
            // No packets available, the pcap file instance has been closed
            DoProgress(LTolSizePcap,LTolSizePcap);

            TThread.Synchronize(nil,
              procedure
              begin              
                 FOnPCAPCallBackEnd(FFileName);
              end);
            Break;
          end;
      end;
    end;
  finally
    // Close PCAP file
    pcap_close(LHandlePcap);
  end;
end;

end.

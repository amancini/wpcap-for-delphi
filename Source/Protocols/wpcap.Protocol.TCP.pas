unit wpcap.Protocol.TCP;

interface

uses
  wpcap.Conts, wpcap.Types, wpcap.BufferUtils, System.Types, wpcap.Protocol.Base,
  System.Variants, System.SysUtils, wpcap.StrUtils,winsock;

type
  //https://datatracker.ietf.org/doc/html/rfc793#page-15

{    0                   1                   2                   3
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |          Source Port          |       Destination Port        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                        Sequence Number                        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                    Acknowledgment Number                      |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |  Data |           |U|A|P|R|S|F|                               |
   | Offset| Reserved  |R|C|S|S|Y|I|            Window             |
   |       |           |G|K|H|T|N|N|                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |           Checksum            |         Urgent Pointer        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                    Options                    |    Padding    |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                             data                              |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

}


  TCPHdr = packed record
    SrcPort   : Word;     // TCP source port
    DstPort   : Word;     // TCP destination port
    SeqNum    : DWORD;    // TCP sequence number
    AckNum    : DWORD;    // TCP acknowledgment number
    DataOff   : Byte;     // TCP data offset (number of 32-bit words in header)
    Flags     : Byte;     // TCP flags (SYN, ACK, FIN, etc.)
    WindowSize: Word;     // TCP window size
    Checksum  : Word;     // TCP checksum
    UrgPtr    : Word;     // TCP urgent pointer
  end;
  PTCPHdr = ^TCPHdr;


  /// <summary>
  /// Base class for all protocols that use the TCP stands for Transmission Control Protocol. (TCP).
  /// This class extends the TWPcapProtocolBase class with TCP-specific functions.
  /// </summary>
  TWPcapProtocolBaseTCP = Class(TWPcapProtocolBase)
  private
  protected
    class function GetDataOFFSetBytes(const aDataOFFset: Byte): integer; 

  protected
    /// <summary>
    /// Checks whether the length of the payload is valid for the protocol.
    /// This function is marked as virtual, which means that it can be overridden by subclasses.
    /// </summary>
    class function PayLoadLengthIsValid(const aTCPPtr: PTCPHdr;const aPacketData:PByte;aPacketSize:Word): Boolean; virtual;    
  public
    class function AcronymName: String; override;
    class function DefaultPort: Word; override;
    class function HeaderLength(aFlag:Byte): word; override;
    class function IDDetectProto: byte; override;
    /// <summary>
    /// Returns the length of the TCP payload.
    /// </summary>
    class function TCPPayLoadLength(const aTCPPtr: PTCPHdr;const aPacketData:PByte;aPacketSize:Word): Word; static;

    /// <summary>
    /// Checks whether the packet is valid for the protocol.
    /// This function is marked as virtual, which means that it can be overridden by subclasses.
    /// </summary>
    class function IsValid(const aPacket:PByte;aPacketSize:Integer;var aAcronymName: String;var aIdProtoDetected: Byte): Boolean; virtual;

    /// <summary>
    /// Returns the source port number for the TCP packet.
    /// </summary>
    class function SrcPort(const aTCPPtr: PTCPHdr): Word; static;

    /// <summary>
    /// Returns the destination port number for the TCP packet.
    /// </summary>
    class function DstPort(const aTCPPtr: PTCPHdr): Word; static;   
    /// <summary>
    /// Checks whether the packet has the default port for the protocol.
    /// </summary>
    class function IsValidByDefaultPort(aDstPort: Integer; var aAcronymName: String;var aIdProtoDetected: Byte): Boolean;overload;    

    /// <summary>
    /// Extracts the TCP header from a packet and returns it through aPHeader.
    /// </summary>
    /// <param name="aData">Pointer to the start of the packet.</param>
    /// <param name="aSize">Size of the packet.</param>
    /// <param name="aPHeader">Pointer to the TCP header.</param>
    /// <returns>True if the TCP header was successfully extracted, False otherwise.</returns>
    class function HeaderTCP(const aData: PByte; aSize: Integer; var aPTCPHdr: PTCPHdr): Boolean;static;

    /// <summary>
    /// Returns a pointer to the payload of the provided TCP data.
    /// </summary>
    /// <param name="AData">The TCP data to extract the payload from.</param>
    /// <param name="aSize">Size of packet</param>
    /// <returns>A pointer to the beginning of the TCP payload.</returns>
    class function GetTCPPayLoad(const AData: PByte;aSize: word): PByte;static;  

    ///  <summary>
    ///    Analyzes a TCP protocol packet to determine its acronym name and protocol identifier.
    ///  </summary>
    ///  <param name="aData">
    ///    A pointer to the packet data to analyze.
    ///  </param>
    ///  <param name="aSize">
    ///    The size of the packet data.
    ///  </param>
    ///  <param name="aArcronymName">
    ///    An output parameter that will receive the acronym name of the detected protocol.
    ///  </param>
    ///  <param name="aIdProtoDetected">
    ///    An output parameter that will receive the protocol identifier of the detected protocol.
    ///  </param>
    ///  <returns>
    ///    True if a supported protocol was detected, False otherwise.
    ///  </returns>
    class function AnalyzeTCPProtocol(const aData:Pbyte;aSize:Integer;var aArcronymName:String;var aIdProtoDetected:Byte):boolean;static;  
    class function GetTCPFlagsV6(Flags: Byte): string;static;
    class function HeaderToString(const aPacketData: PByte; aPacketSize: Integer;AListDetail: TListHeaderString): Boolean;override;      
  end;      



implementation

uses wpcap.Level.Ip,wpcap.protocol;

class function TWPcapProtocolBaseTCP.DefaultPort: Word;
begin
  Result := 0; 
end;

class function TWPcapProtocolBaseTCP.IDDetectProto: byte;
begin
  Result := DETECT_PROTO_TCP;
end;

class function TWPcapProtocolBaseTCP.HeaderLength(aFlag:Byte): word;
begin
  Result := SizeOf(TCPHdr)
end;

class function TWPcapProtocolBaseTCP.AcronymName: String;
begin
  Result := 'TCP';
end;

class function TWPcapProtocolBaseTCP.AnalyzeTCPProtocol(const aData:Pbyte;aSize:Integer;var aArcronymName:String;var aIdProtoDetected:Byte):boolean;
var LTCPPPtr        : PTCPHdr;
    I              : Integer;
begin
  Result := False;
  if not HeaderTCP(aData,aSize,LTCPPPtr) then exit;
  
  aIdProtoDetected := DETECT_PROTO_TCP;

  for I := 0 to FListProtolsTCPDetected.Count-1 do
  begin
    if FListProtolsTCPDetected[I].IsValid(aData,aSize,aArcronymName,aIdProtoDetected) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

{ TWPcapProtocolBaseTCP }
class function TWPcapProtocolBaseTCP.PayLoadLengthIsValid(const aTCPPtr: PTCPHdr;const aPacketData:PByte; aPacketSize:Word): Boolean;
var DataOffset: Integer;
begin
   // Get the data offset in bytes
   DataOffset := GetDataOFFSetBytes(aTCPPtr^.DataOff)*4;
   // Get the data offset in bytes
   Result     := aPacketSize - TWpcapIPHeader.EthAndIPHeaderSize(aPacketData,aPacketSize) > DataOffset;
end;

class function TWPcapProtocolBaseTCP.TCPPayLoadLength(const aTCPPtr: PTCPHdr;const aPacketData:PByte;aPacketSize:Word): Word;
var DataOffset: Integer;
begin
   // Get the data offset in bytes
   DataOffset := GetDataOFFSetBytes(aTCPPtr^.DataOff)*4;
  // Calculate the length of the payload
  Result := aPacketSize - TWpcapIPHeader.EthAndIPHeaderSize(aPacketData,aPacketSize)-DataOffset;
end;

class function TWPcapProtocolBaseTCP.IsValid(const aPacket:PByte;aPacketSize:Integer;var aAcronymName: String;var aIdProtoDetected: Byte): Boolean;
var LTCPPtr: PTCPHdr;
begin
  Result := False;    
  if not HeaderTCP(aPacket,aPacketSize,LTCPPtr) then exit;   
  if not PayLoadLengthIsValid(LTCPPtr,aPacket,aPacketSize) then  Exit;

  Result := IsValidByDefaultPort(DstPort(LTCPPtr),aAcronymName,aIdProtoDetected)
end;

class function TWPcapProtocolBaseTCP.SrcPort(const aTCPPtr: PTCPHdr): Word;
begin
  Result := wpcapntohs(aTCPPtr.SrcPort);
end;

class function TWPcapProtocolBaseTCP.DstPort(const aTCPPtr: PTCPHdr): Word;
begin
  Result := wpcapntohs(aTCPPtr.DstPort);
end;

class function TWPcapProtocolBaseTCP.IsValidByDefaultPort(aDstPort: Integer;
  var aAcronymName: String; var aIdProtoDetected: Byte): Boolean;
begin
  Result := False;
  if DefaultPort = 0 then Exit;
  
   Result := ( aDstPort = DefaultPort );

   if not Result then exit;

   aAcronymName     := AcronymName;
   aIdProtoDetected := IDDetectProto;   
end;

class function TWPcapProtocolBaseTCP.GetTCPPayLoad(const AData: PByte; aSize: word): PByte;
var LTCPHeader : PTCPhdr;
    DataOffset : word;   
begin
  HeaderTCP(AData,aSize,LTCPHeader);
  DataOffset := GetDataOFFSetBytes( LTCPHeader^.DataOff)*4+1;
  Result     := AData + TWpcapIPHeader.EthAndIPHeaderSize(AData,aSize) +  DataOffset-1; 
end;

class function TWPcapProtocolBaseTCP.GetDataOFFSetBytes(const aDataOFFset:Byte):integer;
begin 
  Result := aDataOFFset shr 4;
end;

class function TWPcapProtocolBaseTCP.HeaderTCP(const aData: PByte; aSize: Integer; var aPTCPHdr: PTCPHdr): Boolean;
var aSizeEthAndIP: Word;
begin
  Result        := False;
  aSizeEthAndIP := TWpcapIPHeader.EthAndIPHeaderSize(AData,aSize);
  // Check if the data size is sufficient for the Ethernet, IP, and TCP headers
  if (aSize < aSizeEthAndIP + SizeOf(TCPHdr)) then Exit;
  
    // Parse the Ethernet header
  case TWpcapIPHeader.IpClassType(aData,aSize) of
    imtIpv4 : 
      begin
        // Parse the IPv4 header
        if TWpcapIPHeader.HeaderIPv4(aData,aSize).Protocol <> IPPROTO_TCP then Exit;

        // Parse the UDP header
        aPTCPHdr := PTCPHdr(aData + TWpcapIPHeader.EthAndIPHeaderSize(AData,aSize));
        Result   := True;     
      end;
   imtIpv6:
      begin
        if TWpcapIPHeader.HeaderIPv6(aData,aSize).NextHeader <> IPPROTO_TCP then Exit;
        // Parse the TCP header
        aPTCPHdr := PTCPHdr(aData + TWpcapIPHeader.EthAndIPHeaderSize(AData,aSize));
        Result   := True;
      end;      
  end;
end;

class function TWPcapProtocolBaseTCP.GetTCPFlagsV6(Flags: Byte): string;
begin
  Result := String.Empty;
  if Flags and $80 > 0 then Result := Result + 'CWR,';
  if Flags and $40 > 0 then Result := Result + 'ECE,';
  if Flags and $20 > 0 then Result := Result + 'URG,';
  if Flags and $10 > 0 then Result := Result + 'ACK,';
  if Flags and $08 > 0 then Result := Result + 'PSH,';
  if Flags and $04 > 0 then Result := Result + 'RST,';
  if Flags and $02 > 0 then Result := Result + 'SYN,';
  if Flags and $01 > 0 then Result := Result + 'FIN,';
  if Result <> '' then
    Result := Copy(Result, 1, Length(Result) - 1);
end;


class function TWPcapProtocolBaseTCP.HeaderToString(const aPacketData: PByte;aPacketSize: Integer; AListDetail: TListHeaderString): Boolean;
var LPTCPHdr  : PTCPHdr;
    LesBits   : Integer;
begin
  Result := False;
  if not HeaderTCP(aPacketData,aPacketSize,LPTCPHdr) then exit;
  
  AListDetail.Add(AddHeaderInfo(0,Format('Transmission Control Protocol, Src Port: %d, Dst %d: 80, Seq: %d, Ack: %d, Len: %s',[SrcPort(LPTCPHdr),DstPort(LPTCPHdr),
                                   ntohl(LPTCPHdr.SeqNum),ntohl(LPTCPHdr.AckNum),SizeTostr(LPTCPHdr.DataOff shr 4)]),null,nil,0));  
  AListDetail.Add(AddHeaderInfo(1,'Header length:',SizeToStr(GetDataOFFSetBytes(LPTCPHdr^.DataOff) *4),PByte(@LPTCPHdr.DataOff),2));              
  AListDetail.Add(AddHeaderInfo(1,'Source:',wpcapntohs(LPTCPHdr.SrcPort),PByte(@LPTCPHdr.SrcPort),SizeOf(LPTCPHdr.SrcPort)));    
  AListDetail.Add(AddHeaderInfo(1,'Destination:',wpcapntohs(LPTCPHdr.DstPort),PByte(@LPTCPHdr.DstPort),SizeOf(LPTCPHdr.DstPort)));      
  AListDetail.Add(AddHeaderInfo(1,'Sequence number(RAW):',wpcapntohl(LPTCPHdr.SeqNum),PByte(@LPTCPHdr.SeqNum),SizeOf(LPTCPHdr.SeqNum)));      
  AListDetail.Add(AddHeaderInfo(1,'Acknowledgment number(RAW):',wpcapntohl(LPTCPHdr.AckNum),PByte(@LPTCPHdr.AckNum),SizeOf(LPTCPHdr.AckNum)));        
  AListDetail.Add(AddHeaderInfo(1,'Data offset:',GetDataOFFSetBytes(LPTCPHdr^.DataOff),PByte(@LPTCPHdr.DataOff),2));          
  LesBits := (LPTCPHdr.DataOff and $0F) shl 2; 
  AListDetail.Add(AddHeaderInfo(1,'Reserved bits:',LesBits,PByte(LesBits),2));          
  AListDetail.Add(AddHeaderInfo(1,'Flags:',GetTCPFlagsV6(LPTCPHdr.Flags),PByte(@LPTCPHdr.Flags),SizeOf(LPTCPHdr.Flags)));   
  AListDetail.Add(AddHeaderInfo(1,'Window size:',wpcapntohs(LPTCPHdr.WindowSize),PByte(@LPTCPHdr.WindowSize),SizeOf(LPTCPHdr.WindowSize)));        
  AListDetail.Add(AddHeaderInfo(1,'Checksum:',wpcapntohs(LPTCPHdr.Checksum),PByte(@LPTCPHdr.Checksum),SizeOf(LPTCPHdr.Checksum)));        
  AListDetail.Add(AddHeaderInfo(1,'Urgent pointer:',wpcapntohs(LPTCPHdr.UrgPtr),PByte(@LPTCPHdr.UrgPtr),SizeOf(LPTCPHdr.UrgPtr)));   
  AListDetail.Add(AddHeaderInfo(1,'Payload length:',SizeToStr(TCPPayLoadLength(LPTCPHdr,aPacketData,aPacketSize)),PByte(@LPTCPHdr.UrgPtr),SizeOf(LPTCPHdr.UrgPtr)));     

  {TODO OPTIONS}
  Result := True;       
end;

end.

﻿unit wpcap.wrapper;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  wpcap.Types,WinSock;

  
//*******************************************************************************************************
//*                                                                                                     *
//*                                  WPPCAP.DLL                                                         *
//*                                                                                                     * 
//*******************************************************************************************************


/// <summary>
/// PacketSendPackets is a function that allows you to send a burst of packets
/// through a network adapter. The function accepts the following parameters:
///
/// AdapterObject: Network adapter handle to send packets to.
/// PacketBurst : pointer to a PacketBurst structure that contains the packets to send.
/// sync : When set to TRUE, the function waits for packets to finish sending before returning control to the caller. If set to FALSE,
///
/// the function returns immediately after starting sending packets.
///
/// The function returns TRUE if the operation completed successfully, FALSE otherwise.
/// </summary>
function PacketSendPackets(AdapterObject: THandle; PacketBurst: PPacketBurst; Sync: boolean): boolean;overload; stdcall; external 'wpcap.dll';

/// <summary>
/// The PacketGetNetInfoEx function allows you to get information about the network configuration of a specific adapter.
/// The function accepts the following parameters:
///
/// AdapterObject: Network adapter handle to get information for.
/// lpNetInfo    : A TNetInfoEx structure that is filled with information about the network configuration of the adapter.
///
/// The function returns TRUE if the operation completed successfully, FALSE otherwise.
/// </summary>
function PacketGetNetInfoEx(AdapterObject: THandle; var lpNetInfo: TNetInfoEx): boolean;overload; stdcall; external 'wpcap.dll';

/// <summary>
/// PacketSetModeEx is a function defined in the WinPcap library which is used to set the packet capture mode on a specific network adapter.
/// The function has the following parameters:
///
/// AdapterObject: Network adapter object to set capture mode on.
/// Mode         : Packet capture mode to set on the network adapter. It can take one of the following values:
/// MODE_CAPT    : Capture packets arriving on the physical side of the network adapter.
/// MODE_STAT    : Capture packets passing through the network stack, but not packets arriving on the physical side of the network adapter.
/// MODE_MON     : Monitor mode, used to capture traffic in promiscuous mode.
/// Mode2        : Boolean value that specifies whether the function should return information about the capture mode set on the network adapter. If TRUE, the function will return the requested information in a PPACKET_OID_DATA structure. If it is FALSE, the function will not return any information.
///
/// The function returns a boolean value indicating whether the capture mode setting operation was successful.
/// </summary>
function PacketSetModeEx(AdapterObject: THandle; Mode: ULONG; Mode2: BOOL): BOOL; stdcall;external 'wpcap.dll';

/// <summary>
/// This function allows you to set the packet capture mode for a specific adapter.
/// If mode is set to TRUE, the driver captures packets in promiscuous mode, otherwise in non-promiscuous mode.
///
/// The function returns TRUE if the operation completed successfully, FALSE otherwise.
/// </summary>
function PacketSetMode(AdapterObject: THandle; mode: boolean): boolean; stdcall; external 'wpcap.dll';

/// <summary>
/// Purpose: pcap_next_ex returns the next packet available on the buffer. 
/// If successful, the function returns 1, and pkt_header and pkt_data point to the captured 
/// packet’s libpcap capture information header and the packet, respectively. 
///
/// If not successful,the function returns
/// 0 if the timeout expired,
/// -1 if an error occurred reading the packet, 
/// or -2 
/// if the packet is being read from a saved file and there are no more packets to read.
/// </summary>
function pcap_next_ex(p: Ppcap_t;var pkt_header: PTpcap_pkthdr; pkt_data: PByte): Integer; cdecl; external 'wpcap.dll';

///<summary>
/// Returns a pointer to the error message for the last pcap library error that occurred on the pcap_t descriptor specified.
///</summary>
///<param name="p">
/// A pointer to the pcap_t structure from which to retrieve the error message.
///</param>
///<returns>
/// A pointer to a string containing the error message for the last pcap library error that occurred on the pcap_t descriptor specified.
///</returns>
///<remarks>
/// This function retrieves a pointer to a string containing the error message for the last pcap library error that occurred on the pcap_t descriptor specified. 
// If no error has occurred, the function returns a null pointer.
///</remarks>
function pcap_geterr(p: ppcap_t): PAnsiChar; cdecl; external 'wpcap.dll';  

///<summary>
/// Opens a saved capture file for offline processing.
///</summary>
///<param name="fname">
/// A pointer to a string containing the name of the capture file to open.
///</param>
///<param name="errbuf">
/// A pointer to a buffer that will hold the error message if an error occurs.
///</param>
///<returns>
/// A pointer to a pcap_t structure for the opened capture file, or a null pointer if an error occurred.
///</returns>
///<remarks>
/// This function opens the specified capture file for offline processing and returns a pointer to a pcap_t structure that can be used to read packets from the file. If an error occurs, the function returns a null pointer and the error message is written to the specified error buffer. The caller is responsible for freeing the resources associated with the pcap_t structure using the pcap_close function when processing is complete.
///</remarks>
function pcap_open_offline(const fname: PAnsiChar; errbuf: PAnsiChar): Ppcap_t; cdecl; external 'wpcap.dll';

///<summary>
/// Closes the specified pcap_t descriptor.
///</summary>
///<param name="p">
/// A pointer to the pcap_t descriptor to close.
///</param>
///<remarks>
/// This procedure closes the specified pcap_t descriptor. 
/// If the descriptor is currently capturing packets, the capture process will be terminated.
///</remarks>
procedure pcap_close(p: Ppcap_t); cdecl; external 'wpcap.dll';


///<summary>
/// Sets a filter for the captured packets using an instance of WinPcap.
///</summary>
/// <param name="AdapterObject">The handle of the instance of WinPcap.</param>
/// <param name="fp">The input must be a pointer to the bpf_program structure that contains the compiled filter.</param>
/// <returns>A boolean value that indicates whether the operation was successful.</returns>
function pcap_setfilter(AdapterObject: Ppcap_t; fp: PBPF_program): LongInt; stdcall; external 'wpcap.dll';

function pcap_compile(p: Ppcap_t;var fp: PBPF_program; str: PAnsiChar; optimize: Integer; netmask: UInt32): Integer; cdecl; external 'wpcap.dll';




//******************************************************************************************************
//*                                                                                                     *
//*                                  PACKET.DLL                                                         *
//*                                                                                                     * 
//*******************************************************************************************************

///<summary>
/// Returns the version string of the Packet library.
///</summary>
///<returns>
/// A pointer to a string containing the version of the Packet library.
///</returns>
///<remarks>
/// This function returns a pointer to a string containing the version of the Packet library in use.
///</remarks>
function PacketGetVersion: PAnsiChar; stdcall; external 'Packet.dll';

///<summary>
/// Returns the version of the NPF driver.
///</summary>
///<returns>
/// The version number of the NPF driver.
///</returns>
///<remarks>
/// This function returns the version number of the NPF driver in use.
///</remarks>
function PacketGetDriverVersion: ULONG; stdcall; external 'Packet.dll';



//*******************************************************************************************************
//*                                                                                                     *
//*                {TODO CHECK ISSUE IN PARAMETER AND TEST AND DLL NAME}                                *
//*                                                                                                     * 
//*******************************************************************************************************


function PacketOpenAdapter(adapter: PAnsiChar): THandle; stdcall; external 'wpcap.dll';
function PacketCloseAdapter(Adapter: THandle): boolean; stdcall; external 'wpcap.dll';
function PacketRequest(Adapter: THandle; SetTo: boolean; OID: ULONG; Buffer: Pointer): boolean;overload; stdcall; external 'wpcap.dll';
function PacketGetAdapterNames(AdaptersName: Pointer; var Length: ULONG): ULONG; stdcall; external 'wpcap.dll';
function PacketGetNetType(Adapter: THandle; NetType: PULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetNetTypeEx(Org: PAnsiChar; var Otype: ULONG; var Desc: PAnsiChar; var DLen: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetReadTimeout(Adapter: THandle; Timeout: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetDumpFile(Adapter: THandle; fname: PAnsiChar; mode: boolean): boolean; stdcall; external 'wpcap.dll';
function PacketSetDumpFileLimits(Adapter: THandle; maxfilesize, maxnumpackets: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetUserLevel(Value: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetProtocolEx(Adapter: THandle; Protocol: ULONG; Filter: Pointer; Mode: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetNdisEnvironment(Adapter: THandle; read, write: Pointer): boolean; stdcall; external 'wpcap.dll';
function PacketGetReadTimeout(Adapter: THandle): ULONG; stdcall; external 'wpcap.dll';
function PacketSetDumpOpenTimeout(Adapter: THandle; dumpOpenTimeout: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetDumpSize(Adapter: THandle; size: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetStatsEx(Adapter: THandle; ps: PPACKET_OID_STATISTICS; oid: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetBpf(Adapter: THandle; code: Pointer; codelen: Integer): boolean;overload; stdcall; external 'wpcap.dll';
function PacketSetReadEvt(Adapter: THandle): boolean; stdcall; external 'wpcap.dll';
function PacketSetNumReadTimeouts(Adapter: THandle; NumReadTimeouts: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetBpfEx(Adapter: THandle; code: Pointer; codelen: Integer; flags: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetMaxLookaheadsize(Adapter: THandle; Value: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetNonPersistentMode(Adapter: THandle; NonPersistent: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetNonPersistentMode(Adapter: THandle): ULONG; stdcall; external 'wpcap.dll';
function PacketSendQueued(Adapter: THandle; Synchronize: boolean): boolean; stdcall; external 'wpcap.dll';
function PacketSetDriverParameter(Adapter: THandle; Code: ULONG; Value: Pointer; ValueLength: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetDriverParameter(Adapter: THandle; Code: ULONG; Value: Pointer; ValueLength: PULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetDontVerifyChecksum(Adapter: THandle; mode: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetAdapterNamesEx(Name: Pointer; len: PULONG; Buffer: PAnsiChar; BufLen: PULONG): ULONG;overload; stdcall; external 'wpcap.dll';
function PacketGetAdapterNamesAndFlags(Adapter: PChar; Flags: PULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetBinding(hAdapter: THandle; pStr: PAnsiChar; len: PULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetBuff(Adapter: THandle; dim_: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetAdapterMode(Adapter: THandle; var mode: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetDumpFileName(Adapter: THandle; name: PAnsiChar): boolean; stdcall; external 'wpcap.dll';
function PacketSetDumpLimit(Adapter: THandle; dumpLimit: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetStats(Adapter: THandle; s: PPACKET_STATS): boolean; stdcall; external 'wpcap.dll';
function PacketGetStatsEx2(Adapter: THandle; ps: PPACKET_OID_STATISTICS; oid: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketIsDriverLoaded: boolean; stdcall; external 'wpcap.dll';
function PacketGetDriverName(Buffer: PAnsiChar; NameLen: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSendPacket(Adapter: THandle; Buffer: PAnsiChar; Size: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSendPackets(Adapter: THandle; PacketArray: PPACKET; Count: ULONG): ULONG;overload; stdcall; external 'wpcap.dll';
function PacketSetMinToCopy(Adapter: THandle; nbytes: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetReadBuffer(Adapter: THandle; Size: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetTruncation(Adapter: THandle; trunc: boolean): boolean; stdcall; external 'wpcap.dll';
function PacketSetSnapArrival(Adapter: THandle; snapArrival: boolean): boolean; stdcall; external 'wpcap.dll';
function PacketSetSnapLength(Adapter: THandle; snaplen: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetReadMode(Adapter: THandle; mode: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetAdapterModeEx(AdapterName: PAnsiChar; var Flags: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetReadTimeoutEx(Adapter: THandle; timeout: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetUserBufferWithOrderAdapter(Adapter: THandle; OrderAdapter: THandle; Buffer: PAnsiChar; Size: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetNumWrites(Adapter: THandle; NumWrites: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetSessionMode(Adapter: THandle; Mode: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetDriverType(DriverType: PULONG): boolean; stdcall; external 'wpcap.dll';
function PacketIsLoopbackAdapter(AdapterName: PAnsiChar; b: PBOOL): boolean; stdcall; external 'wpcap.dll';
function PacketGetDriverVersionString(VersionString: PAnsiChar; Length: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetDriverDirectory(Directory: PAnsiChar; Length: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketIsNdis6(Adapter: THandle; p: PULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetRmonAdapterStats(Adapter: THandle; RmonStats: PRMON_STATS): boolean; stdcall; external 'wpcap.dll';
function PacketGetDriverLevel(PacketDriverLevel: PULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetBpf(Adapter: THandle; SetToBpf: boolean): boolean;overload; stdcall; external 'wpcap.dll';
function PacketGetWanStatus(Adapter: THandle; Status: PULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetSyncMode(Adapter: THandle; Sync: boolean): boolean; stdcall; external 'wpcap.dll';
function PacketSetVersionEx(version: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetAdapterNamesEx(Name: Pointer; len: PULONG): ULONG;overload; stdcall; external 'wpcap.dll';
function PacketRequest(AdapterObject: THandle; SetToBpf: boolean): boolean;overload; stdcall; external 'wpcap.dll';
function PacketStartOem(P: PAnsiChar; ReadEvt: THANDLE): boolean; stdcall; external 'wpcap.dll';
function PacketStartNPF(DriverName: PAnsiChar; bAirPcap: boolean): boolean; stdcall; external 'wpcap.dll';
function PacketStop(AdapterObject: THandle): boolean; stdcall; external 'wpcap.dll';
function PacketFlushAdapter(AdapterObject: THandle): boolean; stdcall; external 'wpcap.dll';
function PacketSetRandom(Seed: ULONG; OidData: Pointer; OidLen: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetDriverVersionEx(DriverVersion: PAnsiChar; DriverVersionLength: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetBindingAdInfo(hBind: THandle; pAdInfo: PADAPTER_INFO): boolean; stdcall; external 'wpcap.dll';
function PacketIsolateAdaptersOnSession(Open, Close: boolean): boolean; stdcall; external 'wpcap.dll';
function PacketSendNotification(NotificationSource: ULONG; NotificationDestination: THandle; NotificationType: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketCreateAdapterInformation(AdInfo: PPACKET_OID_DATA; Size: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetHwFilter(AdapterObject: THandle; Filter: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetOidData(AdapterObject: THandle; OidData: PPACKET_OID_DATA; OidDataLength: ULONG; BytesReturned: PULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetOidData(AdapterObject: THandle; OidData: PPACKET_OID_DATA; OidDataLength: ULONG; BytesReturned: PULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetReadEvent(AdapterObject: THandle): THandle; stdcall; external 'wpcap.dll';
function PacketSetAdapterMode(AdapterObject: THandle; Flags: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetNumRecvBuffers(AdapterObject: THandle; NumToAlloc: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetMacAddresses(AdapterName: PAnsiChar; MacAddr: PAnsiChar): ULONG; stdcall; external 'wpcap.dll';
function PacketSetAdapterModeEx(AdapterObject: THandle; Flags: ULONG; SizBuf: ULONG; Buffer: Pointer): boolean; stdcall; external 'wpcap.dll';
function PacketGetAdapterNamesWithWan(Name: PAnsiChar; len: PULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetNumRequests(AdapterObject: THandle; NumToAlloc: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetSnaplen(AdapterObject: THandle; Snaplen: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketSetDumpFormat(AdapterObject: THandle; DumpFormat: Packet_Dump_File_Type): boolean; stdcall; external 'wpcap.dll';
function PacketSetBpf(AdapterObject: THandle; Filter: PBPF_program): boolean;overload; stdcall; external 'wpcap.dll';
function PacketSetLoopbackBehavior(AdapterObject: THandle; LoopbackBehavior: ULONG): boolean; stdcall; external 'wpcap.dll';
function PacketGetTME(AdapterObject: THandle; TME: PTimeVal): boolean; stdcall; external 'wpcap.dll';
function PacketSetTME(AdapterObject: THandle; TME: PTimeVal): boolean; stdcall; external 'wpcap.dll';
function PacketSetAdapterIpAddress(AdapterObject: THandle; IpAddress, IpMask: PAnsiChar): boolean; stdcall; external 'wpcap.dll';
function PacketSetMulticastList(AdapterObject: THandle;const  MulticastList: TMulticastList): boolean; stdcall; external 'wpcap.dll';
function PacketGetNetInfoEx(Adapter: PAnsiChar; AdapterInfo: PNETINFOSTRUCT): boolean;overload; stdcall; external 'wpcap.dll';
function PacketSendAdapterNPF(Adapter: THandle;  const Packet: PAnsiChar; PacketSize: Integer): Boolean; stdcall; external 'wpcap.dll';
function PacketGetTimeInterval(): ULONG; stdcall; external 'wpcap.dll';


implementation



end.

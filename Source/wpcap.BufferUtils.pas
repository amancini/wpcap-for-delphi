unit wpcap.BufferUtils;

interface
uses System.SysUtils,winsock2,System.Classes;

/// <summary>
/// Converts an array of bytes to a TBytes dynamic array.
/// </summary>
/// <param name="Bytes">The input byte array.</param>
/// <returns>Returns a TBytes dynamic array containing the same bytes as the input array.</returns>
function BytesToArray(const Bytes: array of Byte): TBytes;

/// <summary>
/// Converts a 16-bit integer from network byte order to host byte order.
/// </summary>
/// <param name="aWord">The input 16-bit integer in network byte order.</param>
/// <returns>Returns the input 16-bit integer in host byte order.</returns>
function wpcapntohs(aWord: Word): word;

function wpcapntohl(aWord: cardinal):Cardinal;

/// <summary>
/// Extracts the byte at the specified index from a 16-bit integer value.
/// </summary>
/// <param name="aWordValue">The input 16-bit integer value.</param>
/// <param name="aByteIndex">The index of the byte to extract (0 or 1).</param>
/// <returns>Returns the byte at the specified index of the input 16-bit integer value.</returns>
function GetByteFromWord(aWordValue: Word; aByteIndex: Integer): Byte;

/// <summary>
/// Gets the value of a single bit at the specified index of a byte value.
/// </summary>
/// <param name="AByteValue">The input byte value.</param>
/// <param name="AIndexBit">The index of the bit to retrieve (0-7).</param>
/// <returns>Returns the value of the specified bit (0 or 1) from the input byte value.</returns>
function GetBitValue(const AByteValue: Byte; const AIndexBit: Byte): Byte;

/// <summary>
/// Converts a byte value to a binary string representation.
/// </summary>
/// <param name="AByte">The input byte value.</param>
/// <returns>Returns a string containing the binary representation of the input byte value.</returns>
function ByteToBinaryString(const AByte: Byte): string;

/// <summary>
/// Converts an integer value to a binary string representation with the specified number of digits.
/// </summary>
/// <param name="Value">The input integer value.</param>
/// <param name="Digits">The number of digits in the binary string representation.</param>
/// <returns>Returns a string containing the binary representation of the input integer value with the specified number of digits.</returns>
function IntToBin(Value: integer; Digits: integer): string;

/// <summary>
/// Calculates the actual length of a packet by checking for any padding bytes (0x0D 0xF0 0xAD 0xBA) at the end of the packet.
/// </summary>
/// <param name="aPacketData">Pointer to the packet data buffer.</param>
/// <param name="aPacketLen">Length of the packet data buffer in bytes.</param>
/// <returns>The actual length of the packet in bytes.</returns>
function RemovePendingBytesFromPacketData(aPacketData: TBytes; var aPacketLen: Word): Boolean;


function GetLastNBit(const ASource: word; const AN: Integer): integer;
function GetFistNBit(const ASource: word; const AN: Integer): integer;
function SwapInt64(Value: Int64): Int64;
function HexToBytes(const hex: string): TBytes;


implementation

function RemovePendingBytesFromPacketData(aPacketData: TBytes; var aPacketLen: Word): Boolean;
var LIdx            : Integer;
    LHasPendingBytes: Boolean;
begin
  Result           := False;
  LHasPendingBytes := False;
                                        
  for LIdx := Low(aPacketData) to High(aPacketData) do
  begin
    if aPacketData[LIdx] = $0D then
    begin
      if (LIdx+3<High(aPacketData))and (aPacketData[LIdx + 1] = $F0) and (aPacketData[LIdx + 2] = $AD) and (aPacketData[LIdx + 3] = $BA) then
      begin
        aPacketLen       := LIdx;
        LHasPendingBytes := True;
        Break;
      end;
    end;
  end;
end;


function SwapInt64(Value: Int64): Int64;
{https://stackoverflow.com/questions/33197523/combining-asm-with-non-asm-code-or-swapint64-asm-function-needed}
{$IF Defined(CPUX86)}
asm
 MOV     EDX,[DWORD PTR EBP + 12]
 MOV     EAX,[DWORD PTR EBP + 8]
 BSWAP   EAX
 XCHG    EAX,EDX
 BSWAP   EAX
end;
{$ELSEIF Defined(CPUX64)}
asm
  MOV    RAX,RCX
  BSWAP  RAX
end;
{$ELSE}
  {$Message Fatal 'Unsupported architecture'}
{$ENDIF}



function BytesToArray(const Bytes: array of Byte): TBytes;
var I: Integer;
begin
  SetLength(Result, Length(Bytes));
  for I := Low(Bytes) to High(Bytes) do
    Result[I] := Bytes[I];
end;

function wpcapntohs(aWord: Word):word;
begin
  result := Winsock2.ntohs(aWord);
end;

function wpcapntohl(aWord: cardinal):Cardinal;
begin
  result := ntohl(aWord);
end;

function GetByteFromWord(aWordValue: Word; aByteIndex: Integer): Byte;
begin
  if (aByteIndex < 0) or (aByteIndex > 1) then
   raise Exception.CreateFmt('GetByteFromWord out of range [%d]',[aByteIndex]);

  Result := (aWordValue shr (aByteIndex * 8)) and $FF
end;

Function GetBitValue(const AByteValue: Byte; const AIndexBit: Byte): Byte;
begin
  if (aIndexBit < 1) or (aIndexBit > 8) then
    raise Exception.CreateFmt('GetBitValue out of range [%d]',[aIndexBit]);

  result := (AByteValue shr (8 - AIndexBit) ) and $01;     
end;

function IntToBin(Value: integer; Digits: integer): string;
var
  i: integer;
begin
  Result := '';
  for i := Digits-1 downto 0 do
    if (Value and (1 shl i)) <> 0 then
      Result := Result + '1'
    else
      Result := Result + '0';
end;

function GetLastNBit(const ASource: word; const AN: Integer): integer;
begin
  Result := ASource and ((1 shl AN) - 1);
end;

function GetFistNBit(const ASource: word; const AN: Integer): integer;
begin
  Result := ASource shr (SizeOf(word) * 8 - AN);
end;

function ByteToBinaryString(const AByte: Byte): string;
begin
  Result := IntToBin(AByte, 8);
end;

function HexToBytes(const hex: string): TBytes;
begin
  SetLength(Result, Length(hex) div 2);
  HexToBin(PChar(hex), @Result[0], Length(Result));
end;


end.

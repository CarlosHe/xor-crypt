unit XORCrypt;

interface

type

  TXORCrypt = class
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    class function Encode(const ASource, AKey: string): string;
    class function Decode(const ASource, AKey: string): string;
  end;

implementation

uses
  System.SysUtils;

{ TXORCrypt }

class function TXORCrypt.Decode(const ASource, AKey: string): string;
var
  I: Integer;
  LChar: Char;
begin
  Result := '';
  for I := 0 to Pred(ASource.Length div 2) do
  begin
    LChar := Char(StrToIntDef('$' + ASource.SubString((I * 2), 2), Ord(' ')));
    if Length(AKey) > 0 then
      LChar := Char(Byte(AKey[1 + (I mod AKey.Length)]) xor Byte(LChar));
    Result := Result + LChar;
  end;
end;

class function TXORCrypt.Encode(const ASource, AKey: string): string;
var
  I: Integer;
  LByte: Byte;
begin
  Result := '';
  for I := 1 to ASource.Length do
  begin
    if Length(AKey) > 0 then
      LByte := Byte(AKey[1 + ((I - 1) mod AKey.Length )]) xor Byte(ASource[I])
    else
      LByte := Byte(ASource[I]);
    Result := Result + IntToHex(LByte, 2).ToLower;
  end;
end;

end.

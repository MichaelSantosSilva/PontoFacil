unit UUtilidadesString;

interface

  type
    TUtilidadesString = class(TObject)
      public
        class function LPad(S: string; Ch: Char; Len: Integer): string;
        class function RPad(S: string; Ch: Char; Len: Integer): string;
    end;


implementation

{ TUtilidadesString }

class function TUtilidadesString.LPad(S: string; Ch: Char;
  Len: Integer): string;
var
  RestLen: Integer;
begin
  Result  := S;
  RestLen := Len - Length(s);
  if (RestLen = 0) then
    Exit;
  if (RestLen < 0) then
  begin
    Result := Copy(S, 1, Len);
    Exit;
  end;
  Result := S + StringOfChar(Ch, RestLen);
end;

class function TUtilidadesString.RPad(S: string; Ch: Char;
  Len: Integer): string;
var
  RestLen: Integer;
begin
  Result  := S;
  RestLen := Len - Length(s);
  if (RestLen = 0) then
    Exit;
  if (RestLen < 0) then
  begin
    Result := Copy(S, 1, Len);
    Exit;
  end;
  Result := StringOfChar(Ch, RestLen) + S;
end;

end.
 
unit URegistroPontoController;

interface

uses SysUtils, URegistroPonto, UDmPrincipal, DBClient, Contnrs, DB;

  type
    TRegistroPontoController = class(TObject)
    private
      constructor InternalCreate;
      function ObterHoraEntrada: TDateTime;
      function ObterHoraFimAlmoco: TDateTime;
      function ObterHoraInicioAlmoco: TDateTime;
      function ObterHoraSaida: TDateTime;
      procedure PreencherData(Data: TDateTime);
      procedure PreencherHoraEntrada(DataHora: TDateTime);
      procedure PreencherHoraInicioAlmoco(DataHora: TDateTime);
      procedure PreencherHoraFimAlmoco(DataHora: TDateTime);
      procedure PreencherHoraSaida(DataHora: TDateTime);
    protected

    public
      constructor Create;
      function ObterListaPorReferencia(Mes, Ano: Integer): TObjectList;
      procedure CarregarPorData(Data: TDateTime; RegistroPonto: TRegistroPonto);
      procedure Gravar(RegistroPonto: TRegistroPonto);
    published
      class function GetInstance: TRegistroPontoController;
    end;


implementation

uses
  DateUtils;

var
  FInstance: TRegistroPontoController;

{ TRegistroPontoController }

constructor TRegistroPontoController.Create;
begin
  raise Exception.Create('Utilize o m�todo GetInstance');
end;

class function TRegistroPontoController.GetInstance: TRegistroPontoController;
begin
  if (not(Assigned(FInstance))) then
    FInstance := InternalCreate;
  Result := FInstance;
end;

constructor TRegistroPontoController.InternalCreate;
begin
  inherited Create;
end;

function TRegistroPontoController.ObterHoraEntrada: TDateTime;
begin
  Result := DmPrincipal.cdsPontoMensalDia.AsDateTime + DmPrincipal.cdsPontoMensalEntrada.AsDateTime;
end;

function TRegistroPontoController.ObterHoraFimAlmoco: TDateTime;
begin
  Result := DmPrincipal.cdsPontoMensalDia.AsDateTime + DmPrincipal.cdsPontoMensalFimAlmoco.AsDateTime;
end;

function TRegistroPontoController.ObterHoraInicioAlmoco: TDateTime;
begin
  Result := DmPrincipal.cdsPontoMensalDia.AsDateTime + DmPrincipal.cdsPontoMensalInicioAlmoco.AsDateTime;
end;

function TRegistroPontoController.ObterHoraSaida: TDateTime;
begin
  Result := DmPrincipal.cdsPontoMensalDia.AsDateTime + DmPrincipal.cdsPontoMensalSaida.AsDateTime;
end;

procedure TRegistroPontoController.CarregarPorData(Data: TDateTime;
  RegistroPonto: TRegistroPonto);
var
  Dia, Mes, Ano: Word;
begin
  DecodeDate(Data, Ano, Mes, Dia);
  DmPrincipal.PrepararDataSetPontoMensal(Mes, Ano);
  if (DmPrincipal.cdsPontoMensal.FindKey([EncodeDate(Ano, Mes, Dia)])) then
  begin
    RegistroPonto.HoraEntrada := ObterHoraEntrada;
    RegistroPonto.HoraInicioIntervalo := ObterHoraInicioAlmoco;
    RegistroPonto.HoraFimIntervalo := ObterHoraFimAlmoco;
    RegistroPonto.HoraSaida := ObterHoraSaida;
  end
  else
  begin
    RegistroPonto.HoraEntrada := Int(Data);
    RegistroPonto.HoraInicioIntervalo := Int(Data);
    RegistroPonto.HoraFimIntervalo := Int(Data);
    RegistroPonto.HoraSaida := Int(Data);
  end;
end;

procedure TRegistroPontoController.Gravar(RegistroPonto: TRegistroPonto);
var
  Dia, Mes, Ano: Word;
begin
  DecodeDate(RegistroPonto.HoraEntrada, Ano, Mes, Dia);
  DmPrincipal.PrepararDataSetPontoMensal(Mes, Ano);
  if (DmPrincipal.cdsPontoMensal.FindKey([EncodeDate(Ano, Mes, Dia)])) then
    DmPrincipal.cdsPontoMensal.Edit
  else
  begin
    DmPrincipal.cdsPontoMensal.Append;
    PreencherData(RegistroPonto.HoraEntrada);
  end;
  PreencherHoraEntrada(RegistroPonto.HoraEntrada);
  PreencherHoraInicioAlmoco(RegistroPonto.HoraInicioIntervalo);
  PreencherHoraFimAlmoco(RegistroPonto.HoraFimIntervalo);
  PreencherHoraSaida(RegistroPonto.HoraSaida);
  DmPrincipal.GravarDataSetPontoMensal(Mes, Ano);
end;

procedure TRegistroPontoController.PreencherData(Data: TDateTime);
begin
  DmPrincipal.cdsPontoMensalDia.AsDateTime := Int(Data);
end;

procedure TRegistroPontoController.PreencherHoraEntrada(
  DataHora: TDateTime);
begin
  DmPrincipal.cdsPontoMensalEntrada.AsDateTime := DataHora -  DmPrincipal.cdsPontoMensalDia.AsDateTime;
end;

procedure TRegistroPontoController.PreencherHoraFimAlmoco(
  DataHora: TDateTime);
begin
  DmPrincipal.cdsPontoMensalFimAlmoco.AsDateTime := DataHora -  DmPrincipal.cdsPontoMensalDia.AsDateTime;
end;

procedure TRegistroPontoController.PreencherHoraInicioAlmoco(
  DataHora: TDateTime);
begin
  DmPrincipal.cdsPontoMensalInicioAlmoco.AsDateTime := DataHora -  DmPrincipal.cdsPontoMensalDia.AsDateTime;
end;

procedure TRegistroPontoController.PreencherHoraSaida(DataHora: TDateTime);
begin
  DmPrincipal.cdsPontoMensalSaida.AsDateTime := DataHora -  DmPrincipal.cdsPontoMensalDia.AsDateTime;
end;

function TRegistroPontoController.ObterListaPorReferencia(Mes,
  Ano: Integer): TObjectList;
var
  ListaPonto: TObjectList;
  Ponto: TRegistroPonto;
begin
  DmPrincipal.PrepararDataSetPontoMensal(Mes, Ano);
  ListaPonto := TObjectList.Create;
  while (not(DmPrincipal.cdsPontoMensal.Eof)) do
  begin
    Ponto := TRegistroPonto.Create;
    Ponto.HoraEntrada := ObterHoraEntrada;
    Ponto.HoraInicioIntervalo := ObterHoraInicioAlmoco;
    Ponto.HoraFimIntervalo := ObterHoraFimAlmoco;
    Ponto.HoraSaida := ObterHoraSaida;
    ListaPonto.Add(Ponto);
    DmPrincipal.cdsPontoMensal.Next;
  end;
  Result := ListaPonto;
end;

Initialization

  FInstance := nil;

end.

unit URegistroPonto;

interface

type
  TRegistroPonto = class(TObject)
  private
    FHoraEntrada: TDateTime;
    FHoraSaida: TDateTime;
    FInicioIntervalo: TDateTime;
    FFimIntervalo: TDateTime;
    function GetHoraEntrada: TDateTime;
    function GetHoraFimIntervalo: TDateTime;
    function GetHoraInicioIntervalo: TDateTime;
    function GetHoraSaida: TDateTime;
    function ObterJornadaDiaria: TDateTime;
    procedure CarregarPorData(Data: TDateTime);
    procedure SetHoraEntrada(const Value: TDateTime);
    procedure SetHoraFimIntervalo(const Value: TDateTime);
    procedure SetHoraInicioIntervalo(const Value: TDateTime);
    procedure SetHoraSaida(const Value: TDateTime);
  protected

  public
    constructor Create; overload;
    constructor Create(Data: TDateTime); overload;
    function ObterHoraExtraDiaria: TDateTime;
    function ObterHorasTrabalhadas: TDateTime;
    procedure Gravar;
  published
    property HoraEntrada: TDateTime read GetHoraEntrada write SetHoraEntrada;
    property HoraSaida: TDateTime read GetHoraSaida write SetHoraSaida;
    property HoraInicioIntervalo: TDateTime read GetHoraInicioIntervalo write SetHoraInicioIntervalo;
    property HoraFimIntervalo: TDateTime read GetHoraFimIntervalo write SetHoraFimIntervalo;            
  end;


implementation

uses
  SysUtils,
  URegistroPontoController;

const
  STR_JORNADA_PADRAO = '08:00';

{ TRegistroPonto }

procedure TRegistroPonto.CarregarPorData(Data: TDateTime);
var
  Controlador: TRegistroPontoController;
begin
  Controlador := TRegistroPontoController.GetInstance;
  Controlador.CarregarPorData(Data, Self);
end;

constructor TRegistroPonto.Create(Data: TDateTime);
begin
  Create;
  CarregarPorData(Data);
end;

constructor TRegistroPonto.Create;
begin
  inherited Create;
end;

function TRegistroPonto.GetHoraEntrada: TDateTime;
begin
  Result := FHoraEntrada;
end;

function TRegistroPonto.GetHoraFimIntervalo: TDateTime;
begin
  Result := FFimIntervalo;
end;

function TRegistroPonto.GetHoraInicioIntervalo: TDateTime;
begin
  Result := FInicioIntervalo;
end;

function TRegistroPonto.GetHoraSaida: TDateTime;
begin
  Result := FHoraSaida;
end;

procedure TRegistroPonto.Gravar;
var
  Controlador: TRegistroPontoController;
begin
  Controlador := TRegistroPontoController.GetInstance;
  Controlador.Gravar(Self);
end;

function TRegistroPonto.ObterHoraExtraDiaria: TDateTime;
var
  Resultado: Double;
begin
  Resultado := ObterHorasTrabalhadas - ObterJornadaDiaria;
  // Eliminando frações menores que 1 minuto
  if (FormatDateTime('HH:MM', Resultado) = FormatDateTime('HH:MM', 0)) then
    Resultado := 0;
  Result := Resultado;
end;

function TRegistroPonto.ObterHorasTrabalhadas: TDateTime;
var
  Intervalo: TDateTime;
begin
  Intervalo := (HoraFimIntervalo - HoraInicioIntervalo);
  Result := (HoraSaida - HoraEntrada - Intervalo)
end;

function TRegistroPonto.ObterJornadaDiaria: TDateTime;
begin
  Result := StrToTime(STR_JORNADA_PADRAO);
end;

procedure TRegistroPonto.SetHoraEntrada(const Value: TDateTime);
begin
  FHoraEntrada := Value;
end;

procedure TRegistroPonto.SetHoraFimIntervalo(const Value: TDateTime);
begin
  FFimIntervalo := Value;
end;

procedure TRegistroPonto.SetHoraInicioIntervalo(const Value: TDateTime);
begin
  FInicioIntervalo := Value;
end;

procedure TRegistroPonto.SetHoraSaida(const Value: TDateTime);
begin
  FHoraSaida := Value;
end;

end.


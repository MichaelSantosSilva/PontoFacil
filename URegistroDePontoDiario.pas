unit URegistroDePontoDiario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, Buttons, URegistroPonto;

type
  TFrmRegistroDePontoDiario = class(TForm)
    Label1: TLabel;
    dtpData: TDateTimePicker;
    gbMarcacoes: TGroupBox;
    Entrada: TLabel;
    mskEntrada: TMaskEdit;
    Label2: TLabel;
    mskIniAlmoco: TMaskEdit;
    Label3: TLabel;
    mskFimAlmoco: TMaskEdit;
    Label4: TLabel;
    mskSaida: TMaskEdit;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpDataChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    FRegistroPonto: TRegistroPonto;
    function ValidarRegistro: Boolean;
  public
    destructor Destroy; override;
  end;

var
  FrmRegistroDePontoDiario: TFrmRegistroDePontoDiario;

implementation

{$R *.dfm}

procedure TFrmRegistroDePontoDiario.FormShow(Sender: TObject);
begin
  dtpData.MaxDate := Now;
  dtpData.Date := Int(dtpData.MaxDate);
  dtpDataChange(dtpData);
end;

procedure TFrmRegistroDePontoDiario.FormCreate(Sender: TObject);
begin
  FRegistroPonto := nil;
end;

procedure TFrmRegistroDePontoDiario.dtpDataChange(Sender: TObject);
begin
  FRegistroPonto := TRegistroPonto.Create(dtpData.Date);
  mskEntrada.Text := FormatDateTime('HH:MM', FRegistroPonto.HoraEntrada);
  mskSaida.Text := FormatDateTime('HH:MM', FRegistroPonto.HoraSaida);
  mskIniAlmoco.Text := FormatDateTime('HH:MM', FRegistroPonto.HoraInicioIntervalo);
  mskFimAlmoco.Text := FormatDateTime('HH:MM', FRegistroPonto.HoraFimIntervalo);
end;

procedure TFrmRegistroDePontoDiario.btnOkClick(Sender: TObject);
begin
  if (ValidarRegistro) then
    try
      FRegistroPonto.HoraEntrada := Int(dtpData.Date) + StrToTime(mskEntrada.Text);
      FRegistroPonto.HoraSaida := Int(dtpData.Date) + StrToTime(mskSaida.Text);
      FRegistroPonto.HoraInicioIntervalo := Int(dtpData.Date) + StrToTime(mskIniAlmoco.Text);
      FRegistroPonto.HoraFimIntervalo := Int(dtpData.Date) + StrToTime(mskFimAlmoco.Text);
      FRegistroPonto.Gravar;
      ShowMessage('Gravado com Sucesso!');
      dtpData.SetFocus;      
    except
      on E: Exception do
        ShowMessage('Erro ao Gravar: ' + #13#10 + E.message);
    end;
end;

destructor TFrmRegistroDePontoDiario.Destroy;
begin
  if(Assigned(FRegistroPonto)) then
    FreeAndNil(FRegistroPonto);
  inherited;
end;

procedure TFrmRegistroDePontoDiario.btnCancelarClick(Sender: TObject);
begin
  if (Application.MessageBox( 'Deseja Cancelar e Sair?',
                              'Atenção',
                              MB_YESNO + MB_ICONQUESTION) = idYes) then
    Close;
end;

function TFrmRegistroDePontoDiario.ValidarRegistro: Boolean;
begin
  Result := False;
  if (StrToDateTimeDef(mskEntrada.Text, 0) = 0) then
  begin
    ShowMessage('Hora de Entrada inválida!');
    mskEntrada.SetFocus;
    Exit;
  end;
  if (StrToDateTimeDef(mskIniAlmoco.Text, 0) = 0) then
  begin
    ShowMessage('Hora de Saída para Almoço inválida!');
    mskIniAlmoco.SetFocus;
    Exit;
  end;
  if (StrToDateTimeDef(mskFimAlmoco.Text, 0) = 0) then
  begin
    ShowMessage('Hora de Retorno do Almoço inválida!');
    mskFimAlmoco.SetFocus;
    Exit;
  end;
  if (StrToDateTimeDef(mskSaida.Text, 0) = 0) then
  begin
    ShowMessage('Hora de Saída inválida!');
    mskSaida.SetFocus;
    Exit;
  end;
  if (StrToDateTime(mskEntrada.Text) < StrToDateTime('06:00')) then
  begin
    ShowMessage ('Hora de Entrada não pode ser menor que 06:00!');
    mskEntrada.SetFocus;
    Exit;
  end;
  if (StrToDateTime(mskSaida.Text) > StrToDateTime('23:00')) then
  begin
    ShowMessage ('Hora de Saída não pode ser maior que 23:00!');
    mskSaida.SetFocus;
    Exit;
  end;
  if (StrToDateTime(mskEntrada.Text) >= StrToDateTime(mskIniAlmoco.Text)) then
  begin
    ShowMessage ('Hora de Saída para Almoço precisa ser maior que a hora de Entrada!');
    mskIniAlmoco.SetFocus;
    Exit;
  end;
  if (StrToDateTime(mskIniAlmoco.Text) >= StrToDateTime(mskFimAlmoco.Text)) then
  begin
    ShowMessage ('Hora de Retorno do Almoço precisa ser maior que a hora de Saída para Almoço!');
    mskFimAlmoco.SetFocus;
    Exit;
  end;
  if (StrToDateTime(mskFimAlmoco.Text) >= StrToDateTime(mskSaida.Text)) then
  begin
    ShowMessage ('Hora de Saída precisa ser maior que a hora de Retorno do Almoço!');
    mskSaida.SetFocus;
    Exit;
  end;
  Result := True;
end;

end.

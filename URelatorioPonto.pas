unit URelatorioPonto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Mask;

type
  TFrmRelatorioPonto = class(TForm)
    Label3: TLabel;
    mskReferencia: TMaskEdit;
    btnPesquisar: TSpeedButton;
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelatorioPonto: TFrmRelatorioPonto;

implementation

uses
  URegistroPontoController,
  Contnrs,
  URegistroPonto,
  UUtilidadesIni,
  UUtilidadesString,
  UVisualizadorDeRelatorios;

{$R *.dfm}

procedure TFrmRelatorioPonto.btnPesquisarClick(Sender: TObject);
var
  Controller: TRegistroPontoController;
  ListaPonto: TObjectList;
  Ponto: TRegistroPonto;
  I, Mes, Ano: Integer;
  Relatorio: TStringList;
begin
  try
    Relatorio := TStringList.Create;
    controller := TRegistroPontoController.GetInstance;
    Mes := StrToIntDef(Copy(mskReferencia.Text,1,2),0);
    Ano := StrToIntDef(Copy(mskReferencia.Text,4,4),0);
    ListaPonto := Controller.ObterListaPorReferencia(Mes, Ano);
    if (ListaPonto.Count = 0) then
    begin
      ShowMessage('Nenhum Lançamento no Período');
      Exit;
    end;
    Relatorio.Add('Relatório de Marcações de Ponto');
    Relatorio.Add(
      TUtilidadesString.LPad('Nome: ' + TUtilidadesIni.ObterNome, ' ', 80) +
      TUtilidadesString.RPad('Referência: ' + mskReferencia.Text, ' ', 32)
    );
    Relatorio.Add(
      TUtilidadesString.LPad('Função: ' + TUtilidadesIni.ObterFuncao, ' ', 80) +
      TUtilidadesString.RPad(
                              'Emissão: ' + FormatDateTime('dd/mm/yyyy HH:MM:SS', Now),
                              ' ',
                              32
                             )
    );
    Relatorio.Add(EmptyStr);
    Relatorio.Add(
      TUtilidadesString.LPad('Data', ' ', 15) +
      TUtilidadesString.RPad('Entrada', ' ', 15) +
      TUtilidadesString.RPad('Saída Almoço', ' ', 15) +
      TUtilidadesString.RPad('Retorno Almoço', ' ', 15) +
      TUtilidadesString.RPad('Saída', ' ', 15)
    );
    for I := 0 to Pred(ListaPonto.Count) do
    begin
      Ponto := (ListaPonto[I] as TRegistroPonto);
      Relatorio.Add(
        TUtilidadesString.LPad(FormatDateTime('dd/mm/yyyy',Int(Ponto.HoraEntrada)), ' ', 15) +
        TUtilidadesString.RPad(FormatDateTime('HH:MM', Ponto.HoraEntrada), ' ', 15) +
        TUtilidadesString.RPad(FormatDateTime('HH:MM', Ponto.HoraInicioIntervalo), ' ', 15) +
        TUtilidadesString.RPad(FormatDateTime('HH:MM', Ponto.HoraFimIntervalo), ' ', 15) +
        TUtilidadesString.RPad(FormatDateTime('HH:MM', Ponto.HoraSaida), ' ', 15)
      );
    end;
    try
      FrmVisualizadorRelatorios := TFrmVisualizadorRelatorios.Create(Self);
      FrmVisualizadorRelatorios.Visualizar(Relatorio);
    finally
      if(Assigned(FrmVisualizadorRelatorios)) then
        FreeAndNil(FrmVisualizadorRelatorios);
  end;
  finally
    if (Assigned(ListaPonto)) then
      FreeAndNil(ListaPonto);
    if (Assigned(Relatorio)) then
      FreeAndNil(Relatorio);
  end;
end;

procedure TFrmRelatorioPonto.FormShow(Sender: TObject);
begin
  mskReferencia.Text := FormatDateTime('mm/yyyy', Now);
end;

end.

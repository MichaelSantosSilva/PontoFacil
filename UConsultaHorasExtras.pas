unit UConsultaHorasExtras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DB, DBClient, Grids, DBGrids, Buttons, DBCtrls;

type
  TFrmConsultaHorasExtras = class(TForm)
    gbFiltros: TGroupBox;
    lblNome: TLabel;
    lblFuncao: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    mskReferencia: TMaskEdit;
    dbgHorasExtras: TDBGrid;
    dsHorasExtras: TDataSource;
    cdsHorasExtras: TClientDataSet;
    cdsHorasExtrasData: TDateField;
    cdsHorasExtrasHorasExtras: TFloatField;
    cdsHorasExtrasAtrasos: TFloatField;
    cdsHorasExtrasHorasExtraExibicao: TStringField;
    cdsHorasExtrasAtrasosExibicao: TStringField;
    cdsHorasExtrasHorasExtrasAgg: TAggregateField;
    cdsHorasExtrasAtrasosAgg: TAggregateField;
    mskTotalExtra: TMaskEdit;
    mskTotalAtraso: TMaskEdit;
    btnPesquisar: TSpeedButton;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure cdsHorasExtrasCalcFields(DataSet: TDataSet);
  private
    procedure ExibirTotal(Msk: TMaskEdit; Valor: TDateTime);
  public
    { Public declarations }
  end;

var
  FrmConsultaHorasExtras: TFrmConsultaHorasExtras;

implementation

uses
  URegistroPontoController,
  Contnrs,
  URegistroPonto,
  UUtilidadesIni;

{$R *.dfm}

procedure TFrmConsultaHorasExtras.FormShow(Sender: TObject);
begin
  mskReferencia.Text := FormatDateTime('mm/yyyy', Now);
  lblNome.Caption :=  TUtilidadesIni.ObterNome;
  lblFuncao.Caption := TUtilidadesIni.ObterFuncao;
end;

procedure TFrmConsultaHorasExtras.btnPesquisarClick(Sender: TObject);
var
  Controller: TRegistroPontoController;
  ListaPonto: TObjectList;
  Ponto: TRegistroPonto;
  I, Mes, Ano: Integer;
  HoraExtra, TotalExtra, TotalAtraso: TDateTime;
begin
  try
    controller := TRegistroPontoController.GetInstance;
    Mes := StrToIntDef(Copy(mskReferencia.Text,1,2),0);
    Ano := StrToIntDef(Copy(mskReferencia.Text,4,4),0);
    ListaPonto := Controller.ObterListaPorReferencia(Mes, Ano);
    cdsHorasExtras.EmptyDataSet;
    TotalExtra := 0;
    TotalAtraso := 0;
    for I := 0 to Pred(ListaPonto.Count) do
    begin
      Ponto := (ListaPonto[I] as TRegistroPonto);
      HoraExtra := Ponto.ObterHoraExtraDiaria;
      if (HoraExtra <> 0) then
      begin
        cdsHorasExtras.Append;
        cdsHorasExtrasData.AsFloat := Int(Ponto.HoraEntrada);
        if (HoraExtra > 0) then
        begin
          cdsHorasExtrasHorasExtras.AsFloat := HoraExtra;
          TotalExtra := TotalExtra + HoraExtra;
        end
        else
        begin
          cdsHorasExtrasAtrasos.AsFloat := HoraExtra;
          TotalAtraso := TotalAtraso + HoraExtra;
        end;
        cdsHorasExtras.Post;
      end;
    end;
    ExibirTotal(mskTotalExtra, TotalExtra);
    ExibirTotal(mskTotalAtraso, TotalAtraso);
  finally
    if (Assigned(ListaPonto)) then
      FreeAndNil(ListaPonto);
  end;
  if (cdsHorasExtras.IsEmpty) then
    ShowMessage('Nenhuma Hora Extra ou Atraso no Período');
end;

procedure TFrmConsultaHorasExtras.cdsHorasExtrasCalcFields(
  DataSet: TDataSet);
begin
  cdsHorasExtrasHorasExtraExibicao.AsString := FormatDateTime('HH:MM', cdsHorasExtrasHorasExtras.AsFloat);
  cdsHorasExtrasAtrasosExibicao.AsString := FormatDateTime('HH:MM', cdsHorasExtrasAtrasos.AsFloat);
end;

procedure TFrmConsultaHorasExtras.ExibirTotal(Msk: TMaskEdit;
  Valor: TDateTime);
var
  Dias, Horas, Minutos, Segundos, Mili: Word;
begin
  Dias := Trunc(Valor);
  Valor := Valor - Dias;
  DecodeTime(Valor, Horas, Minutos, Segundos, Mili);
  Msk.Text := FormatFloat('0',(Dias * 24) + Horas) + ':' + FormatFloat('00', Minutos);
end;

end.

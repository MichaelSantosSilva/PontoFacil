unit UDmPrincipal;

interface

uses
  SysUtils, Classes, DB, DBClient, Forms, MidasLib;

type
  TDmPrincipal = class(TDataModule)
    cdsPontoMensal: TClientDataSet;
    cdsPontoMensalDia: TDateField;
    cdsPontoMensalEntrada: TTimeField;
    cdsPontoMensalInicioAlmoco: TTimeField;
    cdsPontoMensalFimAlmoco: TTimeField;
    cdsPontoMensalSaida: TTimeField;
  private
    function ObterNomeArquivo(Mes, Ano: Integer): string;
  public
    procedure GravarDataSetPontoMensal(Mes, Ano: Integer);
    procedure PrepararDataSetPontoMensal(Mes, Ano: Integer);
  end;

var
  DmPrincipal: TDmPrincipal;

implementation

{$R *.dfm}

{ TDmPrincipal }

procedure TDmPrincipal.GravarDataSetPontoMensal(Mes, Ano: Integer);
begin
  cdsPontoMensal.SaveToFile(ObterNomeArquivo(Mes, Ano));
end;

function TDmPrincipal.ObterNomeArquivo(Mes, Ano: Integer): string;
begin
  Result := ExtractFilePath(Application.ExeName) + '/data/'
            + FormatFloat('0000', Ano)
            + FormatFloat('00', Mes)
            + '.xml';
end;

procedure TDmPrincipal.PrepararDataSetPontoMensal(Mes, Ano: Integer);
begin
  cdsPontoMensal.EmptyDataSet;
  if ( not FileExists(ObterNomeArquivo(Mes, Ano))) then
  begin
    GravarDataSetPontoMensal(Mes, Ano);
  end;
  if (cdsPontoMensal.FileName <> ObterNomeArquivo(Mes, Ano)) then
  begin
    cdsPontoMensal.Close;
    cdsPontoMensal.LoadFromFile(ObterNomeArquivo(Mes, Ano));
    cdsPontoMensal.Open;
  end
  else
  begin
    cdsPontoMensal.Filtered := False;
    cdsPontoMensal.Filter := '';
    cdsPontoMensal.First;
  end;
end;

end.

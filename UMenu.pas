unit UMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ComCtrls;

type
  TFrmMenu = class(TForm)
    btnRegistrarPonto: TSpeedButton;
    btnConsultarHoraExtra: TSpeedButton;
    btnRelatorioDePonto: TSpeedButton;
    btnConfiguracoes: TSpeedButton;
    stbMenu: TStatusBar;
    procedure FormShow(Sender: TObject);
    procedure btnConfiguracoesClick(Sender: TObject);
    procedure btnRegistrarPontoClick(Sender: TObject);
    procedure btnConsultarHoraExtraClick(Sender: TObject);
    procedure btnRelatorioDePontoClick(Sender: TObject);
  private
    procedure TratarExibicao;
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

uses
  UUtilidadesIni,
  UConfiguracao, URegistroDePontoDiario, UConsultaHorasExtras,
  URelatorioPonto;

{$R *.dfm}

procedure TFrmMenu.FormShow(Sender: TObject);
begin
  TratarExibicao;
  if(not(DirectoryExists(ExtractFilePath(Application.ExeName) + '/data/'))) then
    ForceDirectories(ExtractFilePath(Application.ExeName) + '/data/');
end;

procedure TFrmMenu.TratarExibicao;
begin
  btnRelatorioDePonto.Enabled := TUtilidadesIni.ConfiguracaoExiste;
  if (btnRelatorioDePonto.Enabled) then
    btnRelatorioDePonto.Hint := 'Visualize sua folha de ponto mensal'
  else
    btnRelatorioDePonto.Hint := 'Configure o sistema antes de usar esta opção';
end;

procedure TFrmMenu.btnConfiguracoesClick(Sender: TObject);
begin
  try
    FrmConfiguracao := TFrmConfiguracao.Create(Self);
    FrmConfiguracao.ShowModal;
  finally
    if (Assigned(FrmConfiguracao)) then
      FreeAndNil(FrmConfiguracao);
    TratarExibicao;
  end;
end;

procedure TFrmMenu.btnRegistrarPontoClick(Sender: TObject);
begin
  try
    FrmRegistroDePontoDiario := TFrmRegistroDePontoDiario.Create(Self);
    FrmRegistroDePontoDiario.ShowModal;
  finally
    if(Assigned(FrmRegistroDePontoDiario)) then
      FreeAndNil(FrmRegistroDePontoDiario);
  end;
end;

procedure TFrmMenu.btnConsultarHoraExtraClick(Sender: TObject);
begin
  try
    FrmConsultaHorasExtras := TFrmConsultaHorasExtras.Create(Self);
    FrmConsultaHorasExtras.ShowModal;
  finally
    if(Assigned(FrmConsultaHorasExtras)) then
      FreeAndNil(FrmConsultaHorasExtras);
  end;
end;

procedure TFrmMenu.btnRelatorioDePontoClick(Sender: TObject);
begin
  try
    FrmRelatorioPonto := TFrmRelatorioPonto.Create(Self);
    FrmRelatorioPonto.ShowModal;
  finally
    if(Assigned(FrmRelatorioPonto)) then
      FreeAndNil(FrmRelatorioPonto);
  end;
end;

end.

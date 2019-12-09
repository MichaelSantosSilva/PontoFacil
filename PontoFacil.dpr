program PontoFacil;

uses
  Forms,
  UMenu in 'UMenu.pas' {FrmMenu},
  UUtilidadesIni in 'Util\UUtilidadesIni.pas',
  UConfiguracao in 'Util\UConfiguracao.pas' {FrmConfiguracao},
  URegistroPonto in 'Dominio\URegistroPonto.pas',
  URegistroDePontoDiario in 'URegistroDePontoDiario.pas' {FrmRegistroDePontoDiario},
  URegistroPontoController in 'Controller\URegistroPontoController.pas',
  UDmPrincipal in 'UDmPrincipal.pas' {DmPrincipal: TDataModule},
  UConsultaHorasExtras in 'UConsultaHorasExtras.pas' {FrmConsultaHorasExtras},
  URelatorioPonto in 'URelatorioPonto.pas' {FrmRelatorioPonto},
  UUtilidadesString in 'Util\UUtilidadesString.pas',
  UVisualizadorDeRelatorios in 'UVisualizadorDeRelatorios.pas' {FrmVisualizadorRelatorios};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.CreateForm(TDmPrincipal, DmPrincipal);
  Application.CreateForm(TFrmConsultaHorasExtras, FrmConsultaHorasExtras);
  Application.CreateForm(TFrmRelatorioPonto, FrmRelatorioPonto);
  Application.CreateForm(TFrmVisualizadorRelatorios, FrmVisualizadorRelatorios);
  Application.Run;
end.

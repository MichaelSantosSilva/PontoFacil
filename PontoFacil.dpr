program PontoFacil;

uses
  Forms,
  UMenu in 'UMenu.pas' {FrmMenu},
  UUtilidadesIni in 'Util\UUtilidadesIni.pas',
  UConfiguracao in 'Util\UConfiguracao.pas' {FrmConfiguracao},
  URegistroPonto in 'Dominio\URegistroPonto.pas',
  URegistroDePontoDiario in 'URegistroDePontoDiario.pas' {FrmRegistroDePontoDiario},
  URegistroPontoController in 'Controller\URegistroPontoController.pas',
  UDmPrincipal in 'UDmPrincipal.pas' {DmPrincipal: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.CreateForm(TDmPrincipal, DmPrincipal);
  Application.Run;
end.

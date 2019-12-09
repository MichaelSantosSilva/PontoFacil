unit UVisualizadorDeRelatorios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmVisualizadorRelatorios = class(TForm)
    mmRelatorio: TMemo;
  private
    { Private declarations }
  public
    procedure Visualizar(TextoRelatorio: TStringList);
  end;

var
  FrmVisualizadorRelatorios: TFrmVisualizadorRelatorios;

implementation

{$R *.dfm}

{ TFrmVisualizadorRelatorios }

procedure TFrmVisualizadorRelatorios.Visualizar(
  TextoRelatorio: TStringList);
begin
  mmRelatorio.Text := TextoRelatorio.Text;
  ShowModal;
end;

end.

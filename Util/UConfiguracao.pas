unit UConfiguracao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFrmConfiguracao = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edtNome: TEdit;
    edtFuncao: TEdit;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfiguracao: TFrmConfiguracao;

implementation

uses
  UUtilidadesIni;

{$R *.dfm}

procedure TFrmConfiguracao.FormShow(Sender: TObject);
begin
  edtNome.Text := TUtilidadesIni.ObterNome;
  edtFuncao.Text := TUtilidadesIni.ObterFuncao;
end;

procedure TFrmConfiguracao.btnOkClick(Sender: TObject);
begin
  try
    TUtilidadesIni.DefinirNome(edtNome.Text);
    TUtilidadesIni.DefinirFuncao(edtFuncao.Text);
    ShowMessage('Gravado com Sucesso');
    Close;
  except
    on E: Exception do
    begin
      ShowMessage('Erro na grava��o das configura��es:' + #13#10 + E.message);
      Abort;
    end;
  end;
end;

procedure TFrmConfiguracao.btnCancelarClick(Sender: TObject);
begin
  if (Application.MessageBox( 'Deseja Cancelar e Sair?',
                              'Aten��o',
                              MB_YESNO + MB_ICONQUESTION) = idYes) then
    Close;
end;

end.

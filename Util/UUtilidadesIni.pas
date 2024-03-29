unit UUtilidadesIni;

interface

uses  SysUtils, IniFiles, Forms;

type
  TUtilidadesIni = class(TObject)
  private
    class function ArquivoExiste: Boolean;
    class function DadosPreenchidos: Boolean;
    class function LerFuncao(Arquivo: TIniFile): string;
    class function LerNome(Arquivo: TIniFile): string;
    class function ObterArquivo: TIniFile;
    class function ObterNomeArquivo: string;
    class procedure CriarArquivo;
    class procedure GravarFuncao(Arquivo: TIniFile; Funcao: string);
    class procedure GravarNome(Arquivo: TIniFile; Nome: string);
  protected

  public

  published
    class function ConfiguracaoExiste: Boolean;
    class function ObterFuncao: string;
    class function ObterNome: string;
    class procedure DefinirFuncao(Funcao: string);
    class procedure DefinirNome(Nome: string);
  end;


implementation

const
  NOME_ARQUIVO = 'pontofacil.ini';
  SESSAO_GERAL = 'GERAL';
  CAMPO_NOME = 'nome';
  CAMPO_FUNCAO = 'fun��o';

{ TUtilidadesIni }

class function TUtilidadesIni.ArquivoExiste: Boolean;
begin
  Result := FileExists(ObterNomeArquivo);
end;

class function TUtilidadesIni.ConfiguracaoExiste: Boolean;
begin
  Result := ArquivoExiste and DadosPreenchidos;
end;

class procedure TUtilidadesIni.CriarArquivo;
var
  Arquivo: TIniFile;
begin
  Arquivo := nil;
  try
    if (ArquivoExiste) then
      Exit;
    Arquivo := ObterArquivo;
    GravarNome(Arquivo, EmptyStr);
    GravarFuncao(Arquivo, EmptyStr);
  finally
    if (Assigned(Arquivo)) then
      FreeAndNil(Arquivo);
  end;
end;

class function TUtilidadesIni.DadosPreenchidos: Boolean;
var
  Arquivo: TIniFile;
  Nome, Funcao: string;
begin
  Arquivo := nil;
  try
    Result := ArquivoExiste;
    if (not(Result)) then
      Exit;
    Arquivo := ObterArquivo;
    Nome := LerNome(Arquivo);
    Funcao := LerFuncao(Arquivo);
    Result := not((Nome = EmptyStr) or (Funcao = EmptyStr));
  finally
    if (Assigned(Arquivo)) then
      FreeAndNil(Arquivo);
  end;
end;

class procedure TUtilidadesIni.DefinirFuncao(Funcao: string);
var
  Arquivo: TIniFile;
begin
  Arquivo := nil;
  try
    if (not(ArquivoExiste)) then
      CriarArquivo;
      Arquivo := ObterArquivo;
      GravarFuncao(Arquivo, Trim(Funcao));
  finally
    if (Assigned(Arquivo)) then
      FreeAndNil(Arquivo);
  end;
end;

class procedure TUtilidadesIni.DefinirNome(Nome: string);
var
  Arquivo: TIniFile;
begin
  Arquivo := nil;
  try
    if (not(ArquivoExiste)) then
      CriarArquivo;
    Arquivo := ObterArquivo;
    GravarNome(Arquivo, Trim(Nome));
  finally
    if (Assigned(Arquivo)) then
      FreeAndNil(Arquivo);
  end;
end;

class procedure TUtilidadesIni.GravarFuncao(Arquivo: TIniFile; Funcao: string);
begin
  Arquivo.WriteString(SESSAO_GERAL, CAMPO_FUNCAO, Funcao);
end;

class procedure TUtilidadesIni.GravarNome(Arquivo: TIniFile; Nome: string);
begin
  Arquivo.WriteString(SESSAO_GERAL, CAMPO_NOME, Nome);
end;

class function TUtilidadesIni.LerFuncao(Arquivo: TIniFile): string;
begin
  Result := Arquivo.ReadString(SESSAO_GERAL, CAMPO_FUNCAO, EmptyStr);
end;

class function TUtilidadesIni.LerNome(Arquivo: TIniFile): string;
begin
  Result := Arquivo.ReadString(SESSAO_GERAL, CAMPO_NOME, EmptyStr);
end;

class function TUtilidadesIni.ObterArquivo: TIniFile;
begin
  Result := TIniFile.Create(ObterNomeArquivo);
end;

class function TUtilidadesIni.ObterFuncao: string;
var
  Arquivo: TIniFile;
begin
  Arquivo := nil;
  try
    if (not(ArquivoExiste)) then
    begin
      Result := EmptyStr;
      Exit;
    end;
    Arquivo := ObterArquivo;
    Result := LerFuncao(Arquivo);
  finally
    if (Assigned(Arquivo)) then
      FreeAndNil(Arquivo);
  end;
end;

class function TUtilidadesIni.ObterNome: string;
var
  Arquivo: TIniFile;
begin
  Arquivo := nil;
  try
    if (not(ArquivoExiste)) then
    begin
      Result := EmptyStr;
      Exit;
    end;
    Arquivo := ObterArquivo;
    Result := LerNome(Arquivo);
  finally
    if (Assigned(Arquivo)) then
      FreeAndNil(Arquivo);
  end;
end;

class function TUtilidadesIni.ObterNomeArquivo: string;
begin
  Result := ExtractFilePath(Application.ExeName) + NOME_ARQUIVO;
end;

end.

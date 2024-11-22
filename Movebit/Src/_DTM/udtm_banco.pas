{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                             https://www.jrs.net.br
 *
 * Autor...: Jrs 
 * Data....: 16/02/2024 
 * Objetivo: DataModule responsável pelos objetos de conexão com o banco de dados
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*/
}
unit udtm_banco;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Phys.IBBase,
  FireDAC.Comp.Client;

type
  Tdtm_banco = class(TDataModule)
    FDConnection: TFDConnection;
    FDTransaction: TFDTransaction;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure Conectar;
    procedure Desconectar;
    function GetPathDatabase: String;
  public
    { Public declarations }
  end;

const
  ARQ_INI = 'Movebit.ini';

var
  dtm_banco: Tdtm_banco;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  uGlobal;

procedure Tdtm_banco.Conectar;
begin
  try
    FDConnection.Connected       := False;
    FDConnection.Params.Database := GetPathDatabase;
    FDConnection.Params.UserName := 'SYSDBA';
    FDConnection.Params.Password := 'masterkey';
    FDConnection.Connected       := True;
  except
    MsgAlerta( 'Não foi possível realizar a conexão'
               +LineBreak+
               'com o banco de dados!' );
    EncerrarAplicacao;
  end;
end;

procedure Tdtm_banco.Desconectar;
begin
  try
    FDConnection.Connected := False;
  except

  end;
end;

function Tdtm_banco.GetPathDatabase: String;
begin
  Result := LerIni( DirApp+ARQ_INI, 'Movebit', 'PathDatabase' )
            +'\'+
            LerIni( DirApp+ARQ_INI, 'Movebit', 'NameDatabase' );
end;

procedure Tdtm_banco.DataModuleCreate(Sender: TObject);
begin
  Conectar;
end;

procedure Tdtm_banco.DataModuleDestroy(Sender: TObject);
begin
  Desconectar;
end;

end.

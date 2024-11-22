{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                             https://www.jrs.net.br
 *
 * Autor...: Jrs 
 * Data....: 16/02/2024 
 * Objetivo: Arquivo responsável pelos objetos da tabela de produto
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*/
}
unit udtm_produto;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  Tdtm_produto = class(TDataModule)
    qry_psq_produto: TFDQuery;
    qry_cad_produto: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtm_produto: Tdtm_produto;

implementation

uses
  udtm_banco;

{$R *.dfm}

end.

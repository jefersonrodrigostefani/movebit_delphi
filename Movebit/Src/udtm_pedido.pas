{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                             https://www.jrs.net.br
 *
 * Autor...: Jrs 
 * Data....: 16/02/2024 
 * Objetivo: Arquivo responsável pelos objetos da tabela de pedido
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*/
}
unit udtm_pedido;

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
  FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Datasnap.DBClient;

type
  Tdtm_pedido = class(TDataModule)
    qry_psq_pedido: TFDQuery;
    qry_cad_pedido: TFDQuery;
    cds_cad_pedido: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtm_pedido: Tdtm_pedido;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses udtm_banco;

{$R *.dfm}

end.

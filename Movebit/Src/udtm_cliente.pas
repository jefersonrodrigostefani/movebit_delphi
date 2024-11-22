{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                             https://www.jrs.net.br
 *
 * Autor...: Jrs 
 * Data....: 16/02/2024 
 * Objetivo: Arquivo responsável pelos objetos da tabela de clientes
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*/
}
unit udtm_cliente;

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
  Tdtm_cliente = class(TDataModule)
    qry_psq_cliente: TFDQuery;
    qry_cad_cliente: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtm_cliente: Tdtm_cliente;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses udtm_banco;

{$R *.dfm}

end.

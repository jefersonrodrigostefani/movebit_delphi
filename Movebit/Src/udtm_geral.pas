{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                             https://www.jrs.net.br
 *
 * Autor...: Jrs 
 * Data....: 16/02/2024 
 * Objetivo: Arquivo responsável pelos objetos de relatórios
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*/
}
unit udtm_geral;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  Tdtm_geral = class(TDataModule)
    qry_pesquisa: TFDQuery;
    qry_psq_ranking: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtm_geral: Tdtm_geral;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses udtm_banco;

{$R *.dfm}

end.

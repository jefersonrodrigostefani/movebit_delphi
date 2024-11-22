unit ufrm_psq_produto;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  ufrm_psq,
  Data.DB,
  System.Actions,
  Vcl.ActnList,
  System.ImageList,
  Vcl.ImgList,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  Tfrm_psq_produto = class(Tfrm_psq)
    procedure cmb_psq_regChange(Sender: TObject);
    procedure edt_psq_regChange(Sender: TObject);
  private
    { Private declarations }
    procedure Mostrar; override;
    procedure Incluir; override;
    procedure Alterar; override;
    procedure Excluir; override;
    procedure Imprime; override;
    function UsadoEmAlgumPedido: Boolean;
  public
    { Public declarations }
  end;

var
  frm_psq_produto: Tfrm_psq_produto;

implementation

{$R *.dfm}

uses
  uGlobal,
  udtm_produto,
  ufrm_cad_produto;

procedure Tfrm_psq_produto.Mostrar;
begin
  dtm_produto.qry_psq_produto.Close;
  dtm_produto.qry_psq_produto.SQL.Clear;
  dtm_produto.qry_psq_produto.Params.Clear;
  dtm_produto.qry_psq_produto.SQL.Text := ' SELECT T1.CD_PRODUTO, ' +
                                          '        T1.NM_PRODUTO, ' +
                                          '        T1.AP_PRODUTO, ' +
                                          '        T1.VL_PRODUTO, ' +
                                          '        T1.IN_PRODUTO  ' +
                                          ' FROM PRODUTO T1       ' +
                                          ' WHERE 1=1             ' ;
  dtm_produto.qry_psq_produto.Open;

  dtm_produto.qry_psq_produto.FieldByName('CD_PRODUTO').DisplayLabel := 'Código';
  dtm_produto.qry_psq_produto.FieldByName('NM_PRODUTO').DisplayLabel := 'Descrição';
  dtm_produto.qry_psq_produto.FieldByName('VL_PRODUTO').DisplayLabel := 'Preço R$';
  dtm_produto.qry_psq_produto.FieldByName('IN_PRODUTO').DisplayLabel := 'Status';

  TFloatField( dtm_produto.qry_psq_produto.FieldByName('VL_PRODUTO') ).DisplayFormat := '###,##0.00';
end;

procedure Tfrm_psq_produto.Incluir;
begin
  ShowFrm( Tfrm_cad_produto, 0 );
end;

procedure Tfrm_psq_produto.cmb_psq_regChange(Sender: TObject);
begin
  case cmb_psq_reg.ItemIndex of
    0: edt_psq_reg.NumbersOnly := True;
    1: edt_psq_reg.NumbersOnly := False;
  end;

  edt_psq_reg.SetFocus;
end;

procedure Tfrm_psq_produto.edt_psq_regChange(Sender: TObject);
begin
  dts_psq_reg.DataSet.Filtered := False;

  if ( edt_psq_reg.Text = EmptyStr ) then
    dts_psq_reg.DataSet.Filter := EmptyStr
  else
    case cmb_psq_reg.ItemIndex of
      0: dts_psq_reg.DataSet.Filter := ' CD_PRODUTO = ' + edt_psq_reg.Text;
      1: dts_psq_reg.DataSet.Filter := ' NM_PRODUTO LIKE ' + QuotedStr( '%'+edt_psq_reg.Text+'%' );
    end;

  dts_psq_reg.DataSet.Filtered := True;
end;

procedure Tfrm_psq_produto.Excluir;
begin
  if ( UsadoEmAlgumPedido ) then
    MsgAlerta( 'Não é possível excluir esse registro'
               +LineBreak+
               'pois ele já foi utilizado em algum pedido!' )
  else
  if MsgSimNao( 'Confirma a exclusão do registro?' ) then
    dtm_produto.qry_psq_produto.Delete;
end;

procedure Tfrm_psq_produto.Imprime;
begin
  MsgAlerta( '* * * Observação * * *'
             +LineBreak+
             'Como essa versão do Delphi que utilizei'
             +LineBreak+
             'não possuí o pacote do FastReports, optei'
             +LineBreak+
             'pela geração em arquivo CSV.'
             +LineBreak+
             'O arquivo será gerado no diretório da aplicação.' );

  if MsgSimNao( 'Confirma a impressão dos registros?' ) then
  begin
    ImprimeCSV( dts_psq_reg.DataSet, ['CD_PRODUTO', 'NM_PRODUTO', 'VL_PRODUTO', 'IN_PRODUTO'], DirApp+'PRODUTOS.CSV' );
    MsgAlerta( 'Impressão realizada com Sucesso!'
               +LineBreak+
               'O arquivo foi gerado dentro do'
               +LineBreak+
               'diretório da aplicação:'
               +LineBreak+
               DirApp );
  end;
end;

procedure Tfrm_psq_produto.Alterar;
begin
  ShowFrm( Tfrm_cad_produto, dts_psq_reg.DataSet.FieldByName('CD_PRODUTO').AsInteger );
end;

function Tfrm_psq_produto.UsadoEmAlgumPedido: Boolean;
var
  qrySQL: TQrSQL;
begin
  try
    qrySQL            := TQrSQL.Create( nil );
    qrySQL.Connection := SqlDbCon;

    qrySQL.Close;
    qrySQL.SQL.Clear;
    qrySQL.Params.Clear;
    qrySQL.SQL.Text := ' SELECT FIRST 1 NR_PEDIDO          ' +
                       ' FROM PEDIDO_ITEM T1               ' +
                       ' WHERE 1=1                         ' +
                       '   AND T1.CD_PRODUTO = :CD_PRODUTO ' ;
    qrySQL.ParamByName('CD_PRODUTO').AsInteger := dts_psq_reg.DataSet.FieldByName('CD_PRODUTO').AsInteger;
    qrySQL.Open;

    Result := ( not qrySQL.IsEmpty );

    qrySQL.Close;
  finally
    FreeAndNil( qrySQL );
  end;
end;

end.

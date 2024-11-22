unit ufrm_psq_cliente;

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
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  Tfrm_psq_cliente = class(Tfrm_psq)
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
  frm_psq_cliente: Tfrm_psq_cliente;

implementation

{$R *.dfm}

uses
  uGlobal,
  udtm_cliente,
  ufrm_cad_cliente;

procedure Tfrm_psq_cliente.Mostrar;
begin
  dtm_cliente.qry_psq_cliente.Close;
  dtm_cliente.qry_psq_cliente.SQL.Clear;
  dtm_cliente.qry_psq_cliente.Params.Clear;
  dtm_cliente.qry_psq_cliente.SQL.Text := ' SELECT T1.CD_CLIENTE, ' +
                                          '        T1.NM_CLIENTE, ' +
                                          '        T1.AP_CLIENTE, ' +
                                          '        T1.TP_CLIENTE, ' +
                                          '        T1.ED_CLIENTE, ' +
                                          '        T1.IN_CLIENTE  ' +
                                          ' FROM CLIENTE T1       ' +
                                          ' WHERE 1=1             ' ;
  dtm_cliente.qry_psq_cliente.Open;

  dtm_cliente.qry_psq_cliente.FieldByName('CD_CLIENTE').DisplayLabel := 'Código';
  dtm_cliente.qry_psq_cliente.FieldByName('NM_CLIENTE').DisplayLabel := 'Descrição';
  dtm_cliente.qry_psq_cliente.FieldByName('IN_CLIENTE').DisplayLabel := 'Status';

end;

procedure Tfrm_psq_cliente.Incluir;
begin
  ShowFrm( Tfrm_cad_cliente, 0 );
end;

procedure Tfrm_psq_cliente.cmb_psq_regChange(Sender: TObject);
begin
  case cmb_psq_reg.ItemIndex of
    0: edt_psq_reg.NumbersOnly := True;
    1: edt_psq_reg.NumbersOnly := False;
  end;

  edt_psq_reg.SetFocus;
end;

procedure Tfrm_psq_cliente.edt_psq_regChange(Sender: TObject);
begin
  dts_psq_reg.DataSet.Filtered := False;

  if ( edt_psq_reg.Text = EmptyStr ) then
    dts_psq_reg.DataSet.Filter := EmptyStr
  else
    case cmb_psq_reg.ItemIndex of
      0: dts_psq_reg.DataSet.Filter := ' CD_CLIENTE = ' + edt_psq_reg.Text;
      1: dts_psq_reg.DataSet.Filter := ' NM_CLIENTE LIKE ' + QuotedStr( '%'+edt_psq_reg.Text+'%' );
    end;

  dts_psq_reg.DataSet.Filtered := True;
end;

procedure Tfrm_psq_cliente.Excluir;
begin
  if ( UsadoEmAlgumPedido ) then
    MsgAlerta( 'Não é possível excluir esse registro'
               +LineBreak+
               'pois ele já foi utilizado em algum pedido!' )
  else
  if MsgSimNao( 'Confirma a exclusão do registro?' ) then
    dtm_cliente.qry_psq_cliente.Delete;
end;

procedure Tfrm_psq_cliente.Alterar;
begin
  ShowFrm( Tfrm_cad_cliente, dts_psq_reg.DataSet.FieldByName('CD_CLIENTE').AsInteger );
end;

procedure Tfrm_psq_cliente.Imprime;
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
    ImprimeCSV( dts_psq_reg.DataSet, ['CD_CLIENTE', 'NM_CLIENTE', 'IN_CLIENTE'], DirApp+'CLIENTES.CSV' );
    MsgAlerta( 'Impressão realizada com Sucesso!'
               +LineBreak+
               'O arquivo foi gerado dentro do'
               +LineBreak+
               'diretório da aplicação:'
               +LineBreak+
               DirApp );
  end;
end;

function Tfrm_psq_cliente.UsadoEmAlgumPedido: Boolean;
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
                       ' FROM PEDIDO T1                    ' +
                       ' WHERE 1=1                         ' +
                       '   AND T1.CD_CLIENTE = :CD_CLIENTE ' ;
    qrySQL.ParamByName('CD_CLIENTE').AsInteger := dts_psq_reg.DataSet.FieldByName('CD_CLIENTE').AsInteger;
    qrySQL.Open;

    Result := ( not qrySQL.IsEmpty );

    qrySQL.Close;
  finally
    FreeAndNil( qrySQL );
  end;
end;

end.

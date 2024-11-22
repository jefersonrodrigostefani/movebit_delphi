unit ufrm_psq_pedido;

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
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  Tfrm_psq_pedido = class(Tfrm_psq)
    procedure cmb_psq_regChange(Sender: TObject);
    procedure edt_psq_regChange(Sender: TObject);
  private
    { Private declarations }
    procedure Mostrar; override;
    procedure Incluir; override;
    procedure Alterar; override;
    procedure Excluir; override;
    procedure Imprime; override;
  public
    { Public declarations }
  end;

var
  frm_psq_pedido: Tfrm_psq_pedido;

implementation

{$R *.dfm}

uses
  uGlobal,
  udtm_pedido,
  ufrm_cad_pedido;

procedure Tfrm_psq_pedido.Mostrar;
begin
  dtm_pedido.qry_psq_pedido.Close;
  dtm_pedido.qry_psq_pedido.SQL.Clear;
  dtm_pedido.qry_psq_pedido.Params.Clear;
  dtm_pedido.qry_psq_pedido.SQL.Text := ' SELECT T1.NR_PEDIDO, ' +
                                        '        T1.DT_PEDIDO, ' +
                                        '        T1.NM_PEDIDO, ' +
                                        '        T1.QT_PEDIDO, ' +
                                        '        T1.VL_PEDIDO, ' +
                                        '        T1.IN_PEDIDO  ' +
                                        ' FROM VW_PEDIDO T1    ' +
                                        ' WHERE 1=1             ' ;
  dtm_pedido.qry_psq_pedido.Open;

  dtm_pedido.qry_psq_pedido.FieldByName('NR_PEDIDO').DisplayLabel := 'Nº do Pedido';
  dtm_pedido.qry_psq_pedido.FieldByName('DT_PEDIDO').DisplayLabel := 'Data do Pedido';
  dtm_pedido.qry_psq_pedido.FieldByName('NM_PEDIDO').DisplayLabel := 'Descrição do Pedido';
  dtm_pedido.qry_psq_pedido.FieldByName('QT_PEDIDO').DisplayLabel := 'Qtde do Pedido';
  dtm_pedido.qry_psq_pedido.FieldByName('VL_PEDIDO').DisplayLabel := 'Valor do Pedido';
  dtm_pedido.qry_psq_pedido.FieldByName('IN_PEDIDO').DisplayLabel := 'Status';

  TDateField(  dtm_pedido.qry_psq_pedido.FieldByName('DT_PEDIDO') ).DisplayFormat := 'dd/mm/yyyy';
  TFloatField( dtm_pedido.qry_psq_pedido.FieldByName('VL_PEDIDO') ).DisplayFormat := '###,##0.00';
end;

procedure Tfrm_psq_pedido.Incluir;
begin
  ShowFrm( Tfrm_cad_pedido, 0 );
end;

procedure Tfrm_psq_pedido.cmb_psq_regChange(Sender: TObject);
begin
  case cmb_psq_reg.ItemIndex of
    0: edt_psq_reg.NumbersOnly := True;
    1: edt_psq_reg.NumbersOnly := False;
  end;

  edt_psq_reg.SetFocus;
end;

procedure Tfrm_psq_pedido.edt_psq_regChange(Sender: TObject);
begin
  dts_psq_reg.DataSet.Filtered := False;

  if ( edt_psq_reg.Text = EmptyStr ) then
    dts_psq_reg.DataSet.Filter := EmptyStr
  else
    case cmb_psq_reg.ItemIndex of
      0: dts_psq_reg.DataSet.Filter := ' NR_PEDIDO = ' + edt_psq_reg.Text;
      1: dts_psq_reg.DataSet.Filter := ' NM_PEDIDO LIKE ' + QuotedStr( '%'+edt_psq_reg.Text+'%' );
    end;

  dts_psq_reg.DataSet.Filtered := True;
end;

procedure Tfrm_psq_pedido.Excluir;
begin
  if MsgSimNao( 'Confirma a exclusão do registro?' ) then
    dtm_pedido.qry_psq_pedido.Delete;
end;

procedure Tfrm_psq_pedido.Imprime;
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

  if MsgSimNao( 'Confirma a impressão do pedido selecionado?' ) then
  begin
    ImprimeCSV( dts_psq_reg.DataSet,
               ['NR_PEDIDO', 'DT_PEDIDO', 'NM_PEDIDO', 'QT_PEDIDO', 'VL_PEDIDO', 'IN_PEDIDO'],
               DirApp+Format( 'PEDIDO_%s.CSV', [dts_psq_reg.DataSet.FieldByName('NR_PEDIDO').AsString] ),
               False );
    MsgAlerta( 'Impressão realizada com Sucesso!'
               +LineBreak+
               'O arquivo foi gerado dentro do'
               +LineBreak+
               'diretório da aplicação:'
               +LineBreak+
               DirApp );
  end;
end;

procedure Tfrm_psq_pedido.Alterar;
begin
  ShowFrm( Tfrm_cad_pedido, dts_psq_reg.DataSet.FieldByName('NR_PEDIDO').AsInteger );
end;

end.

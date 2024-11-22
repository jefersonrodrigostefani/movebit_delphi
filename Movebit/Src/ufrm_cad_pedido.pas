{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                             https://www.jrs.net.br
 *
 * Autor...: Jrs 
 * Data....: 16/02/2024 
 * Objetivo: Arquivo responsável pelos cadastro de pedidos
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*/
}
unit ufrm_cad_pedido;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  ufrm_cad,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  System.ImageList,
  Vcl.ImgList,
  System.Actions,
  Vcl.ActnList,
  Vcl.DBCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Mask;

type
  Tfrm_cad_pedido = class(Tfrm_cad)
    pgc_frm_reg: TPageControl;
    tbs_itm_reg: TTabSheet;
    pnl_btn_itm: TPanel;
    img_btn_frm: TImageList;
    dbn_psq_itm: TDBNavigator;
    dbg_psq_itm: TDBGrid;
    btn_del_itm: TSpeedButton;
    btn_inc_itm: TSpeedButton;
    btn_alt_itm: TSpeedButton;
    lbl_cid_reg: TLabel;
    lbl_nom_reg: TLabel;
    lbl_cli_reg: TLabel;
    lbl_obs_reg: TLabel;
    lbl_atv_reg: TLabel;
    dts_cad_ped: TDataSource;
    btn_psq_cli: TSpeedButton;
    edt_cid_reg: TEdit;
    edt_nom_reg: TEdit;
    edt_cod_cli: TEdit;
    edt_nom_cli: TEdit;
    edt_obs_reg: TEdit;
    cmb_atv_reg: TComboBox;
    procedure btn_psq_cliClick(Sender: TObject);
    procedure btn_inc_itmClick(Sender: TObject);
    procedure btn_del_itmClick(Sender: TObject);
    procedure btn_alt_itmClick(Sender: TObject);
    procedure dbg_psq_itmDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure Mostrar; override;
    procedure Incluir; override;
    procedure Alterar; override;
    function Consiste: Boolean; override;
    function GeraNumeroPedido: Integer;

  public
    { Public declarations }
  end;

var
  frm_cad_pedido: Tfrm_cad_pedido;

implementation

{$R *.dfm}

uses
  uGlobal,
  udtm_pedido,
  ufrm_psq_geral,
  ufrm_itm_pedido;

procedure Tfrm_cad_pedido.Mostrar;
begin
  dtm_pedido.cds_cad_pedido.Close;
  dtm_pedido.cds_cad_pedido.FieldDefs.Clear;
  dtm_pedido.cds_cad_pedido.FieldDefs.Add( 'NR_PEDIDO'   , ftInteger , 000 , False );
  dtm_pedido.cds_cad_pedido.FieldDefs.Add( 'NM_PEDIDO'   , ftString  , 100 , False );
  dtm_pedido.cds_cad_pedido.FieldDefs.Add( 'DT_PEDIDO'   , ftDate    , 000 , False );
  dtm_pedido.cds_cad_pedido.FieldDefs.Add( 'CD_CLIENTE'  , ftInteger , 000 , False );
  dtm_pedido.cds_cad_pedido.FieldDefs.Add( 'NM_CLIENTE'  , ftString  , 050 , False );
  dtm_pedido.cds_cad_pedido.FieldDefs.Add( 'TX_PEDIDO'   , ftString  , 100 , False );
  dtm_pedido.cds_cad_pedido.FieldDefs.Add( 'IN_PEDIDO'   , ftString  , 010 , False );
  dtm_pedido.cds_cad_pedido.FieldDefs.Add( 'SQ_PEDIDO'   , ftAutoinc , 000 , False );
  dtm_pedido.cds_cad_pedido.FieldDefs.Add( 'CD_PRODUTO'  , ftInteger , 000 , False );
  dtm_pedido.cds_cad_pedido.FieldDefs.Add( 'NM_PRODUTO'  , ftString  , 100 , False );
  dtm_pedido.cds_cad_pedido.FieldDefs.Add( 'QT_PEDIDO'   , ftInteger , 000 , False );
  dtm_pedido.cds_cad_pedido.FieldDefs.Add( 'VL_PEDIDO'   , ftFloat   , 000 , False );
  dtm_pedido.cds_cad_pedido.FieldDefs.Add( 'TT_PEDIDO'   , ftFloat   , 000 , False );
  dtm_pedido.cds_cad_pedido.CreateDataSet;
  dtm_pedido.cds_cad_pedido.Open;

  TFloatField( dtm_pedido.cds_cad_pedido.FieldByName('VL_PEDIDO') ).DisplayFormat := '###,##0.00';
  TFloatField( dtm_pedido.cds_cad_pedido.FieldByName('TT_PEDIDO') ).DisplayFormat := '###,##0.00';

  dtm_pedido.qry_cad_pedido.Close;
  dtm_pedido.qry_cad_pedido.SQL.Clear;
  dtm_pedido.qry_cad_pedido.Params.Clear;
  dtm_pedido.qry_cad_pedido.SQL.Text := ' SELECT T1.NR_PEDIDO  ,          ' +
                                        '        T1.NM_PEDIDO  ,          ' +
                                        '		     T1.DT_PEDIDO  ,          ' +
                                        '		     T1.CD_CLIENTE ,          ' +
                                        '		     T1.NM_CLIENTE ,          ' +
                                        '		     T1.TX_PEDIDO  ,          ' +
                                        '		     T1.IN_PEDIDO  ,          ' +
                                        '        T1.SQ_PEDIDO  ,          ' +
                                        '		     T1.CD_PRODUTO ,          ' +
                                        '		     T1.NM_PRODUTO ,          ' +
                                        '		     T1.QT_PEDIDO  ,          ' +
                                        '		     T1.VL_PEDIDO             ' +
                                        ' FROM VW_PEDIDO_COMPLETA T1      ' +
                                        ' WHERE 1=1                       ' +
                                        '   AND T1.NR_PEDIDO = :NR_PEDIDO ' ;
  dtm_pedido.qry_cad_pedido.ParamByName('NR_PEDIDO').AsInteger := Self.Tag;
  dtm_pedido.qry_cad_pedido.Open;

  dtm_pedido.qry_cad_pedido.First;
  while ( not dtm_pedido.qry_cad_pedido.Eof ) do
  begin
    dtm_pedido.cds_cad_pedido.Append;
    dtm_pedido.cds_cad_pedido.FieldByName( 'NR_PEDIDO'  ).AsInteger  := dtm_pedido.qry_cad_pedido.FieldByName( 'NR_PEDIDO'  ).AsInteger;
    dtm_pedido.cds_cad_pedido.FieldByName( 'DT_PEDIDO'  ).AsDateTime := dtm_pedido.qry_cad_pedido.FieldByName( 'DT_PEDIDO'  ).AsDateTime;
    dtm_pedido.cds_cad_pedido.FieldByName( 'NM_PEDIDO'  ).AsString   := dtm_pedido.qry_cad_pedido.FieldByName( 'NM_PEDIDO'  ).AsString;
    dtm_pedido.cds_cad_pedido.FieldByName( 'CD_CLIENTE' ).AsInteger  := dtm_pedido.qry_cad_pedido.FieldByName( 'CD_CLIENTE' ).AsInteger;
    dtm_pedido.cds_cad_pedido.FieldByName( 'NM_CLIENTE' ).AsString   := dtm_pedido.qry_cad_pedido.FieldByName( 'NM_CLIENTE' ).AsString;
    dtm_pedido.cds_cad_pedido.FieldByName( 'TX_PEDIDO'  ).AsString   := dtm_pedido.qry_cad_pedido.FieldByName( 'TX_PEDIDO'  ).AsString;
    dtm_pedido.cds_cad_pedido.FieldByName( 'IN_PEDIDO'  ).AsString   := dtm_pedido.qry_cad_pedido.FieldByName( 'IN_PEDIDO'  ).AsString;
    dtm_pedido.cds_cad_pedido.FieldByName( 'SQ_PEDIDO'  ).AsInteger  := dtm_pedido.qry_cad_pedido.FieldByName( 'SQ_PEDIDO'  ).AsInteger;
    dtm_pedido.cds_cad_pedido.FieldByName( 'CD_PRODUTO' ).AsInteger  := dtm_pedido.qry_cad_pedido.FieldByName( 'CD_PRODUTO' ).AsInteger;
    dtm_pedido.cds_cad_pedido.FieldByName( 'NM_PRODUTO' ).AsString   := dtm_pedido.qry_cad_pedido.FieldByName( 'NM_PRODUTO' ).AsString;
    dtm_pedido.cds_cad_pedido.FieldByName( 'QT_PEDIDO'  ).AsInteger  := dtm_pedido.qry_cad_pedido.FieldByName( 'QT_PEDIDO'  ).AsInteger;
    dtm_pedido.cds_cad_pedido.FieldByName( 'VL_PEDIDO'  ).AsFloat    := dtm_pedido.qry_cad_pedido.FieldByName( 'VL_PEDIDO'  ).AsFloat;
    dtm_pedido.cds_cad_pedido.FieldByName( 'TT_PEDIDO'  ).AsFloat    := dtm_pedido.qry_cad_pedido.FieldByName( 'QT_PEDIDO'  ).AsInteger * dtm_pedido.qry_cad_pedido.FieldByName('VL_PEDIDO').AsFloat;
    dtm_pedido.cds_cad_pedido.Post;
    dtm_pedido.qry_cad_pedido.Next;
  end;

  if ( dtm_pedido.cds_cad_pedido.IsEmpty ) then
  begin
    edt_cid_reg.Text := '-1';
    ModoOper := 1;
  end
  else
  begin
    edt_cid_reg.Text := dtm_pedido.cds_cad_pedido.FieldByName('NR_PEDIDO').AsString;
    ModoOper := 2;
  end;

  edt_cod_cli.Text := dtm_pedido.cds_cad_pedido.FieldByName('CD_CLIENTE').AsString;
  edt_nom_reg.Text := dtm_pedido.cds_cad_pedido.FieldByName('NM_PEDIDO' ).AsString;
  edt_nom_cli.Text := dtm_pedido.cds_cad_pedido.FieldByName('NM_CLIENTE').AsString;
  edt_obs_reg.Text := dtm_pedido.cds_cad_pedido.FieldByName('TX_PEDIDO' ).AsString;

  if ( dtm_pedido.cds_cad_pedido.FieldByName('IN_PEDIDO').AsString = 'Ativo' ) or ( dtm_pedido.cds_cad_pedido.FieldByName('IN_PEDIDO').IsNull ) then
    cmb_atv_reg.ItemIndex := 0
  else
    cmb_atv_reg.ItemIndex := 1;

  edt_nom_reg.SetFocus;
end;

procedure Tfrm_cad_pedido.Incluir;
var
  qrySQL: TQrSQL;
  bOk   : Boolean;
  nPed  : Integer;
  nSeq  : Integer;
begin
  try
    qrySQL            := TQrSQL.Create( Nil );
    qrySQL.Connection := SqlDbCon;

    IniciarTransacao;

    nPed := GeraNumeroPedido;
    nSeq := 1;

    qrySQL.Close;
    qrySQL.SQL.Clear;
    qrySQL.Params.Clear;
    qrySQL.SQL.Text := ' INSERT INTO PEDIDO ' +
                       ' ( NR_PEDIDO   ,    ' +
                       '   DT_PEDIDO   ,    ' +
                       '   NM_PEDIDO   ,    ' +
                       '   CD_CLIENTE  ,    ' +
                       '   TX_PEDIDO   ,    ' +
                       '   IN_PEDIDO )      ' +
                       ' VALUES             ' +
                       ' ( :NR_PEDIDO  ,    ' +
                       '   :DT_PEDIDO  ,    ' +
                       '   :NM_PEDIDO  ,    ' +
                       '   :CD_CLIENTE ,    ' +
                       '   :TX_PEDIDO  ,    ' +
                       '   :IN_PEDIDO )     ' ;
    qrySQL.ParamByName('NR_PEDIDO' ).AsInteger  := nPed;
    qrySQL.ParamByName('DT_PEDIDO' ).AsDateTime := Date;
    qrySQL.ParamByName('NM_PEDIDO' ).AsString   := edt_nom_reg.Text;
    qrySQL.ParamByName('CD_CLIENTE').AsInteger  := StrToInt( edt_cod_cli.Text );
    qrySQL.ParamByName('TX_PEDIDO' ).AsString   := edt_obs_reg.Text;
    qrySQL.ParamByName('IN_PEDIDO' ).AsString   := IfThen( cmb_atv_reg.ItemIndex = 0, 'Ativo', 'Inativo' );

    try
      QrySQL.ExecSQL;
      bOk := True;
    except
      bOk := False;
    end;

    dtm_pedido.cds_cad_pedido.DisableControls;
    dtm_pedido.cds_cad_pedido.First;
    while ( not dtm_pedido.cds_cad_pedido.Eof ) and ( bOK ) do
    begin
      qrySQL.Close;
      qrySQL.SQL.Clear;
      qrySQL.Params.Clear;
      qrySQL.SQL.Text := ' INSERT INTO PEDIDO_ITEM ' +
                         ' ( NR_PEDIDO   ,         ' +
                         '   SQ_PEDIDO   ,         ' +
                         '   CD_PRODUTO  ,         ' +
                         '   QT_PEDIDO   ,         ' +
                         '   VL_PEDIDO   ,         ' +
                         '   IN_PEDIDO )           ' +
                         ' VALUES                  ' +
                         ' ( :NR_PEDIDO  ,         ' +
                         '   :SQ_PEDIDO  ,         ' +
                         '   :CD_PRODUTO ,         ' +
                         '   :QT_PEDIDO  ,         ' +
                         '   :VL_PEDIDO  ,         ' +
                         '   :IN_PEDIDO )          ' ;
      qrySQL.ParamByName('NR_PEDIDO' ).AsInteger := nPed;
      qrySQL.ParamByName('SQ_PEDIDO' ).AsInteger := nSeq;
      qrySQL.ParamByName('CD_PRODUTO').AsInteger := dtm_pedido.cds_cad_pedido.FieldByName('CD_PRODUTO').AsInteger;
      qrySQL.ParamByName('QT_PEDIDO' ).AsInteger := dtm_pedido.cds_cad_pedido.FieldByName('QT_PEDIDO' ).AsInteger;
      qrySQL.ParamByName('VL_PEDIDO' ).AsFloat   := dtm_pedido.cds_cad_pedido.FieldByName('VL_PEDIDO' ).AsFloat;
      qrySQL.ParamByName('IN_PEDIDO' ).AsString  := dtm_pedido.cds_cad_pedido.FieldByName('IN_PEDIDO' ).AsString;

      try
        QrySQL.ExecSQL;
        bOk := True;
      except
        bOk := False;
      end;

      dtm_pedido.cds_cad_pedido.Next;
      Inc( nSeq, 1 );
    end;

    dtm_pedido.cds_cad_pedido.First;
    dtm_pedido.cds_cad_pedido.EnableControls;
    qrySQL.Close;

    if ( bOK ) then
    begin
      ConcluirTransacao;
      MsgAlerta( 'Pedido cadastrado com Sucesso!' );
    end
    else
    begin
      DesfazerTransacao;
      MsgAlerta( 'Erro ao realizar o cadastro do Pedido!' );
    end;

  finally
    FreeAndNil( qrySQL );
  end;
end;

procedure Tfrm_cad_pedido.Alterar;
var
  qrySQL: TQrSQL;
  bOk   : Boolean;
  nPed  : Integer;
  nSeq  : Integer;
begin
  try
    qrySQL            := TQrSQL.Create( Nil );
    qrySQL.Connection := SqlDbCon;

    IniciarTransacao;

    nPed := StrToInt( edt_cid_reg.Text );
    nSeq := 1;

    qrySQL.Close;
    qrySQL.SQL.Clear;
    qrySQL.Params.Clear;
    qrySQL.SQL.Text := ' UPDATE PEDIDO                  ' +
                       ' SET NM_PEDIDO  = :NM_PEDIDO  , ' +
                       '     CD_CLIENTE = :CD_CLIENTE , ' +
                       '     TX_PEDIDO  = :TX_PEDIDO  , ' +
                       '     IN_PEDIDO  = :IN_PEDIDO    ' +
                       ' WHERE 1=1                      ' +
                       '   AND NR_PEDIDO = :NR_PEDIDO   ' ;
    qrySQL.ParamByName('NM_PEDIDO' ).AsString  := edt_nom_reg.Text;
    qrySQL.ParamByName('CD_CLIENTE').AsInteger := StrToInt( edt_cod_cli.Text );
    qrySQL.ParamByName('TX_PEDIDO' ).AsString  := edt_obs_reg.Text;
    qrySQL.ParamByName('IN_PEDIDO' ).AsString  := IfThen( cmb_atv_reg.ItemIndex = 0, 'Ativo', 'Inativo' );
    qrySQL.ParamByName('NR_PEDIDO' ).AsInteger := nPed;

    try
      QrySQL.ExecSQL;
      bOk := True;
    except
      bOk := False;
    end;

    qrySQL.Close;
    qrySQL.SQL.Clear;
    qrySQL.Params.Clear;
    qrySQL.SQL.Text := ' DELETE FROM PEDIDO_ITEM      ' +
                       ' WHERE 1=1                    ' +
                       '   AND NR_PEDIDO = :NR_PEDIDO ' ;
    qrySQL.ParamByName('NR_PEDIDO' ).AsInteger := nPed;

    try
      QrySQL.ExecSQL;
      bOk := True;
    except
      bOk := False;
    end;

    dtm_pedido.cds_cad_pedido.DisableControls;
    dtm_pedido.cds_cad_pedido.First;
    while ( not dtm_pedido.cds_cad_pedido.Eof ) and ( bOK ) do
    begin
      qrySQL.Close;
      qrySQL.SQL.Clear;
      qrySQL.Params.Clear;
      qrySQL.SQL.Text := ' INSERT INTO PEDIDO_ITEM ' +
                         ' ( NR_PEDIDO   ,         ' +
                         '   SQ_PEDIDO   ,         ' +
                         '   CD_PRODUTO  ,         ' +
                         '   QT_PEDIDO   ,         ' +
                         '   VL_PEDIDO   ,         ' +
                         '   IN_PEDIDO )           ' +
                         ' VALUES                  ' +
                         ' ( :NR_PEDIDO  ,         ' +
                         '   :SQ_PEDIDO  ,         ' +
                         '   :CD_PRODUTO ,         ' +
                         '   :QT_PEDIDO  ,         ' +
                         '   :VL_PEDIDO  ,         ' +
                         '   :IN_PEDIDO )          ' ;
      qrySQL.ParamByName('NR_PEDIDO' ).AsInteger := nPed;
      qrySQL.ParamByName('SQ_PEDIDO' ).AsInteger := nSeq;
      qrySQL.ParamByName('CD_PRODUTO').AsInteger := dtm_pedido.cds_cad_pedido.FieldByName('CD_PRODUTO').AsInteger;
      qrySQL.ParamByName('QT_PEDIDO' ).AsInteger := dtm_pedido.cds_cad_pedido.FieldByName('QT_PEDIDO' ).AsInteger;
      qrySQL.ParamByName('VL_PEDIDO' ).AsFloat   := dtm_pedido.cds_cad_pedido.FieldByName('VL_PEDIDO' ).AsFloat;
      qrySQL.ParamByName('IN_PEDIDO' ).AsString  := dtm_pedido.cds_cad_pedido.FieldByName('IN_PEDIDO' ).AsString;

      try
        QrySQL.ExecSQL;
        bOk := True;
      except
        bOk := False;
      end;

      dtm_pedido.cds_cad_pedido.Next;
      Inc( nSeq, 1 );
    end;

    dtm_pedido.cds_cad_pedido.First;
    dtm_pedido.cds_cad_pedido.EnableControls;
    qrySQL.Close;

    if ( bOK ) then
    begin
      ConcluirTransacao;
      MsgAlerta( 'Alteração do pedido realizada com sucesso!' );
    end
    else
    begin
      DesfazerTransacao;
      MsgAlerta( 'Erro ao tentar atualizar o Pedido!' );
    end;

  finally
    FreeAndNil( qrySQL );
  end;
end;

function Tfrm_cad_pedido.Consiste: Boolean;
begin
  if ( Trim( edt_nom_reg.Text ) = EmptyStr ) then
  begin
    MsgAlerta( Format( 'Campo: %s não pode ser vazio!', [lbl_nom_reg.Caption] ) );
    Result := False;
    edt_nom_reg.SetFocus;
  end
  else
  if ( Trim( edt_cod_cli.Text ) = EmptyStr ) then
  begin
    MsgAlerta( Format( 'Campo: %s não pode ser vazio!', [lbl_cli_reg.Caption] ) );
    Result := False;
    edt_cod_cli.SetFocus;
  end
  else
  if ( dts_cad_ped.DataSet.IsEmpty ) then
  begin
    MsgAlerta( 'Inclua ao menos um item para o pedido antes de continuar!' );
    Result := False;
  end
  else
    Result := True;
end;

procedure Tfrm_cad_pedido.dbg_psq_itmDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  dbg_psq_itm.Canvas.Font.Color := clBlack;

  if Odd( dts_cad_ped.DataSet.RecNo ) then
    dbg_psq_itm.Canvas.Brush.Color := $00D7FFD7
  else
    dbg_psq_itm.Canvas.Brush.Color := clWindow;

  dbg_psq_itm.DefaultDrawColumnCell( Rect, DataCol, Column, State );
end;

function Tfrm_cad_pedido.GeraNumeroPedido: Integer;
var
  qrySQL: TQrSQL;
begin
  try
    qrySQL            := TQrSQL.Create( Self );
    qrySQL.Connection := SqlDbCon;

    IniciarTransacao;

    qrySQL.Close;
    qrySQL.SQL.Clear;
    qrySQL.Params.Clear;
    qrySQL.SQL.Text := ' UPDATE SEQUENCIA                                          ' +
                       ' SET NR_SEQUENCIA = ( SELECT NR_SEQUENCIA + 1              ' +
                       '                      FROM SEQUENCIA                       ' +
                       '                      WHERE 1=1                            ' +
                       '                        AND NM_SEQUENCIA = :NM_SEQUENCIA ) ' +
                       ' WHERE 1=1                                                 ' +
                       '   AND NM_SEQUENCIA = :NM_SEQUENCIA                        ' ;
    qrySQL.ParamByName('NM_SEQUENCIA').AsString := 'PEDIDO';

    try
      qrySQL.ExecSQL;

      ConcluirTransacao;

      qrySQL.Close;
      qrySQL.SQL.Clear;
      qrySQL.Params.Clear;
      qrySQL.SQL.Text := ' SELECT NR_SEQUENCIA                ' +
                         ' FROM SEQUENCIA                     ' +
                         ' WHERE 1=1                          ' +
                         '   AND NM_SEQUENCIA = :NM_SEQUENCIA ' ;
      qrySQL.ParamByName('NM_SEQUENCIA').AsString := 'PEDIDO';
      qrySQL.Open;

      Result := qrySQL.Fields[0].AsInteger;

      qrySQL.Close;
    except
      DesfazerTransacao;
    end;

  finally
    FreeAndNil( qrySQL );
  end;
end;

procedure Tfrm_cad_pedido.btn_psq_cliClick(Sender: TObject);
var
  frm_psq_geral: Tfrm_psq_geral;
begin
  try
    frm_psq_geral           := Tfrm_psq_geral.Create( Self );
    frm_psq_geral.vTabela   := 'CLIENTE';
    frm_psq_geral.vSqlWhere := '';

    if ( frm_psq_geral.ShowModal = mrOk ) then
    begin
      edt_cod_cli.Text := frm_psq_geral.dts_psq_reg.DataSet.FieldByName('CD_PESQUISA').AsString;
      edt_nom_cli.Text := frm_psq_geral.dts_psq_reg.DataSet.FieldByName('NM_PESQUISA').AsString;
      edt_obs_reg.SetFocus;
    end;

  finally
    FreeAndNil( frm_psq_geral );
  end;
end;

procedure Tfrm_cad_pedido.btn_inc_itmClick(Sender: TObject);
var
  frm_itm_pedido: Tfrm_itm_pedido;
begin
  try
    frm_itm_pedido := Tfrm_itm_pedido.Create( Self );

    if ( frm_itm_pedido.ShowModal = mrOk ) then
    begin
      dts_cad_ped.DataSet.Append;
      dts_cad_ped.DataSet.FieldByName('NR_PEDIDO' ).AsInteger := StrToInt( edt_cid_reg.Text );
      dts_cad_ped.DataSet.FieldByName('CD_PRODUTO').AsInteger := StrToInt( frm_itm_pedido.edt_cod_reg.Text );
      dts_cad_ped.DataSet.FieldByName('NM_PRODUTO').AsString  := frm_itm_pedido.edt_pro_reg.Text;
      dts_cad_ped.DataSet.FieldByName('QT_PEDIDO' ).AsInteger := StrToIntDef( frm_itm_pedido.edt_qtd_reg.Text, 0 );
      dts_cad_ped.DataSet.FieldByName('VL_PEDIDO' ).AsFloat   := StrToFloatDef( frm_itm_pedido.edt_vlr_reg.Text, 0 );
      dts_cad_ped.DataSet.FieldByName('TT_PEDIDO' ).AsFloat   := dts_cad_ped.DataSet.FieldByName('VL_PEDIDO').AsFloat * dts_cad_ped.DataSet.FieldByName('QT_PEDIDO').AsInteger;
      dts_cad_ped.DataSet.FieldByName('IN_PEDIDO' ).AsString  := 'Ativo';
      dts_cad_ped.DataSet.Post;
    end;

  finally
    FreeAndNil( frm_itm_pedido );
  end;
end;

procedure Tfrm_cad_pedido.btn_del_itmClick(Sender: TObject);
begin
  if ( dts_cad_ped.DataSet.IsEmpty ) then
    MsgAlerta( 'Não há registros para continuar!' )
  else
  if MsgSimNao('Deseja excluir o registro?') then
    dts_cad_ped.DataSet.Delete;
end;

procedure Tfrm_cad_pedido.btn_alt_itmClick(Sender: TObject);
begin
  if ( dts_cad_ped.DataSet.IsEmpty ) then
    MsgAlerta( 'Não há registros para continuar!' )
  else
    try
      frm_itm_pedido := Tfrm_itm_pedido.Create( Self );

      if ( frm_itm_pedido.ShowModal = mrOk ) then
      begin
        dts_cad_ped.DataSet.Edit;
        dts_cad_ped.DataSet.FieldByName('CD_PRODUTO').AsString  := frm_itm_pedido.edt_cod_reg.Text;
        dts_cad_ped.DataSet.FieldByName('QT_PEDIDO' ).AsInteger := StrToIntDef( frm_itm_pedido.edt_qtd_reg.Text, 0 );
        dts_cad_ped.DataSet.FieldByName('VL_PEDIDO' ).AsFloat   := StrToFloatDef( frm_itm_pedido.edt_vlr_reg.Text, 0 );
        dts_cad_ped.DataSet.FieldByName('TT_PEDIDO' ).AsFloat   := dts_cad_ped.DataSet.FieldByName('VL_PEDIDO').AsFloat * dts_cad_ped.DataSet.FieldByName('QT_PEDIDO').AsInteger;
        dts_cad_ped.DataSet.FieldByName('IN_PEDIDO' ).AsString  := 'Ativo';
        dts_cad_ped.DataSet.Post;
      end;

    finally
      FreeAndNil( frm_itm_pedido );
    end;
end;

end.

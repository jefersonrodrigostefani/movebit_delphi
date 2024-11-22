{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                          https://www.jrs.net.br
 *
 * Autor...: Jrs
 * Data....: 16/02/2024
 * Objetivo: Tela de pesquisa padrão
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*/
}
unit ufrm_psq_geral;

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
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.DBCtrls,
  Vcl.StdCtrls;

type
  Tfrm_psq_geral = class(TForm)
    pnl_btn_cad: TPanel;
    btn_add_reg: TSpeedButton;
    btn_cnc_reg: TSpeedButton;
    pnl_btn_itm: TPanel;
    btn_del_itm: TSpeedButton;
    btn_inc_itm: TSpeedButton;
    btn_alt_itm: TSpeedButton;
    dbn_psq_itm: TDBNavigator;
    dbg_psq_itm: TDBGrid;
    btn_sai_reg: TSpeedButton;
    dts_psq_reg: TDataSource;
    cmb_psq_reg: TComboBox;
    edt_psq_reg: TEdit;
    lbl_psq_reg: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btn_add_regClick(Sender: TObject);
    procedure btn_cnc_regClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edt_psq_regChange(Sender: TObject);
    procedure cmb_psq_regChange(Sender: TObject);
    procedure dbg_psq_itmDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btn_sai_regClick(Sender: TObject);
    procedure edt_psq_regEnter(Sender: TObject);
    procedure edt_psq_regExit(Sender: TObject);
  private
    { Private declarations }
    procedure Mostrar;
  public
    { Public declarations }
    vTabela  : String;
    vSqlWhere: String;
  end;

var
  frm_psq_geral: Tfrm_psq_geral;

implementation

{$R *.dfm}

uses
  uGlobal,
  udtm_geral;

procedure Tfrm_psq_geral.Mostrar;
begin
  dtm_geral.qry_pesquisa.Close;
  dtm_geral.qry_pesquisa.SQL.Clear;
  dtm_geral.qry_pesquisa.Params.Clear;

  if ( vTabela = 'CLIENTE' ) then
    dtm_geral.qry_pesquisa.SQL.Text := ' SELECT T1.CD_CLIENTE AS CD_PESQUISA, ' +
                                       '        T1.NM_CLIENTE AS NM_PESQUISA  ' +
                                       ' FROM CLIENTE T1                      ' +
                                       ' WHERE 1=1                            ' +
                                       '   AND T1.IN_CLIENTE = :IN_ATIVO      ' +
                                       vSqlWhere
  else
  if ( vTabela = 'PRODUTO' ) then
    dtm_geral.qry_pesquisa.SQL.Text := ' SELECT T1.CD_PRODUTO AS CD_PESQUISA, ' +
                                       '        T1.NM_PRODUTO AS NM_PESQUISA, ' +
                                       '        T1.AP_PRODUTO AS AP_PESQUISA, ' +
                                       '        T1.VL_PRODUTO AS VL_PESQUISA  ' +
                                       ' FROM PRODUTO T1                      ' +
                                       ' WHERE 1=1                            ' +
                                       '   AND T1.IN_PRODUTO = :IN_ATIVO      ' +
                                       vSqlWhere;

  dtm_geral.qry_pesquisa.ParamByName('IN_ATIVO').AsString := 'Ativo';
  dtm_geral.qry_pesquisa.Open;
end;

procedure Tfrm_psq_geral.FormShow(Sender: TObject);
begin
  Mostrar;
end;

procedure Tfrm_psq_geral.btn_add_regClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure Tfrm_psq_geral.btn_cnc_regClick(Sender: TObject);
begin
  ModalResult := mrClose;
end;

procedure Tfrm_psq_geral.cmb_psq_regChange(Sender: TObject);
begin
  case cmb_psq_reg.ItemIndex of
    0: edt_psq_reg.NumbersOnly := True;
    1: edt_psq_reg.NumbersOnly := False;
  end;

  edt_psq_reg.SetFocus;
end;

procedure Tfrm_psq_geral.dbg_psq_itmDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  dbg_psq_itm.Canvas.Font.Color := clBlack;

  if Odd( dts_psq_reg.DataSet.RecNo ) then
    dbg_psq_itm.Canvas.Brush.Color := $00D7FFD7
  else
    dbg_psq_itm.Canvas.Brush.Color := clWindow;

  dbg_psq_itm.DefaultDrawColumnCell( Rect, DataCol, Column, State );
end;

procedure Tfrm_psq_geral.edt_psq_regChange(Sender: TObject);
begin
  dts_psq_reg.DataSet.Filtered := False;

  if ( edt_psq_reg.Text = EmptyStr ) then
    dts_psq_reg.DataSet.Filter := EmptyStr
  else
    case cmb_psq_reg.ItemIndex of
      0: dts_psq_reg.DataSet.Filter := ' CD_PESQUISA = ' + edt_psq_reg.Text;
      1: dts_psq_reg.DataSet.Filter := ' NM_PESQUISA LIKE ' + QuotedStr( '%'+edt_psq_reg.Text+'%' );
    end;

  dts_psq_reg.DataSet.Filtered := True;
end;

procedure Tfrm_psq_geral.edt_psq_regEnter(Sender: TObject);
begin
  edt_psq_reg.Color := clInfoBk;
end;

procedure Tfrm_psq_geral.edt_psq_regExit(Sender: TObject);
begin
  edt_psq_reg.Color := clWindow;
end;

procedure Tfrm_psq_geral.FormDestroy(Sender: TObject);
begin
  dts_psq_reg.DataSet.Filtered := False;
  dts_psq_reg.DataSet.Filter   := EmptyStr;
  dts_psq_reg.DataSet.Filtered := True;
  dtm_geral.qry_pesquisa.Close;
end;

procedure Tfrm_psq_geral.btn_sai_regClick(Sender: TObject);
begin
  Close;
end;

end.

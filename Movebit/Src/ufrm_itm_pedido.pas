{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                          https://www.jrs.net.br
 *
 * Autor...: Jrs
 * Data....: 16/02/2024
 * Objetivo: Arquivo de pesquisa padrão
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*/
}
unit ufrm_itm_pedido;

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
  Vcl.StdCtrls,
  Vcl.Mask;

type
  Tfrm_itm_pedido = class(TForm)
    pnl_btn_cad: TPanel;
    btn_add_reg: TSpeedButton;
    btn_cnc_reg: TSpeedButton;
    pnl_frm_cad: TPanel;
    pnl_frm_itm: TPanel;
    lbl_pro_reg: TLabel;
    edt_cod_reg: TEdit;
    edt_pro_reg: TEdit;
    btn_psq_pro: TSpeedButton;
    lbl_dsc_reg: TLabel;
    edt_dsc_reg: TEdit;
    lbl_qtd_reg: TLabel;
    edt_qtd_reg: TEdit;
    lbl_vlr_reg: TLabel;
    edt_vlr_reg: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure btn_psq_proClick(Sender: TObject);
    procedure btn_cnc_regClick(Sender: TObject);
    procedure btn_add_regClick(Sender: TObject);
    procedure edt_vlr_regKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure Mostrar;
    function Consiste: Boolean;
  public
    { Public declarations }
  end;

var
  frm_itm_pedido: Tfrm_itm_pedido;

implementation

{$R *.dfm}

uses
  uGlobal,
  udtm_pedido,
  ufrm_psq_geral;

procedure Tfrm_itm_pedido.Mostrar;
begin
  edt_cod_reg.Clear;
  edt_pro_reg.Clear;

  if ( Self.Tag = 0 ) then
  begin
    edt_dsc_reg.Clear;
    edt_qtd_reg.Clear;
    edt_vlr_reg.Clear;
  end
  else
  begin
    edt_dsc_reg.Text := dtm_pedido.cds_cad_pedido.FieldByName('AP_PRODUTO').AsString;
    edt_qtd_reg.Text := EmptyStr;
    edt_vlr_reg.Text := FormatFloat( '###,##0.00', dtm_pedido.cds_cad_pedido.FieldByName('VL_PEDIDO').AsFloat );
  end;

  edt_cod_reg.SetFocus;
end;

function Tfrm_itm_pedido.Consiste: Boolean;
begin
  if ( edt_dsc_reg.Text = EmptyStr ) then
  begin
    Result := MsgAlerta( 'Pesquise um produto para continuar!' );
    edt_dsc_reg.SetFocus;
  end
  else
  if ( edt_vlr_reg.Text = EmptyStr ) then
  begin
    Result := MsgAlerta( 'Pesquise ou digite o Preço R$ para continuar!' );
    edt_vlr_reg.SetFocus;
  end
  else
  if ( edt_qtd_reg.Text = EmptyStr ) then
  begin
    Result := MsgAlerta( 'Pesquise ou digite a Qtde para continuar!' );
    edt_qtd_reg.SetFocus;
  end
  else
    Result := True;
end;

procedure Tfrm_itm_pedido.FormShow(Sender: TObject);
begin
  Mostrar;
end;

procedure Tfrm_itm_pedido.btn_psq_proClick(Sender: TObject);
var
  frm_psq_geral: Tfrm_psq_geral;
begin
  try
    frm_psq_geral           := Tfrm_psq_geral.Create( Self );
    frm_psq_geral.vTabela   := 'PRODUTO';
    frm_psq_geral.vSqlWhere := EmptyStr;

    if ( frm_psq_geral.ShowModal = mrOk ) then
    begin
      edt_cod_reg.Text := frm_psq_geral.dts_psq_reg.DataSet.FieldByName('CD_PESQUISA').AsString;
      edt_pro_reg.Text := frm_psq_geral.dts_psq_reg.DataSet.FieldByName('NM_PESQUISA').AsString;
      edt_dsc_reg.Text := frm_psq_geral.dts_psq_reg.DataSet.FieldByName('AP_PESQUISA').AsString;
      edt_vlr_reg.Text := FormatFloat( '###,##0.00', frm_psq_geral.dts_psq_reg.DataSet.FieldByName('VL_PESQUISA').AsFloat );
      edt_qtd_reg.Text := EmptyStr;
      edt_qtd_reg.SetFocus;
    end;

  finally
    FreeAndNil( frm_psq_geral );
  end;
end;

procedure Tfrm_itm_pedido.edt_vlr_regKeyPress(Sender: TObject; var Key: Char);
begin
  if ( not ( Key in [#8, #44, '0'..'9'] ) ) then
    Key := #0;
end;

procedure Tfrm_itm_pedido.btn_add_regClick(Sender: TObject);
begin
  if ( not Consiste ) then
    Exit;
  ModalResult := mrOk;
end;

procedure Tfrm_itm_pedido.btn_cnc_regClick(Sender: TObject);
begin
  ModalResult := mrClose;
end;

end.

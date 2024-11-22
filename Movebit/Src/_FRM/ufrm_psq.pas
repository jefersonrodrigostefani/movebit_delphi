{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                             https://www.jrs.net.br
 *
 * Autor...: Jrs 
 * Data....: 16/02/2024 
 * Objetivo: Tela padrão para pesquisa
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*/
}
unit ufrm_psq;

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
  Vcl.ExtCtrls,
  Data.DB,
  System.Actions,
  Vcl.ActnList,
  System.ImageList,
  Vcl.ImgList,
  Vcl.Buttons,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ComCtrls,
  Vcl.StdCtrls;

type
  Tfrm_psq = class(TForm)
    pnl_btn_frm: TPanel;
    dbg_psq_reg: TDBGrid;
    btn_pri_reg: TSpeedButton;
    img_btn_frm: TImageList;
    act_btn_frm: TActionList;
    act_btn_pri: TAction;
    act_btn_pro: TAction;
    act_btn_ant: TAction;
    act_btn_ult: TAction;
    act_btn_inc: TAction;
    act_btn_del: TAction;
    act_btn_alt: TAction;
    act_btn_cfg: TAction;
    act_btn_hlp: TAction;
    act_btn_sai: TAction;
    btn_pro_reg: TSpeedButton;
    btn_ult_reg: TSpeedButton;
    btn_ant_reg: TSpeedButton;
    btn_inc_reg: TSpeedButton;
    btn_del_reg: TSpeedButton;
    btn_alt_reg: TSpeedButton;
    btn_cfg_reg: TSpeedButton;
    btn_hlp_reg: TSpeedButton;
    btn_sai_reg: TSpeedButton;
    dts_psq_reg: TDataSource;
    lbl_psq_reg: TLabel;
    cmb_psq_reg: TComboBox;
    edt_psq_reg: TEdit;
    procedure FormShow(Sender: TObject);
    procedure act_btn_priExecute(Sender: TObject);
    procedure act_btn_proExecute(Sender: TObject);
    procedure act_btn_antExecute(Sender: TObject);
    procedure act_btn_ultExecute(Sender: TObject);
    procedure act_btn_incExecute(Sender: TObject);
    procedure act_btn_delExecute(Sender: TObject);
    procedure act_btn_altExecute(Sender: TObject);
    procedure act_btn_saiExecute(Sender: TObject);
    procedure act_btn_cfgExecute(Sender: TObject);
    procedure act_btn_hlpExecute(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure dbg_psq_regDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edt_psq_regEnter(Sender: TObject);
    procedure edt_psq_regExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure Ajuda;
  public
    { Public declarations }
  protected
    procedure Mostrar; Virtual; Abstract;
    procedure Incluir; Virtual; Abstract;
    procedure Alterar; Virtual; Abstract;
    procedure Excluir; Virtual; Abstract;
    procedure Imprime; Virtual; Abstract;
  end;

var
  frm_psq: Tfrm_psq;

implementation

{$R *.dfm}

uses
  uGlobal,
  ufrm_principal;

procedure Tfrm_psq.Ajuda;
begin
  MsgAlerta( 'Em caso de dúvida, entre em contato:'
             +LineBreak+
             'www.movebit.com.br' );
end;

procedure Tfrm_psq.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  btn_sai_reg.Left := pnl_btn_frm.Width - btn_sai_reg.Width - 7;
  btn_hlp_reg.Left := btn_sai_reg.Left  - btn_hlp_reg.Width - 4;
end;

procedure Tfrm_psq.FormShow(Sender: TObject);
begin
  if Assigned( dts_psq_reg.DataSet ) then
    Mostrar;
end;

procedure Tfrm_psq.act_btn_priExecute(Sender: TObject);
begin
  if Assigned( dts_psq_reg.DataSet ) then
     dts_psq_reg.DataSet.First;
end;

procedure Tfrm_psq.act_btn_proExecute(Sender: TObject);
begin
  if Assigned( dts_psq_reg.DataSet ) then
     dts_psq_reg.DataSet.Next;
end;

procedure Tfrm_psq.act_btn_antExecute(Sender: TObject);
begin
  if Assigned( dts_psq_reg.DataSet ) then
     dts_psq_reg.DataSet.Prior;
end;

procedure Tfrm_psq.act_btn_ultExecute(Sender: TObject);
begin
  if Assigned( dts_psq_reg.DataSet ) then
     dts_psq_reg.DataSet.Last;
end;

procedure Tfrm_psq.act_btn_incExecute(Sender: TObject);
begin
  if Assigned( dts_psq_reg.DataSet ) then
  begin
     Incluir;
     dts_psq_reg.DataSet.Refresh;
  end;
end;

procedure Tfrm_psq.act_btn_delExecute(Sender: TObject);
begin
  if Assigned( dts_psq_reg.DataSet ) then
    if ( dts_psq_reg.DataSet.IsEmpty ) then
      MsgAlerta( 'Não há registros para continuar!' )
    else
      Excluir;
end;

procedure Tfrm_psq.act_btn_altExecute(Sender: TObject);
begin
  if Assigned( dts_psq_reg.DataSet ) then
    if ( dts_psq_reg.DataSet.IsEmpty ) then
      MsgAlerta( 'Não há registros para continuar!' )
    else
    begin
      Alterar;
      dts_psq_reg.DataSet.Refresh;
    end;
end;

procedure Tfrm_psq.act_btn_cfgExecute(Sender: TObject);
begin
  if Assigned( dts_psq_reg.DataSet ) then
    if ( dts_psq_reg.DataSet.IsEmpty ) then
      MsgAlerta( 'Não há registros para continuar!' )
    else
      Imprime;
end;

procedure Tfrm_psq.act_btn_hlpExecute(Sender: TObject);
begin
  Ajuda;
end;

procedure Tfrm_psq.act_btn_saiExecute(Sender: TObject);
begin
  if MsgSimNao( 'Deseja fechar essa janela?' ) then
    CloseTdi( frm_principal.pgc_tdi_frm );
end;

procedure Tfrm_psq.dbg_psq_regDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  dbg_psq_reg.Canvas.Font.Color := clBlack;

  if Odd( dts_psq_reg.DataSet.RecNo ) then
    dbg_psq_reg.Canvas.Brush.Color := $00FAEBDE
  else
    dbg_psq_reg.Canvas.Brush.Color := clWindow;

  dbg_psq_reg.DefaultDrawColumnCell( Rect, DataCol, Column, State );
end;

procedure Tfrm_psq.edt_psq_regEnter(Sender: TObject);
begin
  edt_psq_reg.Color := clInfoBk;
end;

procedure Tfrm_psq.edt_psq_regExit(Sender: TObject);
begin
  edt_psq_reg.Color := clWindow;
end;

procedure Tfrm_psq.FormDestroy(Sender: TObject);
begin
  dts_psq_reg.DataSet.Filtered := False;
  dts_psq_reg.DataSet.Filter   := EmptyStr;
  dts_psq_reg.DataSet.Filtered := True;
end;

end.

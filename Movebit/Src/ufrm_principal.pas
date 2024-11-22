{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                          https://www.jrs.net.br
 *
 * Autor...: Jrs
 * Data....: 16/02/2024
 * Objetivo: Arquivo principal do sistema
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*/
}
unit ufrm_principal;

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
  System.ImageList,
  Vcl.ImgList,
  Vcl.Menus,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  Tfrm_principal = class(TForm)
    stb_psq_reg: TStatusBar;
    Mm: TMainMenu;
    Mm01: TMenuItem;
    Mm02: TMenuItem;
    Mm03: TMenuItem;
    img_btn_tbr: TImageList;
    Mm02_01: TMenuItem;
    Mm02_02: TMenuItem;
    Mm03_01: TMenuItem;
    Mm01_02: TMenuItem;
    tmr_dtm_frm: TTimer;
    Mm01_01: TMenuItem;
    pnl_mnu_frm: TPanel;
    Panel1: TPanel;
    pgc_tdi_frm: TPageControl;
    Panel2: TPanel;
    Image2: TImage;
    lbl_m01_01: TLabel;
    Image1: TImage;
    lbl_m01_02: TLabel;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    lbl_m02_01: TLabel;
    Image6: TImage;
    lbl_m02_02: TLabel;
    Panel3: TPanel;
    Image7: TImage;
    lbl_m03_01: TLabel;
    Image8: TImage;
    Mm01_03: TMenuItem;
    lbl_m01_03: TLabel;
    Image9: TImage;
    Mm03_02: TMenuItem;
    Image10: TImage;
    lbl_m03_02: TLabel;
    pnl_top_frm: TPanel;
    procedure Mm01_02Click(Sender: TObject);
    procedure Mm02_01Click(Sender: TObject);
    procedure Mm02_02Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmr_dtm_frmTimer(Sender: TObject);
    procedure Mm03_01Click(Sender: TObject);
    procedure Mm01_01Click(Sender: TObject);
    procedure lbl_m01_01Click(Sender: TObject);
    procedure lbl_m01_01MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbl_m01_01MouseLeave(Sender: TObject);
    procedure lbl_m01_02MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbl_m01_02MouseLeave(Sender: TObject);
    procedure lbl_m02_01MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbl_m02_01MouseLeave(Sender: TObject);
    procedure lbl_m02_02MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbl_m02_02MouseLeave(Sender: TObject);
    procedure lbl_m03_01MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbl_m03_01MouseLeave(Sender: TObject);
    procedure Mm01_03Click(Sender: TObject);
    procedure lbl_m01_03MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbl_m01_03MouseLeave(Sender: TObject);
    procedure lbl_m01_03Click(Sender: TObject);
    procedure lbl_m01_02Click(Sender: TObject);
    procedure lbl_m02_01Click(Sender: TObject);
    procedure lbl_m02_02Click(Sender: TObject);
    procedure lbl_m03_01Click(Sender: TObject);
    procedure lbl_m03_02MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbl_m03_02MouseLeave(Sender: TObject);
    procedure lbl_m03_02Click(Sender: TObject);
    procedure Mm03_02Click(Sender: TObject);
  private
    { Private declarations }
    procedure Mostrar;
  public
    { Public declarations }
  end;

var
  frm_principal: Tfrm_principal;

implementation

{$R *.dfm}

uses
  uGlobal,
  ufrm_psq_cliente,
  ufrm_psq_produto,
  ufrm_psq_pedido, ufrm_sobre, ufrm_login, ufrm_psq_rkg;

procedure Tfrm_principal.Mostrar;
begin
  stb_psq_reg.Panels[0].Text := '127.0.0.1';
  stb_psq_reg.Panels[1].Text := 'MOVEBIT.FDB';
  stb_psq_reg.Panels[2].Text := '1.0.0.0';
  pnl_mnu_frm.Visible        := False;
end;

procedure Tfrm_principal.tmr_dtm_frmTimer(Sender: TObject);
begin
  stb_psq_reg.Panels[3].Text := FormatDateTime( 'dd/mm/yyyy  hh:nn:ss', Now );
end;

procedure Tfrm_principal.FormShow(Sender: TObject);
begin
  Mostrar;
end;

procedure Tfrm_principal.lbl_m01_01Click(Sender: TObject);
begin
  Mm01_01Click( Self );
end;

procedure Tfrm_principal.lbl_m01_01MouseLeave(Sender: TObject);
begin
  lbl_m01_01.Font.Style := [];
end;

procedure Tfrm_principal.lbl_m01_01MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lbl_m01_01.Font.Style := [fsBold];
end;

procedure Tfrm_principal.lbl_m01_02Click(Sender: TObject);
begin
  Mm01_02Click( Self );
end;

procedure Tfrm_principal.lbl_m01_02MouseLeave(Sender: TObject);
begin
  lbl_m01_02.Font.Style := [];
end;

procedure Tfrm_principal.lbl_m01_02MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lbl_m01_02.Font.Style := [fsBold];
end;

procedure Tfrm_principal.lbl_m01_03Click(Sender: TObject);
begin
  Mm01.Visible        := True;
  Mm02.Visible        := True;
  Mm03.Visible        := True;
  pnl_mnu_frm.Visible := False;
end;

procedure Tfrm_principal.lbl_m01_03MouseLeave(Sender: TObject);
begin
  lbl_m01_03.Font.Style := [];
end;

procedure Tfrm_principal.lbl_m01_03MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lbl_m01_03.Font.Style := [fsBold];
end;

procedure Tfrm_principal.lbl_m02_01Click(Sender: TObject);
begin
  Mm02_01Click( Self );
end;

procedure Tfrm_principal.lbl_m02_01MouseLeave(Sender: TObject);
begin
  lbl_m02_01.Font.Style := [];
end;

procedure Tfrm_principal.lbl_m02_01MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lbl_m02_01.Font.Style := [fsBold];
end;

procedure Tfrm_principal.lbl_m02_02Click(Sender: TObject);
begin
  Mm02_02Click( Self );
end;

procedure Tfrm_principal.lbl_m02_02MouseLeave(Sender: TObject);
begin
  lbl_m02_02.Font.Style := [];
end;

procedure Tfrm_principal.lbl_m02_02MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lbl_m02_02.Font.Style := [fsBold];
end;

procedure Tfrm_principal.lbl_m03_01Click(Sender: TObject);
begin
  Mm03_01Click( Self );
end;

procedure Tfrm_principal.lbl_m03_01MouseLeave(Sender: TObject);
begin
  lbl_m03_01.Font.Style := [];
end;

procedure Tfrm_principal.lbl_m03_01MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lbl_m03_01.Font.Style := [fsBold];
end;

procedure Tfrm_principal.lbl_m03_02Click(Sender: TObject);
begin
  Mm03_02Click( Self );
end;

procedure Tfrm_principal.lbl_m03_02MouseLeave(Sender: TObject);
begin
  lbl_m03_02.Font.Style := [];
end;

procedure Tfrm_principal.lbl_m03_02MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lbl_m03_02.Font.Style := [fsBold];
end;

procedure Tfrm_principal.Mm01_01Click(Sender: TObject);
begin
  ShowFrm( Tfrm_sobre, 0 );
end;

procedure Tfrm_principal.Mm01_02Click(Sender: TObject);
begin
  if MsgSimNao( 'Deseja sair do sistema?' ) then
    Self.Close;
end;

procedure Tfrm_principal.Mm01_03Click(Sender: TObject);
begin
  Mm01.Visible        := False;
  Mm02.Visible        := False;
  Mm03.Visible        := False;
  pnl_mnu_frm.Visible := True;
end;

procedure Tfrm_principal.Mm02_01Click(Sender: TObject);
begin
  ShowTdi( Tfrm_psq_cliente, Self.pgc_tdi_frm, 'Relação de Clientes', 4 );
end;

procedure Tfrm_principal.Mm02_02Click(Sender: TObject);
begin
  ShowTdi( Tfrm_psq_produto, Self.pgc_tdi_frm, 'Relação de Produtos', 5 );
end;

procedure Tfrm_principal.Mm03_01Click(Sender: TObject);
begin
  ShowTdi( Tfrm_psq_pedido, Self.pgc_tdi_frm, 'Relação de Pedidos', 7 );
end;

procedure Tfrm_principal.Mm03_02Click(Sender: TObject);
begin
  ShowFrm( Tfrm_psq_rkg, 0 );
end;

end.

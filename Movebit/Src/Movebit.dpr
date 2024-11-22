{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                             https://www.jrs.net.br
 *
 * Autor...: Jrs 
 * Data....: 16/02/2024 
 * Objetivo: Arquivo do projeto do sistema
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*/
}
program Movebit;

uses
  Vcl.Forms,
  ufrm_principal in 'ufrm_principal.pas' {frm_principal},
  udtm_banco in '_DTM\udtm_banco.pas' {dtm_banco: TDataModule},
  uGlobal in '_LIB\uGlobal.pas',
  ufrm_psq in '_FRM\ufrm_psq.pas' {frm_psq},
  ufrm_cad in '_FRM\ufrm_cad.pas' {frm_cad},
  ufrm_psq_cliente in 'ufrm_psq_cliente.pas' {frm_psq_cliente},
  udtm_cliente in 'udtm_cliente.pas' {dtm_cliente: TDataModule},
  ufrm_cad_cliente in 'ufrm_cad_cliente.pas' {frm_cad_cliente},
  ufrm_psq_produto in 'ufrm_psq_produto.pas' {frm_psq_produto},
  udtm_produto in 'udtm_produto.pas' {dtm_produto: TDataModule},
  ufrm_cad_produto in 'ufrm_cad_produto.pas' {frm_cad_produto},
  ufrm_psq_pedido in 'ufrm_psq_pedido.pas' {frm_psq_pedido},
  udtm_pedido in 'udtm_pedido.pas' {dtm_pedido: TDataModule},
  ufrm_cad_pedido in 'ufrm_cad_pedido.pas' {frm_cad_pedido},
  ufrm_psq_geral in 'ufrm_psq_geral.pas' {frm_psq_geral},
  udtm_geral in 'udtm_geral.pas' {dtm_geral: TDataModule},
  ufrm_itm_pedido in 'ufrm_itm_pedido.pas' {frm_itm_pedido},
  ufrm_sobre in 'ufrm_sobre.pas' {frm_sobre},
  ufrm_login in 'ufrm_login.pas' {frm_login},
  ufrm_psq_rkg in 'ufrm_psq_rkg.pas' {frm_psq_rkg};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  if ShowFrm( Tfrm_login, 0 ) then
  begin
    Application.CreateForm(Tdtm_banco, dtm_banco);
    Application.CreateForm(Tdtm_cliente, dtm_cliente);
    Application.CreateForm(Tdtm_produto, dtm_produto);
    Application.CreateForm(Tdtm_geral, dtm_geral);
    Application.CreateForm(Tdtm_pedido, dtm_pedido);
    Application.CreateForm(Tfrm_principal, frm_principal);
    Application.Run;
  end
  else
    Application.Terminate;
end.

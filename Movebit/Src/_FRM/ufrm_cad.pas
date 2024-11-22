{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                             https://www.jrs.net.br
 *
 * Autor...: Jrs 
 * Data....: 16/02/2024 
 * Objetivo: Tela de cadastro padrão
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*/
}
unit ufrm_cad;

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
  Vcl.Buttons;

type
  Tfrm_cad = class(TForm)
    pnl_frm_cad: TPanel;
    pnl_btn_cad: TPanel;
    btn_add_reg: TSpeedButton;
    btn_cnc_reg: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btn_add_regClick(Sender: TObject);
    procedure btn_cnc_regClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    ModoOper: Byte;
    procedure Mostrar; virtual; abstract;
    procedure Incluir; virtual; abstract;
    procedure Alterar; virtual; abstract;
    function Consiste: Boolean; virtual; abstract;
  end;

var
  frm_cad: Tfrm_cad;

implementation

{$R *.dfm}

uses
  uGlobal;

procedure Tfrm_cad.FormShow(Sender: TObject);
begin
  Mostrar;
  if ( ModoOper = 1 ) then
    Self.Caption := 'Movebit Sistemas | Inclusão de registro'
  else
  if ( ModoOper = 2 ) then
    Self.Caption := 'Movebit Sistemas | Alteração de registro';
end;

procedure Tfrm_cad.btn_add_regClick(Sender: TObject);
var
  sMsg: String;
begin
  if ( not Consiste ) then
    Exit;

  if ( ModoOper = 1 ) then
    sMsg := 'Confirma a inclusão do registro?'
  else
  if ( ModoOper = 2 ) then
    sMsg := 'Confirma a alteração do registro?';

  if MsgSimNao( sMsg ) then
  begin
    if ( ModoOper = 1 ) then
      Incluir
    else
    if ( ModoOper = 2 ) then
      Alterar;

    ModalResult := mrOk;
  end;
end;

procedure Tfrm_cad.btn_cnc_regClick(Sender: TObject);
var
  sMsg: String;
begin
  if ( ModoOper = 1 ) then
    sMsg := 'Deseja cancelar a inclusão do registro?'
  else
  if ( ModoOper = 2 ) then
    sMsg := 'Deseja cancelar a alteração do registro?';

  if MsgSimNao( sMsg ) then
    ModalResult := mrCancel;
end;

end.

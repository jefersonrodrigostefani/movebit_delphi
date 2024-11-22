{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                             https://www.jrs.net.br
 *
 * Autor...: Jrs 
 * Data....: 16/02/2024 
 * Objetivo: Arquivo responsável pela autenticação no sistema
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*/
}
unit ufrm_login;

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
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,
  Vcl.Buttons;

type
  Tfrm_login = class(TForm)
    pnl_cab_frm: TPanel;
    pnl_sep_reg: TPanel;
    lbl_txt_001: TLabel;
    lbl_txt_002: TLabel;
    lbl_txt_003: TLabel;
    edt_usr_reg: TEdit;
    edt_pwd_reg: TEdit;
    lbl_usr_reg: TLabel;
    lbl_pwd_reg: TLabel;
    btn_add_reg: TSpeedButton;
    btn_cnc_reg: TSpeedButton;
    lbl_rec_reg: TLabel;
    img_usr_reg: TImage;
    procedure btn_add_regClick(Sender: TObject);
    procedure btn_cnc_regClick(Sender: TObject);
    procedure lbl_rec_regMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbl_rec_regMouseLeave(Sender: TObject);
    procedure edt_usr_regEnter(Sender: TObject);
    procedure edt_usr_regExit(Sender: TObject);
    procedure edt_pwd_regEnter(Sender: TObject);
    procedure edt_pwd_regExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function Consiste: Boolean;
  public
    { Public declarations }
  end;

var
  frm_login: Tfrm_login;

implementation

{$R *.dfm}

uses
  uGlobal;

function Tfrm_login.Consiste: Boolean;
begin
  if ( Trim( edt_usr_reg.Text ) = EmptyStr ) then
  begin
    Result := MsgAlerta( 'Campo Login não pode ser vazio!' );
    edt_usr_reg.SetFocus;
  end
  else
  if ( Trim( edt_pwd_reg.Text ) = EmptyStr ) then
  begin
    Result := MsgAlerta( 'Campo Senha não pode ser vazio!' );
    edt_pwd_reg.SetFocus;
  end
  else
  if ( edt_usr_reg.Text <> 'admin' ) or ( edt_pwd_reg.Text <> '123' ) then
  begin
    Result := MsgAlerta( 'Login ou Senha inválidos! Tente novamente.' );
    edt_usr_reg.Clear;
    edt_pwd_reg.Clear;
    edt_usr_reg.SetFocus;
  end
  else
  if ( edt_usr_reg.Text = 'admin' ) and ( edt_pwd_reg.Text = '123' ) then
    Result := True;
end;

procedure Tfrm_login.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ( Key = #13 ) then
  begin
    Perform( Wm_NextDlgCtl, 0, 0 );
    Key := #0;
  end;
end;

procedure Tfrm_login.edt_usr_regEnter(Sender: TObject);
begin
  edt_usr_reg.Color := clSkyBlue;
end;

procedure Tfrm_login.edt_usr_regExit(Sender: TObject);
begin
  edt_usr_reg.Color := clWindow;
end;

procedure Tfrm_login.edt_pwd_regEnter(Sender: TObject);
begin
  edt_pwd_reg.Color := clSkyBlue;
end;

procedure Tfrm_login.edt_pwd_regExit(Sender: TObject);
begin
  edt_pwd_reg.Color := clWindow;
  if ( Trim( edt_pwd_reg.Text ) <> EmptyStr ) then
    btn_add_regClick( Self );
end;

procedure Tfrm_login.lbl_rec_regMouseLeave(Sender: TObject);
begin
  lbl_rec_reg.Font.Style := [fsUnderline];
end;

procedure Tfrm_login.lbl_rec_regMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  lbl_rec_reg.Font.Style := [fsBold, fsUnderline];
end;

procedure Tfrm_login.btn_add_regClick(Sender: TObject);
begin
  if ( not Consiste ) then
    Exit;
  ModalResult := mrOk;
end;

procedure Tfrm_login.btn_cnc_regClick(Sender: TObject);
begin
  if MsgSimNao( 'Deseja cancelar o login no sistema?' ) then
    ModalResult := mrClose;
end;

end.

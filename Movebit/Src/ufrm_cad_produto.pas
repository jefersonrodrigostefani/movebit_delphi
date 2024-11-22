unit ufrm_cad_produto;

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
  ufrm_cad,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.DBCtrls,
  Vcl.Mask,
  Data.DB;

type
  Tfrm_cad_produto = class(Tfrm_cad)
    lbl_cid_reg: TLabel;
    edt_cid_reg: TDBEdit;
    lbl_nom_reg: TLabel;
    edt_nom_reg: TDBEdit;
    lbl_ape_reg: TLabel;
    edt_ape_reg: TDBEdit;
    lbl_atv_reg: TLabel;
    cmb_atv_reg: TDBComboBox;
    lbl_vlr_reg: TLabel;
    edt_vlr_reg: TDBEdit;
    dts_cad_reg: TDataSource;
    procedure edt_vlr_regKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure Mostrar; override;
    procedure Incluir; override;
    procedure Alterar; override;
    function Consiste: Boolean; override;
  public
    { Public declarations }
  end;

var
  frm_cad_produto: Tfrm_cad_produto;

implementation

{$R *.dfm}

uses
  uGlobal,
  udtm_produto;

procedure Tfrm_cad_produto.Mostrar;
begin
  dtm_produto.qry_cad_produto.Close;
  dtm_produto.qry_cad_produto.SQL.Clear;
  dtm_produto.qry_cad_produto.Params.Clear;
  dtm_produto.qry_cad_produto.SQL.Text := ' SELECT T1.CD_PRODUTO,             ' +
                                          '        T1.NM_PRODUTO,             ' +
                                          '        T1.AP_PRODUTO,             ' +
                                          '        T1.VL_PRODUTO,             ' +
                                          '        T1.IN_PRODUTO              ' +
                                          ' FROM PRODUTO T1                   ' +
                                          ' WHERE 1=1                         ' +
                                          '   AND T1.CD_PRODUTO = :CD_PRODUTO ' ;
  dtm_produto.qry_cad_produto.ParamByName('CD_PRODUTO').AsInteger := Self.Tag;
  dtm_produto.qry_cad_produto.Open;

  TFloatField( dtm_produto.qry_cad_produto.FieldByName('VL_PRODUTO') ).DisplayFormat := '###,##0.00';
  TFloatField( dtm_produto.qry_cad_produto.FieldByName('VL_PRODUTO') ).EditFormat    := '###,##0.00';

  if ( dtm_produto.qry_cad_produto.IsEmpty ) then
  begin
    dtm_produto.qry_cad_produto.Append;
    dtm_produto.qry_cad_produto.FieldByName('IN_PRODUTO').AsString  := 'Ativo';
    ModoOper := 1;
  end
  else
  begin
    dtm_produto.qry_cad_produto.Edit;
    ModoOper := 2;
  end;

  edt_nom_reg.SetFocus;
end;

procedure Tfrm_cad_produto.Incluir;
begin
  dtm_produto.qry_cad_produto.Post;
end;

procedure Tfrm_cad_produto.Alterar;
begin
  dtm_produto.qry_cad_produto.Post;
end;

function Tfrm_cad_produto.Consiste: Boolean;
begin
  if ( Trim( edt_nom_reg.Text ) = EmptyStr ) then
  begin
    Result := MsgAlerta( Format( 'Campo: %s não pode ser vazio!', [lbl_nom_reg.Caption] ) );
    edt_nom_reg.SetFocus;
  end
  else
  if ( Trim( edt_ape_reg.Text ) = EmptyStr ) then
  begin
    Result := MsgAlerta( Format( 'Campo: %s não pode ser vazio!', [lbl_ape_reg.Caption] ) );
    edt_ape_reg.SetFocus;
  end
  else
  if ( Trim( edt_vlr_reg.Text ) = EmptyStr ) then
  begin
    Result := MsgAlerta( Format( 'Campo: %s não pode ser vazio!', [lbl_vlr_reg.Caption] ) );
    edt_vlr_reg.SetFocus;
  end
  else
    Result := True;
end;

procedure Tfrm_cad_produto.edt_vlr_regKeyPress(Sender: TObject; var Key: Char);
begin
  if ( not ( Key in [#8, #44, '0'..'9'] ) ) then
    Key := #0;
end;

end.

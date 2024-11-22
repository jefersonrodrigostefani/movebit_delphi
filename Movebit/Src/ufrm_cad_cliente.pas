{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                             https://www.jrs.net.br
 *
 * Autor...: Jrs 
 * Data....: 16/02/2024 
 * Objetivo: Arquivo responsável pelos cadastro de clientes
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*/
}
unit ufrm_cad_cliente;

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
  Data.DB,
  Vcl.DBCtrls,
  Vcl.Mask;

type
  Tfrm_cad_cliente = class(Tfrm_cad)
    lbl_cid_reg: TLabel;
    edt_cid_reg: TDBEdit;
    edt_nom_reg: TDBEdit;
    lbl_nom_reg: TLabel;
    lbl_ape_reg: TLabel;
    edt_ape_reg: TDBEdit;
    cmb_tpo_reg: TDBComboBox;
    lbl_tpo_reg: TLabel;
    edt_end_reg: TDBEdit;
    lbl_end_reg: TLabel;
    lbl_atv_reg: TLabel;
    cmb_atv_reg: TDBComboBox;
    dts_cad_reg: TDataSource;
    lbl_tel_reg: TLabel;
    edt_tel_reg: TDBEdit;
    lbl_doc_reg: TLabel;
    edt_doc_reg: TDBEdit;
    procedure cmb_tpo_regChange(Sender: TObject);
  private
    { Private declarations }
    procedure Mostrar; override;
    procedure Incluir; override;
    procedure Alterar; override;
    function Consiste: Boolean; override;
    procedure TipoPessoa( const AIndex: Integer );
  public
    { Public declarations }
  end;

var
  frm_cad_cliente: Tfrm_cad_cliente;

implementation

{$R *.dfm}

uses
  uGlobal,
  udtm_cliente;

procedure Tfrm_cad_cliente.Mostrar;
begin
  dtm_cliente.qry_cad_cliente.Close;
  dtm_cliente.qry_cad_cliente.SQL.Clear;
  dtm_cliente.qry_cad_cliente.Params.Clear;
  dtm_cliente.qry_cad_cliente.SQL.Text := ' SELECT T1.CD_CLIENTE,             ' +
                                          '        T1.NM_CLIENTE,             ' +
                                          '        T1.AP_CLIENTE,             ' +
                                          '        T1.TP_CLIENTE,             ' +
                                          '        T1.ED_CLIENTE,             ' +
                                          '        T1.FN_CLIENTE,             ' +
                                          '        T1.NR_CLIENTE,             ' +
                                          '        T1.IN_CLIENTE              ' +
                                          ' FROM CLIENTE T1                   ' +
                                          ' WHERE 1=1                         ' +
                                          '   AND T1.CD_CLIENTE = :CD_CLIENTE ' ;
  dtm_cliente.qry_cad_cliente.ParamByName('CD_CLIENTE').AsInteger := Self.Tag;
  dtm_cliente.qry_cad_cliente.Open;

  if ( dtm_cliente.qry_cad_cliente.IsEmpty ) then
  begin
    dtm_cliente.qry_cad_cliente.Append;
    dtm_cliente.qry_cad_cliente.FieldByName('TP_CLIENTE').AsString  := 'Física';
    dtm_cliente.qry_cad_cliente.FieldByName('IN_CLIENTE').AsString  := 'Ativo';
    ModoOper := 1;
  end
  else
  begin
    dtm_cliente.qry_cad_cliente.Edit;
    ModoOper := 2;
  end;

  TipoPessoa( cmb_tpo_reg.ItemIndex );
  edt_nom_reg.SetFocus;
end;

procedure Tfrm_cad_cliente.Incluir;
begin
  dtm_cliente.qry_cad_cliente.Post;
end;

procedure Tfrm_cad_cliente.Alterar;
begin
  dtm_cliente.qry_cad_cliente.Post;
end;

function Tfrm_cad_cliente.Consiste: Boolean;
begin
  if ( Trim( edt_nom_reg.Text ) = EmptyStr ) then
  begin
    Result := MsgAlerta( Format( 'Campo: %s não pode ser vazio!', [lbl_nom_reg.Caption] ) );
    edt_nom_reg.SetFocus;
  end
  else
  if ( Trim( edt_doc_reg.Text ) = EmptyStr ) then
  begin
    Result := MsgAlerta( Format( 'Campo: %s não pode ser vazio!', [lbl_doc_reg.Caption] ) );
    edt_doc_reg.SetFocus;
  end
  else
  if ( Trim( edt_tel_reg.Text ) = EmptyStr ) then
  begin
    Result := MsgAlerta( Format( 'Campo: %s não pode ser vazio!', [lbl_tel_reg.Caption] ) );
    edt_tel_reg.SetFocus;
  end
  else
    Result := True;
end;

procedure Tfrm_cad_cliente.TipoPessoa( const AIndex: Integer );
begin
  case AIndex of
    0:
      begin
        lbl_nom_reg.Caption := 'Nome';
        lbl_ape_reg.Caption := 'Apelido';
        lbl_doc_reg.Caption := 'CPF';
        TStringField( dts_cad_reg.DataSet.FieldByName('NR_CLIENTE') ).EditMask := '000.000.000-00;0;_';
        dtm_cliente.qry_cad_cliente.FieldByName('TP_CLIENTE').AsString := 'Física';
        edt_nom_reg.SetFocus;
      end;
    1:
      begin
        lbl_nom_reg.Caption := 'Razão Social';
        lbl_ape_reg.Caption := 'Nome Fantasia';
        lbl_doc_reg.Caption := 'CNPJ';
        TStringField( dts_cad_reg.DataSet.FieldByName('NR_CLIENTE') ).EditMask := '00.000.000/0000-00;0;_';
        dtm_cliente.qry_cad_cliente.FieldByName('TP_CLIENTE').AsString := 'Jurídica';
        edt_nom_reg.SetFocus;
      end;
  end;
end;

procedure Tfrm_cad_cliente.cmb_tpo_regChange(Sender: TObject);
begin
  TipoPessoa( cmb_tpo_reg.ItemIndex );
end;

end.

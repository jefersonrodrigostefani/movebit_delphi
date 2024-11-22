{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                             https://www.jrs.net.br
 *
 * Autor...: Jrs 
 * Data....: 16/02/2024 
 * Objetivo: Arquivo responsável pela pesquisa de registros
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*/
}
unit ufrm_psq_rkg;

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
  Data.DB,
  Vcl.Dialogs,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.StdCtrls;

type
  Tfrm_psq_rkg = class(TForm)
    btn_add_reg: TSpeedButton;
    btn_cnc_reg: TSpeedButton;
    edt_dat_ini: TDateTimePicker;
    edt_dat_fim: TDateTimePicker;
    lbl_dat_ini: TLabel;
    lbl_dat_fim: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btn_add_regClick(Sender: TObject);
    procedure btn_cnc_regClick(Sender: TObject);
  private
    { Private declarations }
    procedure Mostrar;
    function Consiste: Boolean;
  public
    { Public declarations }
  end;

var
  frm_psq_rkg: Tfrm_psq_rkg;

implementation

{$R *.dfm}

uses
  uGlobal,
  udtm_geral;

procedure Tfrm_psq_rkg.Mostrar;
begin
  try
    dtm_geral.qry_psq_ranking.Close;
    dtm_geral.qry_psq_ranking.SQL.Clear;
    dtm_geral.qry_psq_ranking.Params.Clear;
    dtm_geral.qry_psq_ranking.SQL.Text := ' SELECT FIRST 2                                ' +
                                          '        CD_PRODUTO,                            ' +
                                          '        NM_PRODUTO,                            ' +
                                          '        COUNT( CD_PRODUTO ) AS QT_PRODUTO      ' +
                                          '  FROM VW_PEDIDO_COMPLETA                      ' +
                                          '  WHERE 1=1                                    ' +
                                  		    '     AND DT_PEDIDO BETWEEN :DT_INI AND :DT_FIM ' +
                                  		    '  GROUP BY CD_PRODUTO,                         ' +
                                          '           NM_PRODUTO                          ' +
                                          '  HAVING( COUNT( CD_PRODUTO ) > 1 )            ' +
                                          '  ORDER BY 3 DESC                              ' ;
    dtm_geral.qry_psq_ranking.ParamByName('DT_INI').AsDate := edt_dat_ini.Date;
    dtm_geral.qry_psq_ranking.ParamByName('DT_FIM').AsDate := edt_dat_fim.Date;
    dtm_geral.qry_psq_ranking.Open;

    dtm_geral.qry_psq_ranking.FieldByName('CD_PRODUTO').DisplayLabel := 'Código';
    dtm_geral.qry_psq_ranking.FieldByName('NM_PRODUTO').DisplayLabel := 'Descrição';
    dtm_geral.qry_psq_ranking.FieldByName('QT_PRODUTO').DisplayLabel := 'Qtde';

    TFloatField( dtm_geral.qry_psq_ranking.FieldByName('QT_PRODUTO') ).DisplayFormat := '###,##0.00';

    if ( dtm_geral.qry_psq_ranking.IsEmpty ) then
      MsgAlerta( 'Não há registros para continuar!' )
    else
    begin
      MsgAlerta( '* * * Observação * * *'
                 +LineBreak+
                 'Como essa versão do Delphi que utilizei'
                 +LineBreak+
                 'não possuí o pacote do FastReports, optei'
                 +LineBreak+
                 'pela geração em arquivo CSV.'
                 +LineBreak+
                 'O arquivo será gerado no diretório da aplicação.' );

      ImprimeCSV( dtm_geral.qry_psq_ranking, ['CD_PRODUTO', 'NM_PRODUTO', 'QT_PRODUTO'], 'RANKING.CSV' );

      MsgAlerta( 'Impressão realizada com Sucesso!'
                 +LineBreak+
                 'O arquivo foi gerado dentro do'
                 +LineBreak+
                 'diretório da aplicação abaixo:'
                 +LineBreak+
                 DirApp );

      dtm_geral.qry_psq_ranking.Close;
    end;
  except
    MsgAlerta( 'Não foi possível gerar o Ranking dos produtos!' );
  end;
end;

function Tfrm_psq_rkg.Consiste: Boolean;
begin
  if ( edt_dat_fim.Date < edt_dat_ini.Date ) then
    Result := MsgAlerta( 'A data final não pode ser menor'
                         +LineBreak+
                         'que a data de início!' )
  else
    Result := True;
end;

procedure Tfrm_psq_rkg.FormCreate(Sender: TObject);
begin
  edt_dat_ini.DateTime := Date-1;
  edt_dat_fim.DateTime := Date;
end;

procedure Tfrm_psq_rkg.btn_add_regClick(Sender: TObject);
begin
  if ( not Consiste ) then
    Exit;
  Mostrar;
end;

procedure Tfrm_psq_rkg.btn_cnc_regClick(Sender: TObject);
begin
  ModalResult := mrClose;
end;

end.

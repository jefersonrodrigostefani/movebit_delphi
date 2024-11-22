{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                             https://www.jrs.net.br
 *
 * Autor...: Jrs 
 * Data....: 16/02/2024 
 * Objetivo: Arquivo responsável pelas informações do sistema
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*/
}
unit ufrm_sobre;

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
  Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons;

type
  Tfrm_sobre = class(TForm)
    pnl_cab_frm: TPanel;
    img_log_frm: TImage;
    pnl_sep_reg: TPanel;
    lbl_txt_001: TLabel;
    lbl_txt_002: TLabel;
    lbl_txt_003: TLabel;
    lbl_txt_004: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_sobre: Tfrm_sobre;

implementation

{$R *.dfm}

end.

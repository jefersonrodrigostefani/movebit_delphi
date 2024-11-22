{
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *                             https://www.jrs.net.br
 *
 * Autor...: Jrs 
 * Data....: 16/02/2024 
 * Objetivo: Arquivo responsável pelas rotinas de uso compartilhado do sistema
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*/
}

unit uGlobal;

interface

uses
  System.Classes,
  System.SysUtils,
  System.IniFiles,
  Vcl.Controls,
  Vcl.ComCtrls,
  VCL.Forms,
  FireDAC.Comp.Client,
  Data.DB,
  WinApi.Windows;

type
  TQrSQL = class ( TFDQuery );

function SqlDbCon: TFDConnection;
procedure IniciarTransacao;
procedure ConcluirTransacao;
procedure DesfazerTransacao;
function TransacaoPendente: Boolean;

function DirApp: String;
function AppExe: String;
function AppIni: String;
function IcoApp: String;

function LerIni( const Arquivo, Chave, Valor: String ): String;
function LineBreak: String;
procedure EncerrarAplicacao;

function MsgAlerta( const AMensagem: String ): Boolean;
function MsgSimNao( const AMensagem: String ): Boolean;
function ShowFrm( AFormName: TFormClass; iTag: Integer = -1 ): boolean;
procedure ShowTdi( AFormName: TFormClass; APageControl: TPageControl; ACaption: String = ''; AImageIndex: Integer = -1 );
procedure CloseTdi( APageControl: TPageControl );

procedure ImprimeCSV( DataSet: TDataSet; AColunas: Array Of String; const AFilename: String; Todos: Boolean = True );

implementation

uses
  udtm_banco;

function SqlDbCon: TFDConnection;
begin
  Result := dtm_banco.FDConnection;
end;

procedure IniciarTransacao;
begin
  try
    dtm_banco.FDConnection.StartTransaction;
  except
    MsgAlerta( 'Não foi possível iniciar a transação!' );
  end;
end;

procedure ConcluirTransacao;
begin
  try
    dtm_banco.FDConnection.Commit;
  except
    dtm_banco.FDConnection.Rollback;
    MsgAlerta( 'Não foi possível concluir a transação!' );
  end;
end;

procedure DesfazerTransacao;
begin
  try
    dtm_banco.FDConnection.Rollback;
  except
    MsgAlerta( 'Não foi possível desfazer a transação!' );
  end;
end;

function TransacaoPendente: Boolean;
begin
  Result := dtm_banco.FDConnection.InTransaction;
end;

function DirApp: String;
begin
  Result := ExtractFilePath( Application.ExeName );
end;

function AppExe: String;
begin
  Result := Application.ExeName;
end;

function AppIni: String;
begin
  Result := ChangeFileExt( AppExe, '.ini' );
end;

function IcoApp: String;
begin
  Result := ChangeFileExt( AppExe, '.ico' );
end;

function LerIni( const Arquivo, Chave, Valor: String ): String;
var
  vArq: TIniFile;
begin
  try
    vArq := TIniFile.Create( Arquivo );
    Result := vArq.ReadString( Chave, Valor, EmptyStr );
  finally
    FreeAndNil( vArq );
  end;
end;

function LineBreak: String;
begin
  Result := #10;
end;

procedure EncerrarAplicacao;
begin
  Application.Terminate;
end;

function MsgAlerta( const AMensagem: String ): Boolean;
begin
  Result := False;
  Application.MessageBox( PChar( AMensagem ), 'Atenção!', MB_ICONASTERISK or MB_OK );
end;

function MsgSimNao( const AMensagem: String ): Boolean;
begin
  Result := ( Application.MessageBox( PChar( AMensagem ),
                                     'Atenção!',
                                     MB_ICONQUESTION or
                                     MB_YESNO or
                                     MB_DEFBUTTON2 ) = IDYES );
end;

function ShowFrm(AFormName: TFormClass; iTag: Integer = -1): boolean;
begin
  try
    TForm( AFormName )     := AFormName.Create(nil);
    TForm( AFormName ).Tag := iTag;
    if TForm( AFormName ).ShowModal = mrOK then
      Result := true
    else
      Result := false;
  finally
    TForm( AFormName ).Free;
    AFormName := nil;
  end;
end;

procedure ShowTdi( AFormName   : TFormClass;
                   APageControl: TPageControl;
                   ACaption    : String = '';
                   AImageIndex : Integer = -1 );
var
  oFrm   : TForm;
  oTbs   : TTabSheet;
  i      : Integer;
  bAchou : Boolean;
begin
  bAchou := false;
  for i := 0 to Pred( APageControl.PageCount ) do
  begin
    if APageControl.Pages[i].Caption = ACaption then
    begin
      bAchou := true;
      APageControl.ActivePage := APageControl.Pages[i];
      Break;
    end;
  end;
  if not bAchou then
  begin
    oTbs                    := TTabSheet.Create( APageControl );
    oTbs.Caption            := ACaption;
    oTbs.PageControl        := APageControl;
    oTbs.ImageIndex         := AImageIndex;
    oFrm                    := AFormName.Create( nil );
    oFrm.Parent             := oTbs;
    oFrm.BorderStyle        := bsNone;
    oFrm.Align              := alClient;
    oFrm.Visible            := true;
    APageControl.ActivePage := oTbs;
  end;
end;

procedure CloseTdi( APageControl: TPageControl );
begin
  APageControl.Pages[APageControl.ActivePageIndex].Destroy;
end;

procedure ImprimeCSV( DataSet: TDataSet; AColunas: Array Of String; const AFilename: String; Todos: Boolean = True );
var
  S: TStringList;
  I: Integer;
  C: String;
begin
  try
    S := TStringList.Create;
    S.Clear;

    C := EmptyStr;

    for I := Low( AColunas ) to High( AColunas ) do
      C := C + DataSet.FieldByName( AColunas[I] ).DisplayLabel + ';';

    S.Add( C );

    DataSet.DisableControls;

    if ( not Todos ) then
    begin
      C := EmptyStr;

      for I := Low( AColunas ) to High( AColunas ) do
        C := C + DataSet.FieldByName( AColunas[I] ).AsString + ';';

      S.Add( C );
    end;

    DataSet.First;
    while ( not DataSet.Eof ) and ( Todos ) do
    begin
      C := EmptyStr;

      for I := Low( AColunas ) to High( AColunas ) do
        C := C + DataSet.FieldByName( AColunas[I] ).AsString + ';';

      S.Add( C );
      DataSet.Next;
    end;

    DataSet.First;
    DataSet.EnableControls;

    S.SaveToFile( AFilename );
  finally
    S.DisposeOf;
  end;
end;

end.

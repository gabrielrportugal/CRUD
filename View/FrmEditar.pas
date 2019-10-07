unit FrmEditar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  ClienteController, ClienteModel, CPFException;

type
  TFormularioEditar = class(TForm)
    PainelAcoes: TPanel;
    PainelCampos: TPanel;
    edtCPF: TEdit;
    edtNome: TEdit;
    lblNome: TLabel;
    lblCPF: TLabel;
    btnEditar: TButton;
    btnDeletar: TButton;
    procedure btnDeletarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FClienteControl: TClienteControl;
    FCliente: TCliente;
    procedure AtualizarEditCliente;
    { Private declarations }
  public
    property ClienteControl: TClienteControl read FClienteControl
      write FClienteControl;
    property Cliente: TCliente read FCliente write FCliente;
    { Public declarations }
  end;

var
  FormularioEditar: TFormularioEditar;

implementation

uses
  System.UITypes;

{$R *.dfm}

// M�todo que insere no objeto FCliente os dados digitados nos Edits
procedure TFormularioEditar.AtualizarEditCliente;
begin
  FCliente.Nome := edtNome.Text;
  FCliente.CPF := edtCPF.Text;
end;

// Clique no bot�o deletar que exclui um item do banco de dados
procedure TFormularioEditar.btnDeletarClick(Sender: TObject);
begin
  if (MessageDlg('Deseja remover ? ', mtConfirmation, [mbOK, mbCancel], 0)
    = mrOK) then
  begin
    try
      FClienteControl.ClienteDAO.Remover(Cliente);
      ModalResult := mrOK;
    except
      on E: Exception do
        raise Exception.Create('Ocorreu um erro : ' + E.Message);
    end;
  end;
end;

// Clique no bot�o editar que modifica os dados no banco atrav�s do controlador
procedure TFormularioEditar.btnEditarClick(Sender: TObject);
begin
  with FClienteControl do
    try
      AtualizarEditCliente;
      ValidarCPF(edtCPF.Text);
      ClienteDAO.CPFDuplicado(FCliente, true);
      if (MessageDlg('Cliente editado', mtConfirmation, [mbOK], 0) = mrOK) then
      begin
        ClienteDAO.Editar(FCliente);
        ModalResult := mrOK;
      end;
    except
      on E: ECpfInvalido do
        raise;
      on E: ECpfDuplicado do
        raise;
      on E: Exception do
        raise Exception.Create('Ocorreu um erro :' + E.Message);
    end;

end;

// Ao exibir o Form, os dados do objeto FCliente s�o carregados no Edit.
procedure TFormularioEditar.FormShow(Sender: TObject);
begin
  edtNome.Text := FCliente.Nome;
  edtCPF.Text := FCliente.CPF;
end;

end.

unit UPrincipal;

interface

uses
  {Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Buttons;}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Imaging.jpeg, IdHashMessageDigest, iniFiles, DateUtils,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, System.Actions, Vcl.ActnList,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus,
  Vcl.PlatformDefaultStyleActnCtrls, VCLTee.TeCanvas, Vcl.Buttons, XiButton,
  Vcl.XPMan, dxGDIPlusClasses;

type
  TFPrincipal = class(TForm)
    imgBackground: TImage;
    PanelLinhaSuperior: TPanel;
    PanelPrincipal: TPanel;
    imgMenu: TImage;
    btnPagamento: TSpeedButton;
    btnAluno: TSpeedButton;
    PainelCentral_Menu: TPanel;
    btnEquipamento: TSpeedButton;
    btnGrupo: TSpeedButton;
    btnFicha: TSpeedButton;
    btnExercicio: TSpeedButton;
    btnPatologias: TSpeedButton;
    btnUsuario: TSpeedButton;
    bntBackUp: TSpeedButton;
    procedure btnPagamentoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function fncAlturaBarraTarefas: Integer;
    procedure CriarForm(Tela, Desc : String);
    procedure btnAlunoClick(Sender: TObject);
    procedure btnEquipamentoClick(Sender: TObject);
    procedure btnGrupoClick(Sender: TObject);
    procedure btnPatologiasClick(Sender: TObject);
    procedure btnExercicioClick(Sender: TObject);
    procedure btnUsuarioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

uses ubase, vcl.themes, vcl.styles, UDataModule;

procedure TFPrincipal.btnAlunoClick(Sender: TObject);
begin
  CriarForm('F01001', 'Aluno');
end;

procedure TFPrincipal.btnEquipamentoClick(Sender: TObject);
begin
  CriarForm('F01003', 'Equipamento');
end;

procedure TFPrincipal.btnExercicioClick(Sender: TObject);
begin
  CriarForm('F01006', 'Exerc�cio');
end;

procedure TFPrincipal.btnGrupoClick(Sender: TObject);
begin
  CriarForm('F01004', 'Grupo de Exerc�cio');
end;

procedure TFPrincipal.btnPagamentoClick(Sender: TObject);
begin
  CriarForm('F01002', 'Pagamento');
end;

procedure TFPrincipal.btnPatologiasClick(Sender: TObject);
begin
  CriarForm('F01007', 'Patologias e Relatos F�sicos');
end;

procedure TFPrincipal.btnUsuarioClick(Sender: TObject);
begin
  CriarForm('F01008', 'Usu�rio');
end;

procedure TFPrincipal.CriarForm(Tela, Desc: String);
var
  PClass : TPersistentClass;
begin
  PClass := GetClass('T' + trim(Tela));
  if (PCLass <> nil) then
  begin
    with tFormClass(PClass).Create(Application) do
      try
        Name := Tela;
        Caption := Tela + ' - ' + Desc;

        //Oculta a Barra de Titulo
        SetWindowLong(Handle,
                  GWL_STYLE,
                  GetWindowLong(Handle,GWL_STYLE) and not WS_CAPTION);

        //Laugura
        Width := (Screen.Width);

        //Altura = altura da tela - Altura do Panel Menu - Altura Barra de Tarefas - Altura barra de tituto do formPrincipal
        //*Frame Com panel da FPrincipal a mostra
        //Height := (Screen.Height) - (FPrincipal.Panel.Height) - fncAlturaBarraTarefas - GetSystemMetrics(SM_CYCAPTION) - 2;
        //*Altura Frame Completo
        Height := Screen.Height - fncAlturaBarraTarefas - GetSystemMetrics(SM_CYCAPTION) - 2;

        //Alinha o Frame no final da tela
        Align := alBottom;

        //Frame Meio Transparente
        //AlphaBlend := true;
        //AlphaBlendValue := 200;

        //Mostra
        ShowModal;
      finally
        Free;
        tFormClass(PClass) := nil;
      end;
   end;
end;

function TFPrincipal.fncAlturaBarraTarefas: Integer;
var
  rRect: TRect;
  rBarraTarefas: HWND;
begin
  //Localiza o Handle da barra de tarefas
  rBarraTarefas := FindWindow('Shell_TrayWnd', nil);

  //Pega o "ret�ngulo" que envolve a barra e sua altura
  GetWindowRect(rBarraTarefas, rRect);

  //Retorna a altura da barra
  Result := rRect.Bottom - rRect.Top;
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
var
iduser : string;
idInterface : integer;
ArqIni: TIniFile;
nomeInterface : string;
begin
  //Defini��o de acesso do usu�rio
  ArqIni := TIniFile.Create( ExtractFilePath(Application.ExeName) + '\user.ini' );
  try
    iduser := ArqIni.ReadString('usuario', 'iduser', iduser);

    //Obtem id tipo de usu�rio
    Dmodule.idTipoUsuario := 0;
    Dmodule.qAux.close;
    Dmodule.qAux.SQL.Text := 'select * from usuario where idusuario =:idU';
    Dmodule.qAux.ParamByName('idU').Value := strtoint(idUser);
    Dmodule.qAux.open;
    Dmodule.idTipoUsuario := Dmodule.qAux.FieldByName('idTipoUsuario').AsInteger;

    DModule.qAcesso.Close;
    DModule.qAcesso.SQL.Text := 'select s.*, i.idinterface as interface, m.idmodulo as modulo from seguranca s ';
    DModule.qAcesso.SQL.Add('left outer join interface i on i.idinterface = s.idinterface ');
    DModule.qAcesso.SQL.Add('left outer join modulo m on m.idmodulo = i.idmodulo ');
    DModule.qAcesso.SQL.Add('where s.idTipousuario =:idTU');
    DModule.qAcesso.ParamByName('idTU').Value := Dmodule.idTipoUsuario;
    DModule.qAcesso.Open();
    DModule.cdsAcesso.Close;
    DModule.cdsAcesso.Open;
    DModule.cdsAcesso.First;
  finally
    ArqIni.Free;
  end;

end;


procedure TFPrincipal.FormShow(Sender: TObject);
begin
    //ATRIBUI DATAHOJE
    DModule.qAux.SQL.Text := 'select CURDATE() AS DATAHOJE';
    DModule.qAux.Close;
    DModule.qAux.Open;
    DModule.dataHoje := DModule.qAux.FieldByName('DATAHOJE').AsDateTime;
end;

end.

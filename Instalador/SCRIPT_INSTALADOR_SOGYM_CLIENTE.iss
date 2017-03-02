; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{F40F620E-5E20-49E2-ADA5-599DAAB6E091}
AppName=SOGYM
AppVerName=SOGYM 1.0
AppPublisher=RN, Inc.
DefaultDirName=C:\SOGYM
DisableDirPage=yes
DefaultGroupName=SOGYM
OutputBaseFilename=INSTALADOR_SOGYM_CLIENTE
Compression=lzma
SolidCompression=yes

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Files]
Source: "C:\Users\Ruan\Documents\Embarcadero\Studio\Projects\AcademiaNorte\Instalador\BASE SOGYM\SOGYM.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Ruan\Documents\Embarcadero\Studio\Projects\AcademiaNorte\Instalador\BASE SOGYM\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\SOGYM"; Filename: "{app}\SOGYM.exe"
Name: "{group}\{cm:UninstallProgram,SOGYM}"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\SOGYM.exe"; Description: "{cm:LaunchProgram,SOGYM}"; Flags: nowait postinstall skipifsilent


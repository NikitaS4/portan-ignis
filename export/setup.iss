; ��� ����������
#define   Name       "Portan Ignis"
; ������ ����������
#define   Version    "0.4.0"
; �����-�����������
#define   Publisher  "Portan Ignis"
; ���� ����� ������������
#define   URL        "https://github.com/re1nex/portan-ignis"
; ��� ������������ ������
#define   ExeName    "Portan Ignis.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{6E26AEA4-0A42-4403-A31D-8E2F014CC4C9}
AppName={#Name}
AppVersion={#Version}
AppPublisher={#Publisher}
AppPublisherURL={#URL}
AppSupportURL={#URL}
AppUpdatesURL={#URL}
; ���� ��������� ��-���������
DefaultDirName={pf}\{#Name}
; ��� ������ � ���� "����"
DefaultGroupName={#Name}
AllowNoIcons=yes
OutputBaseFilename=setup
SetupIconFile=C:\Users\User\portan-ignis\icon.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"; LicenseFile: "LICENSE.txt"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"; LicenseFile: "LICENSE.txt"

[Tasks]
; �������� ������ �� ������� �����
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked



[Files]

; ����������� ����
Source: "C:\Users\User\portan-ignis\export\Portan Ignis.exe"; DestDir: "{app}"; Flags: ignoreversion

; ������������� �������
;Source: "C:\Users\User\portan-ignis\export\Portan Ignis.pck"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]

Name: "{group}\{#Name}"; Filename: "{app}\{#ExeName}"

Name: "{commondesktop}\{#Name}"; Filename: "{app}\{#ExeName}"; Tasks: desktopicon

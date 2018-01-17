; Request application privileges for Windows Vista
RequestExecutionLevel admin

; Some defines
!define PRODUCT_NAME "AVI MetaEdit"
!define PRODUCT_NAME_EXE "${PRODUCT_NAME}.exe"
!define PRODUCT_PUBLISHER "U.S. National Archives"
!define PRODUCT_VERSION "1.0.1"
!define PRODUCT_VERSION4 "${PRODUCT_VERSION}.0"
!define PRODUCT_WEB_SITE "http://www.archives.gov/"
!define COMPANY_REGISTRY "Software\U.S. National Archives"
!define PRODUCT_REGISTRY "Software\U.S. National Archives\AVI MetaEdit"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\${PRODUCT_NAME_EXE}"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; Compression
SetCompressor /FINAL /SOLID lzma

; x64 stuff
!include "x64.nsh"

; Modern UI
!include "MUI2.nsh"
!define MUI_ABORTWARNING
!define MUI_ICON "..\..\Source\Resource\Image\Brand\Logo.ico"

; Language Selection Dialog Settings
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Installer pages
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!define MUI_WELCOMEFINISHPAGE_BITMAP "..\..\Source\Resource\Image\Windows_Finish.bmp"
!insertmacro MUI_PAGE_FINISH
; Uninstaller pages
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Language files
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_RESERVEFILE_LANGDLL

; Info
VIProductVersion "${PRODUCT_VERSION4}"
VIAddVersionKey "ProductName" "${PRODUCT_NAME}" 
VIAddVersionKey "Comments" "All about editing your AVI files"
VIAddVersionKey "CompanyName" "U.S. National Archives"
VIAddVersionKey "LegalTrademarks" "BSD license" 
VIAddVersionKey "LegalCopyright" "" 
VIAddVersionKey "FileDescription" "All about editing your AVI files"
VIAddVersionKey "FileVersion" "${PRODUCT_VERSION}"
BrandingText " "

; Modern UI end

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "..\..\Release\AVIMetaEdit_GUI_${PRODUCT_VERSION}_Windows_x64.exe"
InstallDir "$PROGRAMFILES64\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails nevershow
ShowUnInstDetails nevershow

Function .onInit
  ${If} ${RunningX64}
    SetRegView 64
  ${Else}
    MessageBox MB_OK|MB_ICONSTOP 'You are trying to install the 64-bit version of ${PRODUCT_NAME} on 32-bit Windows.$\r$\nPlease download and use the 32-bit version instead.$\r$\nClick OK to quit Setup.'
    Quit
  ${EndIf}
FunctionEnd

Section "SectionPrincipale" SEC01
  SetOverwrite on

  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_NAME_EXE}" "" "" "" "" "" "${PRODUCT_NAME} ${PRODUCT_VERSION}"
  SetOutPath "$INSTDIR"
  File "/oname=\${PRODUCT_NAME_EXE}" "..\..\Project\MSVC2017\GUI\x64\Release\AVI_MetaEdit_GUI.exe"
  File "/oname=History.txt" "..\..\History_GUI.txt"
  File "..\..\License.html"
  File  "/oname=ReadMe.txt""..\..\Release\ReadMe_GUI_Windows.txt"
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"

  ; Delete files that might be present from older installation
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\AVI_MetaEdit.exe"
  Delete "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_NAME}\Website.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_NAME}\History.lnk"
  RMDir  "$SMPROGRAMS\${PRODUCT_NAME}"
  Delete "$PROGRAMFILES64\U.S. National Archives\AVI MetaEdit\AVI MetaEdit.url"
  Delete "$PROGRAMFILES64\U.S. National Archives\AVI MetaEdit\aviedit-gui.exe"
  Delete "$PROGRAMFILES64\U.S. National Archives\AVI MetaEdit\uninst.exe"
  Delete "$PROGRAMFILES64\U.S. National Archives\AVI MetaEdit\License.html"
  Delete "$PROGRAMFILES64\U.S. National Archives\AVI MetaEdit\History.txt"
  Delete "$PROGRAMFILES64\U.S. National Archives\AVI MetaEdit\ReadMe.txt"
  RMDir "$PROGRAMFILES64\U.S. National Archives\AVI MetaEdit\AVI MetaEdit"
  RMDir "$PROGRAMFILES64\U.S. National Archives" ; only if empty
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\${PRODUCT_NAME}.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\\${PRODUCT_NAME_EXE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
SectionEnd

Section Uninstall
  SetRegView 64
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\${PRODUCT_NAME_EXE}"
  Delete "$INSTDIR\History.txt"
  Delete "$INSTDIR\License.html"
  Delete "$INSTDIR\ReadMe.txt"
  Delete "$SMPROGRAMS\${PRODUCT_NAME}.lnk"
  RMDir "$INSTDIR"

  DeleteRegKey HKLM "${PRODUCT_REGISTRY}"
  DeleteRegKey /ifempty HKLM "${COMPANY_REGISTRY}"
  DeleteRegKey HKCU "${PRODUCT_REGISTRY}"
  DeleteRegKey /ifempty HKCU "${COMPANY_REGISTRY}"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd

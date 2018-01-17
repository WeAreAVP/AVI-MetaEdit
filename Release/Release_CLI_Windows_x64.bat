@rem echo off

rem --- Search binaries ---
set BPATH=
if exist "%~dp0\..\..\..\MediaArea-Utils-Binaries" set BPATH="%~dp0\..\..\..\MediaArea-Utils-Binaries"
if exist "%~dp0\..\..\MediaArea-Utils-Binaries" set BPATH="%~dp0\..\..\MediaArea-Utils-Binaries"
if "%BPATH%"=="" (
    echo "ERROR: binaries path not found"
    exit /b 1
)

@rem --- Clean up ---
del   AVIMetaEdit_CLI_Windows_x64.zip
rmdir AVIMetaEdit_CLI_Windows_x64 /S /Q
mkdir AVIMetaEdit_CLI_Windows_x64

rem --- Copying : Exe ---
xcopy ..\Project\MSVC2017\CLI\x64\Release\avimetaedit.exe AVIMetaEdit_CLI_Windows_x64\ /S

rem --- Copying : Plugins ---
xcopy ..\Source\Ressource\Plugin\Custom\* AVIMetaEdit_CLI_Windows_x64\Plugin\Custom\ /S

rem --- Copying : Information files ---
copy ..\License.html AVIMetaEdit_CLI_Windows_x64\
copy ..\History_CLI.txt AVIMetaEdit_CLI_Windows_x64\History.txt
copy ..\conformance_point_document.xsd AVIMetaEdit_CLI_Windows_x64\
copy Readme_CLI_Windows.txt AVIMetaEdit_CLI_Windows_x64\ReadMe.txt

rem --- Compressing Archive ---
cd AVIMetaEdit_CLI_Windows_x64\
%BPATH%\Windows\7-Zip\7z a -r -tzip ..\AVIMetaEdit_CLI_Windows_x64.zip *
cd ..


rem --- Clean up ---
if "%1"=="SkipCleanUp" goto SkipCleanUp
rmdir AVIMetaEdit_CLI_Windows_x64\ /S /Q
:SkipCleanUp

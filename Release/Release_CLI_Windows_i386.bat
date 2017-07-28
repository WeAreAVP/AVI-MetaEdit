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
del   AVI_MetaEdit_CLI_Windows_i386.zip
rmdir AVI_MetaEdit_CLI_Windows_i386 /S /Q
mkdir AVI_MetaEdit_CLI_Windows_i386

rem --- Copying : Exe ---
xcopy ..\Project\MSVC2015\CLI\Win32\Release\avimetaedit.exe AVI_MetaEdit_CLI_Windows_i386\ /S

rem --- Copying : Plugins ---
xcopy ..\Source\Resource\Plugin\Custom\* AVI_MetaEdit_CLI_Windows_i386\Plugin\Custom\ /S

rem --- Copying : Information files ---
copy ..\License.html AVI_MetaEdit_CLI_Windows_i386\
copy ..\History_CLI.txt AVI_MetaEdit_CLI_Windows_i386\History.txt
copy ..\conformance_point_document.xsd AVI_MetaEdit_CLI_Windows_i386\
copy Readme_CLI_Windows.txt AVI_MetaEdit_CLI_Windows_i386\ReadMe.txt

rem --- Compressing Archive ---
cd AVI_MetaEdit_CLI_Windows_i386\
%BPATH%\Windows\7-Zip\7z a -r -tzip ..\AVI_MetaEdit_CLI_Windows_i386.zip *
cd ..

rem --- Clean up ---
if "%1"=="SkipCleanUp" goto SkipCleanUp
rmdir AVI_MetaEdit_CLI_Windows_i386\ /S /Q
:SkipCleanUp

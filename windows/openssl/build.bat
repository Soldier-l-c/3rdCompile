@echo off

set "platform=%1"
set "build_path=%2"

echo "build path:%build_path%"
echo "platform:%platform%"

set /a success=0
set "vc_win="
set "vc_bat="

set "vc_bat_path=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\"

if "%build_path%" == "" (
goto end
)
if "%platform%" == "" (
goto end
)

if "%platform%"=="64" (
	set vc_win=VC-WIN64A
	set vc_bat=vcvars64.bat
) else if "%platform%"=="32" (
	set vc_win=VC-WIN32
	set vc_bat=vcvars32.bat
) else (
	goto end
)

call "%vc_bat_path%%vc_bat%"

perl configure no-shared %vc_win% --prefix=%build_path%

nmake clean

namke 

nmake install

set success=1

goto end

:end
if %success% == 0 (
	echo "build failed!"
) else (
	echo "build success!"
)
pause
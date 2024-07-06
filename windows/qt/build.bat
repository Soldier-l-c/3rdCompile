@echo off

set "platform=%1"

if "%platform%" == "" (
	goto end
)

set "vc_bat="

if "%platform%"=="64" ( 
	set vc_bat=vcvars64.bat
) else if "%platform%"=="86" ( 
	set vc_bat=vcvars32.bat
) else ( 
	goto end 
)

set /a success=0

set "vc_bat_path=D:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\%vc_bat%"
set "LLVM_INSTALL_DIR=D:\Develop\LLVM"
set "install_dir=D:\Develop\QT5.15_X%platform%"
set "openssl_dir=D:\GitResponse\GitHub\3rdCompile\windows\openssl\release\mt\x%platform%"

echo "platform:%platform%"
echo "install_dir:%install_dir%"
echo "openssl_dir:%openssl_dir%"
echo "vc_bat_path:%vc_bat_path%"

pause

call "%vc_bat_path%"

pause

configure -prefix "%install_dir%" -static -debug-and-release -verbose -nomake tests -nomake examples -skip qtnetworkauth -skip qtserialport -skip qtserialbus -skip qtimageformats -skip qtactiveqt -skip qtmultimedia -skip qtwebchannel -skip qtwebengine -skip qtwebview -skip qtwebsockets -skip qtquick3d -skip qtlocation -skip qtwayland -skip qtwebengine -skip qtwebchannel -skip qtwebview -skip qtmacextras -skip qtdoc -skip qtgamepad -skip qtandroidextras -skip qtcharts -skip qtconnectivity -skip qtdatavis3d -skip qtdeclarative -skip qtdoc -skip qtlocation -skip qtpurchasing -skip qtremoteobjects -skip qtscript -skip qtscxml -skip qtsensors -skip qtspeech -skip qtsvg -skip qttools -skip qttranslations -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtwinextras -skip qtx11extras -skip qtxmlpatterns -skip qt3d -skip qtcanvas3d -skip qtvirtualkeyboard -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtmacextras -skip qtdoc -skip qtgamepad -skip qtandroidextras -skip qtcharts -skip qtconnectivity -skip qtdatavis3d -skip qtdeclarative -skip qtdoc -skip qtlocation -skip qtpurchasing -skip qtremoteobjects -skip qtscript -skip qtscxml -skip qtsensors -skip qtspeech -skip qtsvg -skip qttools -skip qttranslations -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtwinextras -skip qtx11extras -skip qtxmlpatterns -skip qt3d -skip qtcanvas3d -skip qtvirtualkeyboard -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtmacextras -skip qtdoc -skip qtgamepad -skip qtandroidextras -skip qtcharts -skip qtconnectivity -skip qtdatavis3d -skip qtdeclarative -skip qtdoc -skip qtlocation -skip qtpurchasing -skip qtremoteobjects -skip qtscript -skip qtscxml -skip qtsensors -skip qtspeech -skip qtsvg -skip qttools -skip qttranslations -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtwinextras -skip qtx11extras -skip qtxmlpatterns -skip qt3d -skip qtcanvas3d -skip qtvirtualkeyboard -opensource -confirm-license -opengl dynamic -openssl-linked OPENSSL_PREFIX="%openssl_dir%"

pause

nmake

nmake install

nmake docs

nmake install_docs

:end
if %success% == 0 (
	echo "build failed!"
) else (
	echo "build success!"
)
pause

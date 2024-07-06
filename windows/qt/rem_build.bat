@echo off

REM 安装前准备
REM 1.安装python，用的是anaconda python 3.11，要求2.7以上
REM 2.安装perl，安装的是strawberry-perl-5.32.1.1-64bit.msi，要求5.12以上，下载地址：https://strawberryperl.com/releases.html
REM 3.安装ruby（可选），ruby是为了编译WebKit，如果不编译该模块应该就不需要了（我没有测试）。我这里安装的是rubyinstaller-3.2.2-1-x64.exe，下载地址：https://rubyinstaller.org/2023/04/01/rubyinstaller-3.2.2-1-3.1.4-1-3.0.6-1-and-2.7.8-1-released.html
REM 4.安装clang（可选），编译qtdoc时需要，影响Qt Assistant里的参考文档，如果编译了就可以在qt designer的帮助里查看参考文档。我这里安装的是LLVM-11.0.0-win64.exe https://releases.llvm.org/download.html
REM 5.安装openssl（可选），编译Qt Network时需要，为了支持 Secure Sockets Layer (SSL) 。下载源码自己编译（教程https://blog.csdn.net/Kelvin_Yan/article/details/105078461），openssl-1.1.1w.tar.gz，下载地址：https://www.openssl.org/source/
REM 6.安装jom（可选），qt提供的一个工具，可以实现并行编译，提高编译速度。安装的是jom_1_1_4.zip，官网经常打不开，可以到镜像源去下载https://mirrors.tuna.tsinghua.edu.cn/qt/official_releases/jom/
REM 7.下载Qt源码，官网经常打不开，可以到镜像源去下载 qt-everywhere-opensource-src-5.15.9.zip https://mirrors.tuna.tsinghua.edu.cn/qt/archive/qt/5.15/5.15.9/single/

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

REM 先创建x86编译环境

call "%vc_bat_path%"

REM -prefix "E:\Qt\5.15.9\msvc2019_64"   安装路径，执行install后将会输出到该路径
REM -shared 生成动态链接库，相应地，-static就是静态库，如果都不指定，默认是-shared
REM -debug-and-release 生成debug和release两个版本的库，也可以单独指定其中一种，-debug或-release，如果都不指定，默认是-release
REM -verbose 在configure过程中打印详细信息，方便排查问题
REM -nomake tests 默认生成以下几部分（part）：libs、examples、tools、tests，这里就是告诉编译器不要生成tests这个part,examples也建议跳过
REM -skip qtwebengine 跳过某个模块，这里不编译qtwebengine，它将非常耗时。其余模块也很耗时，如果仅仅用界面部分，建议只编译qtbase，其余模块全部跳过
REM -opensource 代表我们编译的是开源版本，相应地，-commercial代表商业许可的版本
REM -confirm-license 自动确认许可
REM -opengl dynamic 动态加载图形驱动，官方推荐采用该方式，具体看"Qt for Windows - Requirements"的"Graphics Drivers"一节
REM -openssl-runtime OPENSSL_INCDIR="D:\openssl\vc16_x64\include" 设置openssl，也可以不填该参数，我这里是动态链接的方式，一共有动态链接显示加载、动态链接隐式加载、静态库3种方式，具体见"Qt for Windows - Requirements"的"Libraries"一节
REM -openssl-linked OPENSSL_PREFIX="%openssl_dir%",静态链接openssl

configure -prefix "%install_dir%" -static -debug-and-release -verbose -nomake tests -nomake examples -skip qtnetworkauth -skip qtserialport -skip qtserialbus -skip qtimageformats -skip qtactiveqt -skip qtmultimedia -skip qtwebchannel -skip qtwebengine -skip qtwebview -skip qtwebsockets -skip qtquick3d -skip qtlocation -skip qtwayland -skip qtwebengine -skip qtwebchannel -skip qtwebview -skip qtmacextras -skip qtdoc -skip qtgamepad -skip qtandroidextras -skip qtcharts -skip qtconnectivity -skip qtdatavis3d -skip qtdeclarative -skip qtdoc -skip qtlocation -skip qtpurchasing -skip qtremoteobjects -skip qtscript -skip qtscxml -skip qtsensors -skip qtspeech -skip qtsvg -skip qttools -skip qttranslations -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtwinextras -skip qtx11extras -skip qtxmlpatterns -skip qt3d -skip qtcanvas3d -skip qtvirtualkeyboard -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtmacextras -skip qtdoc -skip qtgamepad -skip qtandroidextras -skip qtcharts -skip qtconnectivity -skip qtdatavis3d -skip qtdeclarative -skip qtdoc -skip qtlocation -skip qtpurchasing -skip qtremoteobjects -skip qtscript -skip qtscxml -skip qtsensors -skip qtspeech -skip qtsvg -skip qttools -skip qttranslations -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtwinextras -skip qtx11extras -skip qtxmlpatterns -skip qt3d -skip qtcanvas3d -skip qtvirtualkeyboard -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtmacextras -skip qtdoc -skip qtgamepad -skip qtandroidextras -skip qtcharts -skip qtconnectivity -skip qtdatavis3d -skip qtdeclarative -skip qtdoc -skip qtlocation -skip qtpurchasing -skip qtremoteobjects -skip qtscript -skip qtscxml -skip qtsensors -skip qtspeech -skip qtsvg -skip qttools -skip qttranslations -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtwinextras -skip qtx11extras -skip qtxmlpatterns -skip qt3d -skip qtcanvas3d -skip qtvirtualkeyboard -opensource -confirm-license -opengl dynamic -openssl-linked OPENSSL_PREFIX="%openssl_dir%"

REM nmake该步骤可能会耗时很久，做好准备

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

REM # 转到Qt源代码根目录
REM cd path\to\qt\source
 
REM # 配置Qt，包括qtwebengine模块
REM configure -opensource -confirm-license -nomake examples -nomake tests -opengl desktop -skip qtwebchannel -skip qtwebengine -skip qtwebview -skip qtwebsockets -skip qtquick3d -skip qtlocation -skip qtwayland -skip qtwebengine -skip qtwebchannel -skip qtwebview -skip qtmacextras -skip qtdoc -skip qtgamepad -skip qtandroidextras -skip qtcharts -skip qtconnectivity -skip qtdatavis3d -skip qtdeclarative -skip qtdoc -skip qtlocation -skip qtpurchasing -skip qtremoteobjects -skip qtscript -skip qtscxml -skip qtsensors -skip qtspeech -skip qtsvg -skip qttools -skip qttranslations -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtwinextras -skip qtx11extras -skip qtxmlpatterns -skip qt3d -skip qtcanvas3d -skip qtvirtualkeyboard -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtmacextras -skip qtdoc -skip qtgamepad -skip qtandroidextras -skip qtcharts -skip qtconnectivity -skip qtdatavis3d -skip qtdeclarative -skip qtdoc -skip qtlocation -skip qtpurchasing -skip qtremoteobjects -skip qtscript -skip qtscxml -skip qtsensors -skip qtspeech -skip qtsvg -skip qttools -skip qttranslations -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtwinextras -skip qtx11extras -skip qtxmlpatterns -skip qt3d -skip qtcanvas3d -skip qtvirtualkeyboard -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtmacextras -skip qtdoc -skip qtgamepad -skip qtandroidextras -skip qtcharts -skip qtconnectivity -skip qtdatavis3d -skip qtdeclarative -skip qtdoc -skip qtlocation -skip qtpurchasing -skip qtremoteobjects -skip qtscript -skip qtscxml -skip qtsensors -skip qtspeech -skip qtsvg -skip qttools -skip qttranslations -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtwinextras -skip qtx11extras -skip qtxmlpatterns -skip qt3d -skip qtcanvas3d -skip qtvirtualkeyboard -make libs -make modules -make tools -platform win32-g++
 
REM # 编译Qt
REM nmake
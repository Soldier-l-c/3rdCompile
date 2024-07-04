## 安装前准备
### 1.安装strawberry perl(5.32.1.1)
### 2.安装nasm(2.14.02)，系统环境变量PATH添加C:\Program Files\NASM
### 3.下载openssl源码压缩包
## 编译(管理员打开命令行)
### x86
#### 1.转至C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build，执行vcvars32.bat
#### 2.转至openssl源码目录，执行
```
perl configure VC-WIN32 --prefix="D:\openssl\x86" \\动态库，VC-WIN32编译32位，--prefix执行完所有步骤后生成文件目录
perl configure no-shared VC-WIN32 --prefix="D:\openssl\x86" \\no-shared 静态库库，VC-WIN32编译32位，--prefix执行完所有步骤后生成文件目录

//执行成功后会输出
Using os-specific seed configuration
Creating configdata.pm
Creating makefile
```
#### 3.执行nmake，如果之前编译过其他版本，先执行*nmake clean*
#### 4.执行nmake test
#### 5.执行nmake install

### x64
仅描述与x86不同之处
#### 1.转至C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build，执行vcvars64.bat
#### 2.转至openssl源码目录，执行
```
将 VC-WIN32 改为 VC-WIN64A 其他参数不变
```
其余步骤相同
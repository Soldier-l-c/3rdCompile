set "proto_file_name=%1"

mkdir cpp
mkdir go

"C:\Users\Administrator\Desktop\Develop\grpc_1.28.0\x64\Release\bin\protoc.exe" -I=. --grpc_out=.\cpp --plugin=protoc-gen-grpc="C:\Users\Administrator\Desktop\Develop\grpc\.build\Release\grpc_cpp_plugin.exe" %proto_file_name%
"C:\Users\Administrator\Desktop\Develop\grpc_1.28.0\x64\Release\bin\protoc.exe" -I=. --cpp_out=.\cpp %proto_file_name%
 
"C:\Users\Administrator\Desktop\Develop\grpc_1.28.0\x64\Release\bin\protoc.exe" -I . --go_out=.\go --go-grpc_out=.\go %proto_file_name%

clc
clear
hfile='dll_test.h';
loadlibrary('dll_test.dll', hfile);     %******加载dll及对应的头文件*********
x=0;                                %******虽然对应Fortran里的输出（指针），但它并不返回，然是通过
result=calllib('dll_test', 'add', 3,5,x);%****matlab里的calllib函数返回******
disp('result = '),disp(result)
unloadlibrary dll_test
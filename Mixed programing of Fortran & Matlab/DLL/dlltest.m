clc
clear
hfile='dll_test.h';
loadlibrary('dll_test.dll', hfile);     %******����dll����Ӧ��ͷ�ļ�*********
x=0;                                %******��Ȼ��ӦFortran��������ָ�룩�������������أ�Ȼ��ͨ��
result=calllib('dll_test', 'add', 3,5,x);%****matlab���calllib��������******
disp('result = '),disp(result)
unloadlibrary dll_test
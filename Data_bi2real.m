function [dataConv] = Data_bi2real(data)
%DATA_BI2INT Converte la matrice data da valori a 32 bit in interi con
%segno

s=size(data);

dataConv=zeros(s(1),s(2)/32);

for i=1:s(1)
    for j=1:s(2)/32
        dataConv(i,j)=typecast(uint32(bi2de(data(i,((j-1)*32+1):j*32))),'int32');
        dataConv(i,j)=dataConv(i,j)/1000;
    end
end
end

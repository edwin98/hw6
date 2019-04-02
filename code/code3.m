path='E:\ѧϰ����\����ͼ����\��6����ҵ\';
I=imread('E:\ѧϰ����\����ͼ����\��6����ҵ\lena.bmp');
figure
f=double(I);
F=fft2(f);
F=fftshift(F);
[M,N]=size(F);
a=0.02;
b=0.02;
T=1;
for u=1:M
    for v=1:N
        H(u,v)=(T/(pi*(u*a+v*b)))*sin(pi*(u*a+v*b))*exp(-sqrt(-1)*pi*(u*a+v*b));
        G(u,v)=H(u,v)*F(u,v);
    end
end
G=ifftshift(G);
g=ifft2(G);
g=256.*g./max(max(g));
g=uint8(real(g));

subplot(1,2,1)
imshow(I);
title('ԭʼͼ��');
subplot(1,2,2);
imshow(g);
title('�˶�ģ����');
saveas(gcf,['lena_�˶�ģ��','.jpg'])

I2=imnoise(g,'gaussian',0,0.01);
g1=double(I2);
G1=fft2(g1);
G1=fftshift(G1);
[M,N]=size(G1);
a=0.02;
b=0.02;
T=1;
K=0.03;
for u=1:M
    for v=1:N
        H1(u,v)=(T/(pi*(u*a+v*b)))*sin(pi*(u*a+v*b))*exp(-sqrt(-1)*pi*(u*a+v*b));
        F(u,v)=1/H1(u,v)*(abs(H1(u,v)))^2/((abs(H1(u,v)))^2+K)*G1(u,v);
    end
end
F=ifftshift(F);
I_3=ifft2(F);
I_3=256.*I_3./max(max(I_3));
I_3=uint8(real(I_3));

h=fspecial('motion',50,-45); 
I=imread('lena.bmp');
I1=imfilter(I,h,'circular','conv');
I2=imnoise(I1,'gaussian',0,0.0001);

V=0.0001;
NoisePower=V*numel(I);
[I_4,LAGRA]=deconvreg(I2,h,NoisePower);



figure
subplot(2,2,1)
imshow(I);
title('ԭʼͼ��');
subplot(2,2,2);
imshow(I2);
title('�˶�ģ�������������');
subplot(2,2,3)
imshow(I_3);
title(strcat('ά���˲���','(K=',num2str(K),')'));
subplot(2,2,4)
imshow(I_4);
title('��С�����˲���');

saveas(gcf,['lena_�˶�ģ��������������˲�','.jpg'])

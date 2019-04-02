path='E:\学习资料\数字图像处理\第6次作业\';
I=imread('E:\学习资料\数字图像处理\第6次作业\lena.bmp');
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
title('原始图像');
subplot(1,2,2);
imshow(g);
title('运动模糊后');
saveas(gcf,['lena_运动模糊','.jpg'])

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
title('原始图像');
subplot(2,2,2);
imshow(I2);
title('运动模糊并添加噪声后');
subplot(2,2,3)
imshow(I_3);
title(strcat('维纳滤波后','(K=',num2str(K),')'));
subplot(2,2,4)
imshow(I_4);
title('最小二乘滤波后');

saveas(gcf,['lena_运动模糊、添加噪声并滤波','.jpg'])

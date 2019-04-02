path='E:\学习资料\数字图像处理\第6次作业\';
I=imread('E:\学习资料\数字图像处理\第6次作业\lena.bmp');
d=0.1;
I1=imnoise(I,'salt & pepper',d);

subplot(1,2,1)
imshow(I);
title('原图像')
subplot(1,2,2)
imshow(I1);
title(strcat('添加椒盐噪声后','(密度=',num2str(d),')'));
saveas(gcf,['lena_添加椒盐噪声','.jpg'])
I1=double(I1);
scale1=3;
H=fspecial('average',[scale1,scale1]);%3*3均值滤波
I_2=imfilter(I1,H);

scale2=3;
I_3 = medfilt2(I1,[scale2,scale2]);

sigma=5;%标准差大小??
window=double(uint8(3*sigma)*2+1);
H=fspecial('gaussian',window, sigma);
I_4=imfilter(I1,H,'replicate');

Q1=0.25;
I_5=imfilter(I1.^(Q1+1),fspecial('average',3))./imfilter(I1.^Q1,fspecial('average',3));

Q2=-0.25;
I_6=imfilter(I1.^(Q2+1),fspecial('average',3))./imfilter(I1.^Q2,fspecial('average',3));

I1=uint8(I1);
I_2=uint8(I_2);
I_3=uint8(I_3);
I_4=uint8(I_4);
I_5=uint8(I_5);
I_6=uint8(I_6);

subplot(3,2,1)
imshow(I1);
title('噪声图像')

subplot(3,2,2)
imshow(I_2);
title(strcat('均值滤波后','(',num2str(scale1),'*',num2str(scale1),')'))

subplot(3,2,3)
imshow(I_3);
title(strcat('中值滤波后','(',num2str(scale2),'*',num2str(scale2),')'))

subplot(3,2,4)
imshow(I_4);
title(strcat('高斯滤波后','(sigma=',num2str(sigma),' window=',num2str(window),')'))

subplot(3,2,5)
imshow(I_5);
title(strcat('逆谐波滤波后','(Q=',num2str(Q1),')'))

subplot(3,2,6)
imshow(I_6);
title(strcat('逆谐波滤波后','(Q=',num2str(Q2),')'))


saveas(gcf,['lena_椒盐噪声滤波器处理','.jpg'])



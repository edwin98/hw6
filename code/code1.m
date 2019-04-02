path='E:\学习资料\数字图像处理\第6次作业\';
I=imread('E:\学习资料\数字图像处理\第6次作业\lena.bmp');
m=0.5;
var=0.01;
I1=imnoise(I,'gaussian',m,var);
subplot(1,2,1)
imshow(I);
title('原图像')
subplot(1,2,2)
imshow(I1);
title(strcat('添加高斯噪声后','(均值',num2str(m),'方差',num2str(var),')'));
saveas(gcf,['lena_添加高斯噪声','.jpg'])

scale1=3;
H=fspecial('average',[scale1,scale1]);%3*3均值滤波
I_2=imfilter(I1,H);

scale2=3;
I_3 = medfilt2(I1,[scale2,scale2]);

sigma=5;%标准差大小??
window=double(uint8(3*sigma)*2+1);
H=fspecial('gaussian',window, sigma);
I_4=imfilter(I1,H,'replicate');

subplot(2,2,1)
imshow(I1);
title('噪声图像')

subplot(2,2,2)
imshow(I_2);
title(strcat('均值滤波后','(',num2str(scale1),'*',num2str(scale1),')'))

subplot(2,2,3)
imshow(I_3);
title(strcat('中值滤波后','(',num2str(scale2),'*',num2str(scale2),')'))

subplot(2,2,4)
imshow(I_4);
title(strcat('高斯滤波后','(sigma=',num2str(sigma),' window=',num2str(window),')'))
saveas(gcf,['lena_高斯噪声滤波器处理','.jpg'])




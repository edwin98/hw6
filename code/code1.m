path='E:\ѧϰ����\����ͼ����\��6����ҵ\';
I=imread('E:\ѧϰ����\����ͼ����\��6����ҵ\lena.bmp');
m=0.5;
var=0.01;
I1=imnoise(I,'gaussian',m,var);
subplot(1,2,1)
imshow(I);
title('ԭͼ��')
subplot(1,2,2)
imshow(I1);
title(strcat('��Ӹ�˹������','(��ֵ',num2str(m),'����',num2str(var),')'));
saveas(gcf,['lena_��Ӹ�˹����','.jpg'])

scale1=3;
H=fspecial('average',[scale1,scale1]);%3*3��ֵ�˲�
I_2=imfilter(I1,H);

scale2=3;
I_3 = medfilt2(I1,[scale2,scale2]);

sigma=5;%��׼���С??
window=double(uint8(3*sigma)*2+1);
H=fspecial('gaussian',window, sigma);
I_4=imfilter(I1,H,'replicate');

subplot(2,2,1)
imshow(I1);
title('����ͼ��')

subplot(2,2,2)
imshow(I_2);
title(strcat('��ֵ�˲���','(',num2str(scale1),'*',num2str(scale1),')'))

subplot(2,2,3)
imshow(I_3);
title(strcat('��ֵ�˲���','(',num2str(scale2),'*',num2str(scale2),')'))

subplot(2,2,4)
imshow(I_4);
title(strcat('��˹�˲���','(sigma=',num2str(sigma),' window=',num2str(window),')'))
saveas(gcf,['lena_��˹�����˲�������','.jpg'])




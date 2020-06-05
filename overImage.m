function [output] = overImage(im1,im2,im1_size,im2_size,box)
    %im1:����ͼ�񾭹�wrap���ͼ��
    %im2:��׼ͼ��
    %iml_size:im1�����ص����귶Χ
    %im2_size:im2�����ص����귶Χ
    %box:im1��im2����һ������귶Χ
    y1_begin = im1_size(2,1)-box(2,1)+1;
    x1_begin = im1_size(1,1)-box(1,1)+1;
    w1 = im1_size(1,2)-im1_size(1,1)+1;
    h1 = im1_size(2,2)-im1_size(2,1)+1;
    y2_begin = im2_size(2,1)-box(2,1)+1;
    x2_begin = im2_size(1,1)-box(1,1)+1;
    w2 = im2_size(1,2)-im2_size(1,1)+1;
    h2 = im2_size(2,2)-im2_size(2,1)+1;
    output = zeros(box(2,2)-box(2,1)+1,box(1,2)-box(1,1)+1,3);
    %��im1������im2��
    output(y2_begin:y2_begin+h2-1,x2_begin :x2_begin+w2-1,:) = im2;
    output(y1_begin:y1_begin+h1-1,x1_begin :x1_begin+w1-1,:) = im1;
    %��im2�����귶Χ��ȡ�и�ϳɵ�ͼ��
    output = output(y2_begin:y2_begin+h2-1,x2_begin :x2_begin+w2-1,:);
    output(find(output==0)) = im2(find(output==0));
    output = uint8(output);    
end
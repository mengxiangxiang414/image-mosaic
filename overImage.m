function [output] = overImage(im1,im2,im1_size,im2_size,box)
    %im1:输入图像经过wrap后的图像
    %im2:基准图像
    %iml_size:im1的像素的坐标范围
    %im2_size:im2的像素的坐标范围
    %box:im1和im2合在一块的坐标范围
    y1_begin = im1_size(2,1)-box(2,1)+1;
    x1_begin = im1_size(1,1)-box(1,1)+1;
    w1 = im1_size(1,2)-im1_size(1,1)+1;
    h1 = im1_size(2,2)-im1_size(2,1)+1;
    y2_begin = im2_size(2,1)-box(2,1)+1;
    x2_begin = im2_size(1,1)-box(1,1)+1;
    w2 = im2_size(1,2)-im2_size(1,1)+1;
    h2 = im2_size(2,2)-im2_size(2,1)+1;
    output = zeros(box(2,2)-box(2,1)+1,box(1,2)-box(1,1)+1,3);
    %用im1覆盖在im2上
    output(y2_begin:y2_begin+h2-1,x2_begin :x2_begin+w2-1,:) = im2;
    output(y1_begin:y1_begin+h1-1,x1_begin :x1_begin+w1-1,:) = im1;
    %用im2的坐标范围，取切割合成的图。
    output = output(y2_begin:y2_begin+h2-1,x2_begin :x2_begin+w2-1,:);
    output(find(output==0)) = im2(find(output==0));
    output = uint8(output);    
end
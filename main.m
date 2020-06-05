addpath("D:\计算机视觉表征与识别\assignment3\assignment3");
run('D:\计算机视觉表征与识别\VLFeat\vlfeat-0.9.21\toolbox\vl_setup');

im1 = imread("uttower1.jpg");
im2 = imread("uttower2.jpg");
%im1 = imread("painting_4.jpg");
%im2 = imread("painting_5.jpg");

imshow(im1);
p1 = ginput();
axis on;

figure(2),
imshow(im2);
p2 = ginput();
axis on;

%通过sift算法，获取匹配点
[p1,p2] = siftMatches(im1,im2);
%通过RANSAC获得H
[H,inliers] = ransacPoints(p1,p2);
p1 = p1(inliers,:);
p2 = p2(inliers,:);
%构建Ax=b,其中x是由“透视变换矩阵H”所展开成的一维列向量。解该方程组。
A = [];
for i=1:size(p1,1)
    A_row_x = [p1(i,1) p1(i,2) 1 0 0 0 -p2(i,1)*p1(i,1) -p2(i,1)*p1(i,2)];
    A_row_y = [0 0 0 p1(i,1) p1(i,2) 1 -p2(i,2)*p1(i,1) -p2(i,2)*p1(i,2)];
    A = [A;A_row_x;A_row_y];
end

b=reshape(p2',2*size(p2,1),[]);
x = A\b;
H = reshape([x;1],3,3)';
%将im1中的标记点，经过H转换，在im2中展示处理。
p11 =[p1 ones(size(p1,1),1)];
p3 = H*p11';
p3 = p3./p3(3,:);
p3 = p3(1:2,:)';

figure(3),imshow(im2);
hold on;
plot(p3(:,1),p3(:,2),'-o');

%扭曲图片，
im_wrap = imageWrap(im1,H);
figure(4),imshow(im_wrap);
wrap_size = size(im_wrap);

%拼接图片
[h,w,c] = size(im1);
pt4 = [
        1 1 1;
        w 1 1;
        w h 1;
        1 h 1
        ];
pt4_after = (H*pt4')';%四个角上的点经过H变换后的点
pt4_after = pt4_after./pt4_after(:,3);

mins_1 = int16(min(pt4_after));
maxs_1 = mins_1+int16([wrap_size(2)-1 wrap_size(1)-1 1]);
%经过H变换后的img1的box
img1_size = [mins_1(1) maxs_1(1)
             mins_1(2) maxs_1(2)];

[h_base,w_base,c_base] = size(im2);
    pt4_base = [
        1 1 1;
        w_base 1 1;
        w_base h_base 1;
        1 h_base 1
        ];
%img2的box
img2_size = [1 w_base;
             1 h_base];
eight_points = [pt4_after;pt4_base];
%下面求出变换后的图的box四角的坐标
maxs = int16(max(eight_points));
mins = int16(min(eight_points));
%最终的拼接后的图片的box
box = [mins(1) maxs(1);
       mins(2) maxs(2)];

img_merge = mergeImage(im_wrap,im2,img1_size,img2_size,box);

figure(5),imshow(img_merge);

img_rect = overImage(im_wrap,im2,img1_size,img2_size,box);





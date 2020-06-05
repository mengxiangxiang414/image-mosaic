function [output,inliers] = ransacPoints(p1,p2)
    %output:变换函数
    %inliers：正确的配对点的序号
    %p1、p2输入的两幅图
    m = size(p1,1);
    k=100;%随机采样次数
    delta = 9;%在RANSAC中，如果H变换后的点和p2的欧氏距离大于该阈值，则表明该“点对”是outlier。
    scores = 0;
    output = zeros(3,3);
    inliers = [];
    for j=1:k
        points4 = randperm(m,4);
        p1_4 = p1(points4,:);
        p2_4 = p2(points4,:);
        A = [];
        for i=1:size(p1_4,1)
            A_row_x = [p1_4(i,1) p1_4(i,2) 1 0 0 0 -p2_4(i,1)*p1_4(i,1) -p2_4(i,1)*p1_4(i,2)];
            A_row_y = [0 0 0 p1_4(i,1) p1_4(i,2) 1 -p2_4(i,2)*p1_4(i,1) -p2_4(i,2)*p1_4(i,2)];
            A = [A;A_row_x;A_row_y];
        end
        %计算变换矩阵H
        b=reshape(p2_4',2*size(p2_4,1),[]);
        x = A\b;
        H = reshape([x;1],3,3)';
        %将p1的所有点，用H变换，得到新的点p3
        p11 =[p1 ones(size(p1,1),1)];
        p3 = H*p11';
        p3 = p3./p3(3,:);
        p3 = p3(1:2,:)';
        
        dis = sum((p2-p3).^2,2);
        inliers_this = find(dis<delta);
        inlier_num = size(dis(inliers_this),1);
        
        if inlier_num>scores
           scores = inlier_num;
           output = H;
           inliers = inliers_this;
        end
    end
end
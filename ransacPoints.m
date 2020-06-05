function [output,inliers] = ransacPoints(p1,p2)
    %output:�任����
    %inliers����ȷ����Ե�����
    %p1��p2���������ͼ
    m = size(p1,1);
    k=100;%�����������
    delta = 9;%��RANSAC�У����H�任��ĵ��p2��ŷ�Ͼ�����ڸ���ֵ��������á���ԡ���outlier��
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
        %����任����H
        b=reshape(p2_4',2*size(p2_4,1),[]);
        x = A\b;
        H = reshape([x;1],3,3)';
        %��p1�����е㣬��H�任���õ��µĵ�p3
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
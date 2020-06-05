%输入原图input，以及转换矩阵H，输出wrap后的图
function [output] = imageWrap(input,H)
    [h,w,c] = size(input);
    pt4 = [
        0 0 1;
        w 0 1;
        w h 1;
        0 h 1
        ];
    pt4_after = (H*pt4')';%四个角上的点经过H变换后的点
    pt4_after = pt4_after./pt4_after(:,3);
    
    %下面求出变换后的图的box四角的坐标
    maxs = int16(max(pt4_after));
    mins = int16(min(pt4_after));
    
    %对每隔像素逆变换，并进行插值
    IH = inv(H);
    X = zeros(maxs(2)-mins(2)+1,maxs(1)-mins(1)+1);
    Y = zeros(maxs(2)-mins(2)+1,maxs(1)-mins(1)+1);
    for i=mins(1):maxs(1)
        for j=mins(2): maxs(2)
            pt = double([i;j;1]);
            pt_inv = IH*pt;
            pt_inv = pt_inv./pt_inv(3,:);
            X(j-mins(2)+1,i-mins(1)+1) = pt_inv(1);
            Y(j-mins(2)+1,i-mins(1)+1) = pt_inv(2);
        end
    end
    %对r,g,b三通道分别进行插值，然后合并成彩色图像
    r = interp2(double(input(:,:,1)), X, Y );
    g = interp2(double(input(:,:,2)), X, Y );
    b = interp2(double(input(:,:,3)), X, Y );
    
    output = zeros(maxs(2)-mins(2)+1,maxs(1)-mins(1)+1,3);
    output(:,:,1) = r;
    output(:,:,2) = g;
    output(:,:,3) = b;
    output(isnan(output)) = 0;
    output = uint8(output);
end

%����ԭͼinput���Լ�ת������H�����wrap���ͼ
function [output] = imageWrap(input,H)
    [h,w,c] = size(input);
    pt4 = [
        0 0 1;
        w 0 1;
        w h 1;
        0 h 1
        ];
    pt4_after = (H*pt4')';%�ĸ����ϵĵ㾭��H�任��ĵ�
    pt4_after = pt4_after./pt4_after(:,3);
    
    %��������任���ͼ��box�Ľǵ�����
    maxs = int16(max(pt4_after));
    mins = int16(min(pt4_after));
    
    %��ÿ��������任�������в�ֵ
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
    %��r,g,b��ͨ���ֱ���в�ֵ��Ȼ��ϲ��ɲ�ɫͼ��
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

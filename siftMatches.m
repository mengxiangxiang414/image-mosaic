function [p1,p2] = siftMatches(im1,im2)
    
    %ͨ��vl_sift���ͼ�������������ӣ�����һ��ʹ��vl_ubcmatch�������������ԡ�
    img_grey_1 = single(rgb2gray(im1));
    img_grey_2 = single(rgb2gray(im2));
    [fa, da] = vl_sift(img_grey_1);
    [fb, db] = vl_sift(img_grey_2);
    [matches, scores] = vl_ubcmatch(da, db) ;

    xa = fa(1,matches(1,:)) ;
    ya = fa(2,matches(1,:)) ;
    xb = fb(1,matches(2,:)) ;
    yb = fb(2,matches(2,:)) ;

    p1 = [xa;ya]';
    p2 = [xb;yb]';
end




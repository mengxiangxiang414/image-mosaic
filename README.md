# image-mosaic
 图像拼接image mosaic
 
 调试程序的入口：
 main.m		调试程序入口
 imageWrap.m	图像扭曲
 mergeImage.m	图像拼接
 overImage.m	图像贴图
 siftMatches.m	通过vl_sift库，直接获取配对点
 ransacPoints.m	先对配对点进行RANSAC，过滤掉outliers

 注：需要自行安装VLFeat。网站为https://www.vlfeat.org/install-matlab.html

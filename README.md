# image-mosaic
 图像拼接image mosaic<br>
 
## 代码功能介绍
调试程序的入口<br>
>main.m		调试程序入口<br>
>imageWrap.m	图像扭曲<br>
>mergeImage.m	图像拼接<br>
>overImage.m	图像贴图<br>
>siftMatches.m	通过vl_sift库，直接获取配对点<br>
>ransacPoints.m	先对配对点进行RANSAC，过滤掉outliers<br>

>注：需要自行安装`VLFeat`。网站为https://www.vlfeat.org/install-matlab.html
## 开发环境
`matlab`<br>
`VLFeat库`
## 执行效果
#### 两张原图
<img src="https://github.com/mengxiangxiang414/image-mosaic/blob/master/uttower1.jpg" width="300">
<img src="https://github.com/mengxiangxiang414/image-mosaic/blob/master/uttower2.jpg" width="300"><br>

#### 扭曲（wrap）后的效果图
<img src="https://github.com/mengxiangxiang414/image-mosaic/blob/master/result_imgs/wrap.png" width="400">

#### 拼接（mosaic）后的效果图
<img src="https://github.com/mengxiangxiang414/image-mosaic/blob/master/result_imgs/ransac.png" width="500">



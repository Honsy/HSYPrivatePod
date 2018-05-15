//
//  UIImage+HSY.h
//  AFNetworking
//
//  Created by HSY on 2018/5/7.
//

#import <UIKit/UIKit.h>

@interface UIImage (HSY)

/**
 创建纯色图片
 
 @param color 图片颜色
 @param size  大小
 
 @return UIImage对象
 */
+ (UIImage *)createImageFromColor:(UIColor *)color imageSize:(CGSize)size;


/**
 修改图片尺寸
 
 @param targetSize 修改后的尺寸大小
 
 @return UIImage对象
 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;


/**
 截屏
 
 @return UIImage对象
 */
- (UIImage *)screenshot;


/**
 修改图片颜色
 
 @param color 修改后的图片颜色
 
 @return UIImage对象
 */
- (UIImage *)imageWithColor:(UIColor *)color;

/**
 封装方法
 
 @param name  图片名
 @param color 颜色
 
 @return UIImage对象
 */
+(UIImage *)imageWithName:(NSString *)name Color:(UIColor *)color;

/**
 *  传入图片,获取中间部分,需要的大小,压缩比例
 *
 *      @prama image 需要压缩的图片
 *      @prama size  压缩后图片的大小
 *      @prama scale 压缩的比例 0.0 - 1.0
 *
 *      @return 返回新的图片
 */
+ (UIImage *)needCenterImage:(UIImage *)image size:(CGSize )size scale:(CGFloat )scale;


/**
 计算图片高度
 
 @param image 图片对象
 @param width 内容宽度
 @return 高度
 */
+ (CGFloat)heightForImage:(UIImage *)image Width:(NSInteger)width;

/**
 调整图片大小
 
 @param asize size
 @return uiimage
 */
- (UIImage *)thumbnailWithSize:(CGSize)asize;


/**
 根据图片获取图片的主色调
 
 @param image  image对象
 @return UIColor
 */
+(UIColor*)mostColor:(UIImage*)image;

/**
 *  根据图片url获取图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL;

/**
 加载GIF
 
 @param name git名
 @return image对象
 */
+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;

/**
 修正相机拍照过后的图片
 
 @param aImage 图片对象
 @return 图片对象
 */
- (UIImage *)fixOrientation:(UIImage *)aImage;
/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

@end

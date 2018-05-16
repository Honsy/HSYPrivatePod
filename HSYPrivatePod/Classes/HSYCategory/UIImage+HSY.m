//
//  UIImage+HSY.m
//  AFNetworking
//
//  Created by HSY on 2018/5/7.
//

#import "UIImage+HSY.h"

@implementation UIImage (HSY)
+ (UIImage *)createImageFromColor:(UIColor *)color imageSize:(CGSize)size {
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 修改图片大小
- (UIImage *)imageByScalingToSize:(CGSize)targetSize
{
    
    UIImage *sourceImage = self;
    
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    
    CGFloat scaledWidth = targetWidth;
    
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) ==NO) {
        
        CGFloat widthFactor = targetWidth / width;
        
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            
            scaleFactor = widthFactor;
        
        else
            
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            
            
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        } else if (widthFactor > heightFactor) {
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            
        }
        
    }
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    
    thumbnailRect.origin = thumbnailPoint;
    
    thumbnailRect.size.width  = scaledWidth;
    
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    if(newImage == nil)
        
        NSLog(@"could not scale image");
    
    return newImage ;
    
}

//截屏
- (UIImage *)screenshot {
    
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            
            CGContextConcatCTM(context, [window transform]);
            
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

//改变图片颜色
- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage *)imageWithName:(NSString *)name Color:(UIColor *)color{
    return [[UIImage imageNamed:name] imageWithColor:color];
}

+ (UIImage *)needCenterImage:(UIImage *)image size:(CGSize )size scale:(CGFloat )scale
{
    /* 想切中间部分,待解决 */
#warning area of center image
    UIImage *newImage = nil;
    //创建画板
    UIGraphicsBeginImageContext(size);
    
    //写入图片,在中间
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    //得到新的图片
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //释放画板
    UIGraphicsEndImageContext();
    
    //比例压缩
    newImage = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, scale)];
    
    return newImage;
}

+ (CGFloat)heightForImage:(UIImage *)image Width:(NSInteger)width

{
    return image.size.height;
    
}

- (UIImage *)thumbnailWithSize:(CGSize)asize
{
    UIImage *newimage = nil;
    UIGraphicsBeginImageContext(asize);
    [self drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimage;
}

//根据图片获取图片的主色调
+(UIColor*)mostColor:(UIImage*)image{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(image.size.width/2, image.size.height/2);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) return nil;
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha>0) {//去除透明
                if (red==255&&green==255&&blue==255) {//去除白色
                }else{
                    NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
                    [cls addObject:clr];
                }
                
            }
        }
    }
    CGContextRelease(context);
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

/**
 *  根据图片url获取图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef =     CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

//加载GIF
+ (UIImage *)sd_animatedGIFNamed:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return [UIImage sd_animatedGIFWithData:data];
        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage sd_animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
    else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage sd_animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
}

+ (UIImage *)sd_animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            duration += [self sd_frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
}

+ (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}

//相机获取到的图片自动扭转90度
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x= rect.origin.x*scale,y=rect.origin.y*scale,w=rect.size.width*scale,h=rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}

#pragma mark 绘制图片
//成功
+ (void)drawCheckmark
{
    // Checkmark Shape Drawing
    UIBezierPath *checkmarkShapePath = [[UIBezierPath alloc] init];
    [checkmarkShapePath moveToPoint:CGPointMake(73.25, 14.05)];
    [checkmarkShapePath addCurveToPoint:CGPointMake(64.51, 13.86) controlPoint1: CGPointMake(70.98, 11.44) controlPoint2: CGPointMake(66.78, 11.26)];
    [checkmarkShapePath addLineToPoint:CGPointMake(27.46, 52)];
    [checkmarkShapePath addLineToPoint:CGPointMake(15.75, 39.54)];
    [checkmarkShapePath addCurveToPoint:CGPointMake(6.84, 39.54) controlPoint1: CGPointMake(13.48, 36.93) controlPoint2: CGPointMake(9.28, 36.93)];
    [checkmarkShapePath addCurveToPoint:CGPointMake(6.84, 49.02) controlPoint1: CGPointMake(4.39, 42.14) controlPoint2: CGPointMake(4.39, 46.42)];
    [checkmarkShapePath addLineToPoint:CGPointMake(22.91, 66.14)];
    [checkmarkShapePath addCurveToPoint:CGPointMake(27.28, 68) controlPoint1: CGPointMake(24.14, 67.44) controlPoint2: CGPointMake(25.71, 68)];
    [checkmarkShapePath addCurveToPoint:CGPointMake(31.65, 66.14) controlPoint1: CGPointMake(28.86, 68) controlPoint2: CGPointMake(30.43, 67.26)];
    [checkmarkShapePath addLineToPoint:CGPointMake(73.08, 23.35)];
    [checkmarkShapePath addCurveToPoint:CGPointMake(73.25, 14.05) controlPoint1: CGPointMake(75.52, 20.75) controlPoint2: CGPointMake(75.7, 16.65)];
    [checkmarkShapePath closePath];
    checkmarkShapePath.miterLimit = 4;
    
    [[UIColor whiteColor] setFill];
    [checkmarkShapePath fill];
}

//警告
+ (void)drawWarning
{
    // Color Declarations
    UIColor *greyColor = [UIColor colorWithRed:0.236 green:0.236 blue:0.236 alpha:1.000];
    
    // Warning Group
    // Warning Circle Drawing
    UIBezierPath *warningCirclePath = [[UIBezierPath alloc] init];
    [warningCirclePath moveToPoint:CGPointMake(40.94, 63.39)];
    [warningCirclePath addCurveToPoint:CGPointMake(36.03, 65.55) controlPoint1: CGPointMake(39.06, 63.39) controlPoint2: CGPointMake(37.36, 64.18)];
    [warningCirclePath addCurveToPoint:CGPointMake(34.14, 70.45) controlPoint1: CGPointMake(34.9, 66.92) controlPoint2: CGPointMake(34.14, 68.49)];
    [warningCirclePath addCurveToPoint:CGPointMake(36.22, 75.54) controlPoint1: CGPointMake(34.14, 72.41) controlPoint2: CGPointMake(34.9, 74.17)];
    [warningCirclePath addCurveToPoint:CGPointMake(40.94, 77.5) controlPoint1: CGPointMake(37.54, 76.91) controlPoint2: CGPointMake(39.06, 77.5)];
    [warningCirclePath addCurveToPoint:CGPointMake(45.86, 75.35) controlPoint1: CGPointMake(42.83, 77.5) controlPoint2: CGPointMake(44.53, 76.72)];
    [warningCirclePath addCurveToPoint:CGPointMake(47.93, 70.45) controlPoint1: CGPointMake(47.18, 74.17) controlPoint2: CGPointMake(47.93, 72.41)];
    [warningCirclePath addCurveToPoint:CGPointMake(45.86, 65.35) controlPoint1: CGPointMake(47.93, 68.49) controlPoint2: CGPointMake(47.18, 66.72)];
    [warningCirclePath addCurveToPoint:CGPointMake(40.94, 63.39) controlPoint1: CGPointMake(44.53, 64.18) controlPoint2: CGPointMake(42.83, 63.39)];
    [warningCirclePath closePath];
    warningCirclePath.miterLimit = 4;
    
    [greyColor setFill];
    [warningCirclePath fill];
    
    
    //// Warning Shape Drawing
    UIBezierPath *warningShapePath = [[UIBezierPath alloc] init];
    [warningShapePath moveToPoint:CGPointMake(46.23, 4.26)];
    [warningShapePath addCurveToPoint:CGPointMake(40.94, 2.5) controlPoint1: CGPointMake(44.91, 3.09) controlPoint2: CGPointMake(43.02, 2.5)];
    [warningShapePath addCurveToPoint:CGPointMake(34.71, 4.26) controlPoint1: CGPointMake(38.68, 2.5) controlPoint2: CGPointMake(36.03, 3.09)];
    [warningShapePath addCurveToPoint:CGPointMake(31.5, 8.77) controlPoint1: CGPointMake(33.01, 5.44) controlPoint2: CGPointMake(31.5, 7.01)];
    [warningShapePath addLineToPoint:CGPointMake(31.5, 19.36)];
    [warningShapePath addLineToPoint:CGPointMake(34.71, 54.44)];
    [warningShapePath addCurveToPoint:CGPointMake(40.38, 58.16) controlPoint1: CGPointMake(34.9, 56.2) controlPoint2: CGPointMake(36.41, 58.16)];
    [warningShapePath addCurveToPoint:CGPointMake(45.67, 54.44) controlPoint1: CGPointMake(44.34, 58.16) controlPoint2: CGPointMake(45.67, 56.01)];
    [warningShapePath addLineToPoint:CGPointMake(48.5, 19.36)];
    [warningShapePath addLineToPoint:CGPointMake(48.5, 8.77)];
    [warningShapePath addCurveToPoint:CGPointMake(46.23, 4.26) controlPoint1: CGPointMake(48.5, 7.01) controlPoint2: CGPointMake(47.74, 5.44)];
    [warningShapePath closePath];
    warningShapePath.miterLimit = 4;
    
    [greyColor setFill];
    [warningShapePath fill];
}
//提示
+ (void)drawInfo
{
    // Color Declarations
    UIColor *color0 = [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1.000];
    
    // Info Shape Drawing
    UIBezierPath *infoShapePath = [[UIBezierPath alloc] init];
    [infoShapePath moveToPoint:CGPointMake(45.66, 15.96)];
    [infoShapePath addCurveToPoint:CGPointMake(45.66, 5.22) controlPoint1: CGPointMake(48.78, 12.99) controlPoint2: CGPointMake(48.78, 8.19)];
    [infoShapePath addCurveToPoint:CGPointMake(34.34, 5.22) controlPoint1: CGPointMake(42.53, 2.26) controlPoint2: CGPointMake(37.47, 2.26)];
    [infoShapePath addCurveToPoint:CGPointMake(34.34, 15.96) controlPoint1: CGPointMake(31.22, 8.19) controlPoint2: CGPointMake(31.22, 12.99)];
    [infoShapePath addCurveToPoint:CGPointMake(45.66, 15.96) controlPoint1: CGPointMake(37.47, 18.92) controlPoint2: CGPointMake(42.53, 18.92)];
    [infoShapePath closePath];
    
    [infoShapePath moveToPoint:CGPointMake(48, 69.41)];
    [infoShapePath addCurveToPoint:CGPointMake(40, 77) controlPoint1: CGPointMake(48, 73.58) controlPoint2: CGPointMake(44.4, 77)];
    [infoShapePath addLineToPoint:CGPointMake(40, 77)];
    [infoShapePath addCurveToPoint:CGPointMake(32, 69.41) controlPoint1: CGPointMake(35.6, 77) controlPoint2: CGPointMake(32, 73.58)];
    [infoShapePath addLineToPoint:CGPointMake(32, 35.26)];
    [infoShapePath addCurveToPoint:CGPointMake(40, 27.67) controlPoint1: CGPointMake(32, 31.08) controlPoint2: CGPointMake(35.6, 27.67)];
    [infoShapePath addLineToPoint:CGPointMake(40, 27.67)];
    [infoShapePath addCurveToPoint:CGPointMake(48, 35.26) controlPoint1: CGPointMake(44.4, 27.67) controlPoint2: CGPointMake(48, 31.08)];
    [infoShapePath addLineToPoint:CGPointMake(48, 69.41)];
    [infoShapePath closePath];
    
    [color0 setFill];
    [infoShapePath fill];
}


@end


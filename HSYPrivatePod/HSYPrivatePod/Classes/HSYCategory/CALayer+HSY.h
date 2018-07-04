//
//  CALayer+HSY.h
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/14.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (HSY)

/**
 切圆角
 
 @param radius 圆角大小
 */
-(void)clipToBoundsWithRadius:(NSInteger )radius;

/**
 添加边框线
 
 @param color 颜色
 @param borderWidth 宽度
 */
-(void)addBorderLayerWithColor:(UIColor *)color BorderWidth:(NSInteger)borderWidth;

/**
 加阴影
 
 @param shadowColor 阴影颜色
 @param shadowOffset shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
 @param ShadowOpacity 阴影透明度，默认0G
 @param shadowRadius 阴影半径，默认3
 */
-(void)addShadow:(UIColor *)shadowColor ShadowOffset:(CGSize)shadowOffset ShadowOpacity:(float)ShadowOpacity ShadowRadius:(CGFloat)shadowRadius;


/**
 添加渐变色
 
 @param colors 渐变色数组<CGColor>
 */
-(void)addGradientLayer:(NSArray *)colors Frame:(CGRect)frame;

@end

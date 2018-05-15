//
//  CALayer+HSY.m
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/14.
//

#import "CALayer+HSY.h"

@implementation CALayer (HSY)


-(void)clipToBoundsWithRadius:(NSInteger )radius{
    self.masksToBounds = YES;
    self.cornerRadius = radius;
    self.shouldRasterize = YES;
    self.rasterizationScale = [UIScreen mainScreen].scale;
}

//添加边框线
-(void)addBorderLayerWithColor:(UIColor *)color BorderWidth:(NSInteger)borderWidth{
    self.borderColor = color.CGColor;
    
    self.borderWidth = borderWidth;
}

-(void)addShadow:(UIColor *)shadowColor ShadowOffset:(CGSize)shadowOffset ShadowOpacity:(float)shadowOpacity ShadowRadius:(CGFloat)shadowRadius{
    //防止离屏渲染
//    self.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    self.shadowColor =shadowColor.CGColor;
    self.shadowOffset = shadowOffset;
    self.shadowOpacity = shadowOpacity;
    self.shadowRadius = shadowRadius;
}

-(void)addGradientLayer:(NSArray *)colors Frame:(CGRect)frame{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.locations = @[@0.3, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = frame;
    [self addSublayer:gradientLayer];
    
}

@end

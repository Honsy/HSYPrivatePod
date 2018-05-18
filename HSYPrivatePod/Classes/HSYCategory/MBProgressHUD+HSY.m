//
//  MBProgressHUD+HSY.m
//  Pods
//
//  Created by 烽行意志 on 2018/5/16.
//

#import "MBProgressHUD+HSY.h"
#import "UIImage+HSY.h"
#import "HSYBundle.h"

@interface MBProgressHUD (HSY)

+ (MBProgressHUD *)showCustomAnimate:(NSString *)text imageName:(NSString *)imageName imageCounts:(NSInteger)imageCounts view:(UIView *)view;

@end


@implementation MBProgressHUD (HSY)

+(MBProgressHUD *)hud{
    return [[self alloc]init];
}

+(NSBundle *)private_bundle{
    NSBundle *bundle = [NSBundle bundleForClass:[HSYBundle class]];
    return bundle;
}

#pragma mark APP主要使用gif加载提示 无字
-(MBProgressHUD *)showHUDWithApp:(UIView *)view{
    
    MBProgressHUD * hud = [MBProgressHUD showCustomAnimate:@"" imageName:@"" imageCounts:66 view:view];
    
    return hud;
}
-(MBProgressHUD *)showHUDWithApp:(UIView *)view message:(NSString *)message{
    MBProgressHUD * hud = [MBProgressHUD showCustomAnimate:message imageName:@"" imageCounts:66 view:view];
    return hud;
}
#pragma mark 不带文字的加载框
-(MBProgressHUD *)showHUDInView:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;

    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    return hud;
}
#pragma mark 带文字的加载框
-(MBProgressHUD *)showHUDInView:(UIView *)view message:(NSString *)message{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.label.text = @"加载中.....";
    
    return hud;
}
#pragma mark 文字提示框
-(MBProgressHUD *)showInView:(UIView *)view message:(NSString *)message{
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;

    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    hud.mode = MBProgressHUDModeText;

    hud.label.text = message;

    [hud hideAnimated:YES afterDelay:3.f];
    
    return hud;
}
#pragma mark 带图片的提示框
//成功提示
-(MBProgressHUD *)showSuccessIconInView:(UIView *)view message:(NSString *)message{

    
    UIImage *image = [UIImage imageNamed:@"hud_success" inBundle:[MBProgressHUD private_bundle] compatibleWithTraitCollection:nil];

    return [self showHUDWithIconInView:view message:message icon:image];
    
}
//失败提示
-(MBProgressHUD *)showErrorIconInView:(UIView *)view  message:(NSString *)message{
    // Set an image view with a checkmark.
    
    UIImage *image = [UIImage imageNamed:@"hud_error" inBundle:[MBProgressHUD private_bundle] compatibleWithTraitCollection:nil];
    
    return [self showHUDWithIconInView:view message:message icon:image];
}
//提示
-(MBProgressHUD *)showInfoIconInView:(UIView *)view  message:(NSString *)message{
    // Set an image view with a checkmark.
    UIImage *image = [UIImage imageNamed:@"hud_warning" inBundle:[MBProgressHUD private_bundle] compatibleWithTraitCollection:nil];
    
    return [self showHUDWithIconInView:view message:message icon:image];
}
#pragma mark 自定义图片的提示框
-(MBProgressHUD *)showHUDWithIconInView:(UIView *)view message:(NSString *)message icon:(UIImage *)icon{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.customView = [[UIImageView alloc] initWithImage:icon];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.label.text = message;
    
    [hud hideAnimated:YES afterDelay:3.f];
    
    return hud;
}

//自定义gif动画加载
+ (MBProgressHUD *)showCustomAnimate:(NSString *)text imageName:(NSString *)imageName imageCounts:(NSInteger)imageCounts view:(UIView *)view{

    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];

    HUD.color = [UIColor whiteColor];
    HUD.labelText = text;
    HUD.square = YES;
    HUD.backgroundView.backgroundColor =  [UIColor whiteColor];
    HUD.labelColor = [UIColor grayColor];
    HUD.labelFont = [UIFont systemFontOfSize:8];
    HUD.mode = MBProgressHUDModeCustomView;
    
    UIImage *image = [UIImage imageWithContentsOfFile:[[MBProgressHUD private_bundle] pathForResource:[NSString stringWithFormat:@"%@1",imageName] ofType:@"jpg"]];
    UIImageView *animateGifView = [[UIImageView alloc]initWithImage:image];
    animateGifView.contentMode = UIViewContentModeScaleAspectFit;
    NSMutableArray *gifArray = [NSMutableArray array];
    for (int i = 1; i <= imageCounts; i ++) {
        UIImage *images = [UIImage imageWithContentsOfFile:[[MBProgressHUD private_bundle] pathForResource:[NSString stringWithFormat:@"%@%d", imageName, i] ofType:@"jpg"]];

        [gifArray addObject:images];
    }
    
    [animateGifView setAnimationImages:gifArray];
    [animateGifView setAnimationDuration:2];
    [animateGifView setAnimationRepeatCount:0];
    [animateGifView startAnimating];
    
    HUD.customView = animateGifView;
    
    return HUD;
    
}
@end

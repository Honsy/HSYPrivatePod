//
//  MBProgressHUD+HSY.h
//  Pods
//
//  Created by 烽行意志 on 2018/5/16.
//

#import <MBProgressHUD/MBProgressHUD.h>


typedef void (^HUDBlock)(MBProgressHUD * hud);

@interface MBProgressHUD (HSY)

+(MBProgressHUD *)hud;

#pragma mark APP主要使用gif加载提示 无字 有字
-(MBProgressHUD *)showHUDWithApp:(UIView *)view;
-(MBProgressHUD *)showHUDWithApp:(UIView *)view message:(NSString *)message;

#pragma mark 不带文字的加载框
-(MBProgressHUD *)showHUDInView:(UIView *)view;
#pragma mark 带文字的加载框
-(MBProgressHUD *)showHUDInView:(UIView *)view message:(NSString *)message  completeBlock:(HUDBlock)completeBlock;
#pragma mark 文字提示框
-(MBProgressHUD *)showInView:(UIView *)view message:(NSString *)message;
#pragma mark 带图片的提示框
-(MBProgressHUD *)showSuccessIconInView:(UIView *)view message:(NSString *)message;
-(MBProgressHUD *)showErrorIconInView:(UIView *)view  message:(NSString *)message;
-(MBProgressHUD *)showInfoIconInView:(UIView *)view  message:(NSString *)message;
#pragma mark 自定义图片的提示框
-(MBProgressHUD *)showHUDWithIconInView:(UIView *)view message:(NSString *)message icon:(UIImage *)icon;
@end

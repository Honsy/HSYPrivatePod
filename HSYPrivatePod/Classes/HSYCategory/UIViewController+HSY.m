//
//  UIViewController+HSY.m
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/29.
//

#import "UIViewController+HSY.h"

@implementation UIViewController (HSY)

#pragma mark 弹框
-(void)presentAlertController:(NSString *)title Message:(NSString *)message CancelTitle:(NSString *)cancelTitle CancelHandler:(void (^)(UIAlertAction *action))cancelHandler OtherTitle:(NSString *)otherTitle OtherHandler:(void (^)(UIAlertAction *action))otherHandler{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:cancelHandler]];
    [alertVC addAction:[UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:otherHandler]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}
@end

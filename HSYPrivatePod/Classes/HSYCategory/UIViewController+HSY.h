//
//  UIViewController+HSY.h
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/29.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HSY)

#pragma mark 弹框
-(void)presentAlertController:(NSString *)title Message:(NSString *)message CancelTitle:(NSString *)cancelTitle CancelHandler:(void (^)(UIAlertAction *action))cancelHandler OtherTitle:(NSString *)otherTitle OtherHandler:(void (^)(UIAlertAction *action))otherHandler;
@end

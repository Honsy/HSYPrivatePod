//
//  UIViewController+HSY.h
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/29.
//

#import <UIKit/UIKit.h>
#import "TZImagePickerController.h"

//图片选择器 选择图片回调
typedef void (^ImageSelectBlock)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto);

@interface UIViewController (HSY)<TZImagePickerControllerDelegate>

#pragma mark 弹框
-(void)presentAlertController:(NSString *)title Message:(NSString *)message CancelTitle:(NSString *)cancelTitle CancelHandler:(void (^)(UIAlertAction *action))cancelHandler OtherTitle:(NSString *)otherTitle OtherHandler:(void (^)(UIAlertAction *action))otherHandler;

/**
 跳转相册
 
 @param imageSelectBlock 选择图片回调
 @param allowCrop 是否准许切图
 @param cropRect 裁剪大小
 */
- (void)pushImagePickerController:(ImageSelectBlock)imageSelectBlock allowCrop:(BOOL)allowCrop cropRect:(CGRect)cropRect;
@end

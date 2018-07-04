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

// 跳转相册
- (void)pushImagePickerController:(ImageSelectBlock)imageSelectBlock allowCrop:(BOOL)allowCrop cropRect:(CGRect)cropRect{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    //    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    //    if (self.maxCountTF.text.integerValue > 1) {
    //        // 1.设置目前已经选中的图片数组
    //        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    //    }
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
//    [imagePickerVc.navigationBar py_addToThemeColorPool:@"barTintColor"];
    
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = YES;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop =allowCrop;
    //    imagePickerVc.cropRect = CGRectMake(0, 0, 200, 200);
    imagePickerVc.needCircleCrop = YES;
    imagePickerVc.circleCropRadius = 120;
    
    if (!CGRectEqualToRect(cropRect, CGRectZero)) {
        imagePickerVc.cropRect = cropRect;
    }
    //    imagePickerVc.circleCropRadius = 100;
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    
    [imagePickerVc setDidFinishPickingPhotosHandle:imageSelectBlock];
    
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

@end

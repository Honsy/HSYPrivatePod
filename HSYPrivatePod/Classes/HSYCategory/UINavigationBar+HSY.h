//
//  UINavigationBar+HSY.h
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/15.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (HSY)

/**
 设置导航条背景透明 iOS11 产生问题 单独封装以防以后
 */
-(void)hsy_setNavigationBarBackgroundClear;

/**
 取消导航条背景透明 iOS11 产生问题 单独封装以防以后
 */
-(void)hsy_cancelNavigationBarBackgroundClear;

@end

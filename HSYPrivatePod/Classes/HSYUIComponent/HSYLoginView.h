//
//  HSYLoginView.h
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/25.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

typedef void(^LoginClickBlock)(void);

@interface HSYLoginView : UIView

@property (copy,nonatomic) LoginClickBlock loginOption;


/**
 单例登录视图
 
 @return 登录视图
 */
+(HSYLoginView *)shareInstance;
/**
 登录视图
 
 @param superView 父视图
 @param handlerBlock 登录回调
 @param block 约束
 */
-(instancetype)initWithSuperView:(UIView *)superView;
/**
 父视图移除
 */
-(void)removeInSuperView;

@end

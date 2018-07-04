//
//  IMBridgeProtocol.h
//  Pods
//
//  Created by 烽行意志 on 2018/5/10.
//

#ifndef IMBridgeProtocol_h
#define IMBridgeProtocol_h

#import "IMBridgeMacros.h"
#import "MGJRouter.h"


#define IM_GET_BRIDGE(IM_bridge)\
id <IMBridgeProtocol>IM_bridge = [MGJRouter objectForURL:IM_BRIDGE_OBJECT]

/**
 *  一般操作成功回调
 */
typedef void (^IMSucc)(void);

/**
 *  操作失败回调
 *
 *  @param code 错误码
 *  @param msg  错误描述，配合错误码使用，如果问题建议打印信息定位
 */
typedef void (^IMFail)(int code, NSString * msg);

/**
 *  登陆成功回调
 */
typedef void (^IMLoginSucc)(void);

@protocol IMBridgeProtocol <NSObject>

/**
 APPLaunch调用
 */
- (void)registerIM;


/**
 匿名登录
 */
-(void)anonymousLoginIM;

/**
 登出
 
 @param succ 成功回调
 @param fail 失败回调
 */
-(void)imloginout:(IMLoginSucc)succ fail:(IMFail)fail;

/**
 用户登录

 @param uid id
 @param usig sig
 @param succ 成功回调
 @param fail 失败回调
 */
-(void)imlogin:(NSString *)uid Usig:(NSString *)usig succ:(IMLoginSucc)succ fail:(IMFail)fail;

@end
#endif /* IMBridgeProtocol_h */

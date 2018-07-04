//
//  NSObject+HSY.h
//  AFNetworking
//
//  Created by HSY on 2018/5/7.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <AVFoundation/AVFoundation.h>

//非 nil 或者 非NSNull  返回真
#define NotNilNull(_ref)   (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
//字符串 非nil 非NSNull 非@"" 返回真
#define NotEmpty(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]) && (![(_ref)isEqualToString:@""]))


typedef void (^CommonVoidBlock)(void);

typedef void (^CommonBlock)(id selfPtr);

typedef void (^CommonCompletionBlock)(id selfPtr, BOOL isFinished);

@interface NSObject (HSY)

#pragma mark Block
- (void)excuteBlock:(CommonBlock)block;

- (void)performBlock:(CommonBlock)block;

//- (void)cancelBlock:(CommonBlock)block;

- (void)performBlock:(CommonBlock)block afterDelay:(NSTimeInterval)delay;

- (void)excuteCompletion:(CommonCompletionBlock)block withFinished:(NSNumber *)finished;

- (void)performCompletion:(CommonCompletionBlock)block withFinished:(BOOL)finished;

// 并发执行tasks里的作务，等tasks执行行完毕，回调到completion
- (void)asynExecuteCompletion:(CommonBlock)completion tasks:(CommonBlock)task, ... NS_REQUIRES_NIL_TERMINATION;

#pragma mark 相关工具
/**
 获取对象的所有属性
 
 @return 所有属性数组
 */
- (NSArray *)getAllProperties;

/**
 对象转字典不使用MJ 因为无法针对子类对象
 
 @return 字典
 */
- (NSMutableDictionary *)getAllPropertiesWithValue;
/**
 获取当前对象所在控制器
 
 @return nil
 */
+ (UIViewController *)getCurrentVC;
#pragma mark 坐标系转换
/**
 百度坐标转火星坐标
 
 @param p 百度坐标
 @return 火星坐标
 */
+(CLLocationCoordinate2D)transformFromBaiduToGCJ:(CLLocationCoordinate2D)p;

#pragma mark 权限请求相关
/**
 请求相机权限
 
 @param completion 请求权限成功
 */
- (void)requestCameraPemissionWithResult:(void(^)( BOOL granted))completion;

/**
 对象非空判断
 
 @param block 不为空下的回调
 */
- (void)objectEmpty:(CommonVoidBlock)block;

/**
 比较两个返回值 是否一样
 安全的比较 NSString 和 NSNumber
 */
- (BOOL)safeIsEqualToString:(NSString *)aString;

/**
 字典安全取值
 */
- (id)safeObjectForKey:(NSString *)aKey;

/**
 字典安全设置值
 */
- (void)safeSetObject:(id)anObject forKey:(NSString *)aKey;

/**
 数组安全加值
 */
- (void)safeAddObject:(id)anObject;

/**
 数组安全删除
 */
- (void)safeRemoveObject:(id)anObject;

/**
 数组安全获取对象
 */
- (id)safeObjectAtIndex:(NSUInteger)index;
@end

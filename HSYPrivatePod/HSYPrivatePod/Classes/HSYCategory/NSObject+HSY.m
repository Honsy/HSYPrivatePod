//
//  NSObject+HSY.m
//  AFNetworking
//
//  Created by HSY on 2018/5/7.
//

#import "NSObject+HSY.h"
#import <objc/runtime.h>

@implementation NSObject (HSY)

#pragma mark Block

- (void)excuteBlock:(CommonBlock)block
{
    __weak id selfPtr = self;
    if (block) {
        block(selfPtr);
    }
}

- (void)performBlock:(CommonBlock)block
{
    if (block)
    {
        [self performSelector:@selector(excuteBlock:) withObject:block];
    }
}

- (void)performBlock:(CommonBlock)block afterDelay:(NSTimeInterval)delay
{
    if (block)
    {
        [self performSelector:@selector(excuteBlock:) withObject:block afterDelay:delay];
    }
}

- (void)cancelBlock:(CommonBlock)block
{
    [[NSRunLoop currentRunLoop] cancelPerformSelector:@selector(excuteBlock:) target:self argument:block];
}


- (void)excuteCompletion:(CommonCompletionBlock)block withFinished:(NSNumber *)finished
{
    __weak id selfPtr = self;
    if (block) {
        block(selfPtr, finished.boolValue);
    }
}

- (void)performCompletion:(CommonCompletionBlock)block withFinished:(BOOL)finished
{
    if (block)
    {
        [self performSelector:@selector(excuteCompletion:withFinished:) withObject:block withObject:[NSNumber numberWithBool:finished]];
    }
}

- (void)cancelCompletion:(CommonCompletionBlock)block
{
    [[NSRunLoop currentRunLoop] cancelPerformSelector:@selector(excuteCompletion:withFinished:) target:self argument:block];
}

//- (void)performCompletion:(CommonCompletionBlock)block withFinished:(BOOL)finished afterDelay:(NSTimeInterval)delay
//{
//    if (block)
//    {
//        self performSelector:(SEL) withObject:<#(id)#> afterDelay:<#(NSTimeInterval)#>
////        [self performSelector:@selector(excuteCompletion:withFinished:) withObject:block withObject:[NSNumber numberWithBool:finished] afterDelay:delay];
//    }
//}

- (void)asynExecuteCompletion:(CommonBlock)completion tasks:(CommonBlock)task, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list arguments;
    
    if (task)
    {
        if (task)
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                if (task)
                {
                    task(self);
                }
            });
            
            va_start(arguments, task);

            BOOL next = YES;
            do
            {
                CommonBlock eachObject = va_arg(arguments, CommonBlock);

                if (eachObject)
                {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        if (eachObject)
                        {
                            eachObject(self);
                        }
                    });
                }
                else
                {
                    next = NO;
                }
                
            }while (next);
            va_end(arguments);
        }
        
        
        
        
        dispatch_barrier_async(dispatch_get_global_queue(0, 0), ^{
            if (completion)
            {
                completion(self);
            }
        });
    }
}

//获取对象的所有属性
- (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* char_f =property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        NSLog(@"%@",propertyValue);
        [propertiesArray addObject: [NSString stringWithUTF8String: char_f]];
    }
    free(properties);
    return propertiesArray;
}

//对象转字典不使用MJ 因为无法针对子类对象
- (NSMutableDictionary *)getAllPropertiesWithValue
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableDictionary * keyValueDict = [NSMutableDictionary dictionary];
    for (int i = 0; i<count; i++)
    {
        const char* char_f =property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        [keyValueDict setValue:propertyValue forKey:propertyName];
    }
    free(properties);
    return keyValueDict;
}

#pragma mark 获取当前对象所在控制器
+ (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    //自定义Tabbar 此处修改
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        
        //        NSLog(@"%@",nav.childViewControllers);
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
        //自定义导航控制器 此处修改
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}


static const double xPi = M_PI  * 3000.0 / 180.0;
#pragma mark Baidu坐标转火星坐标

+(CLLocationCoordinate2D)transformFromBaiduToGCJ:(CLLocationCoordinate2D)p
{
    double x = p.longitude - 0.0065, y = p.latitude - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * xPi);
    double theta = atan2(y, x) - 0.000003 * cos(x * xPi);
    CLLocationCoordinate2D geoPoint;
    geoPoint.latitude  = z * sin(theta);
    geoPoint.longitude = z * cos(theta);
    return geoPoint;
}

#pragma mark 权限请求
//请求相机权限
- (void)requestCameraPemissionWithResult:(void(^)( BOOL granted))completion
{
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                completion(YES);
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                completion(NO);
                break;
            case AVAuthorizationStatusNotDetermined:
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                         completionHandler:^(BOOL granted) {
                                             
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 if (granted) {
                                                     completion(true);
                                                 } else {
                                                     completion(false);
                                                 }
                                             });
                                             
                                         }];
            }
                break;
                
        }
    }
    
    
}

// 对象非空判断
- (void)objectEmpty:(CommonVoidBlock)block{
    if ([self isKindOfClass:[NSString class]]) {
        NSString * str = (NSString *)self;
        if (str&&str.length>0) {
            block();
            return;
        }
    }
    if ([self isKindOfClass:[NSArray class]]) {
        NSArray * array = (NSArray *)self;
        if (array&&array.count>0) {
            block();
            return;
            
        }
    }
    if ([self isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dic = (NSDictionary *)self;
        if (dic&&dic.count>0) {
            block();
            return;
        }
    }
    if (self) {
        block();
        return;
    }
    
}

- (BOOL)safeIsEqualToString:(NSString *)aString
{
    if (NotNilNull(self) && [self isKindOfClass:[NSString class]]) {
        NSString *obj = (NSString *)self;
        return [obj isEqualToString:aString];
    }else if (NotNilNull(self) && [self isKindOfClass:[NSNumber class]])
    {
        NSNumber *obj = (NSNumber *)self;
        return [[obj stringValue] isEqualToString:aString];
    }else{
        NSAssert(NO, @"类型不合法");
        return NO;
    }
}

- (id)safeObjectForKey:(NSString *)aKey
{
    if (self && [self isKindOfClass:[NSDictionary class]] && NotNilNull(aKey)) {
        NSDictionary *dictObj = (NSDictionary *)self;
        id value =  [dictObj objectForKey:aKey];
        return value;
    }else {
        NSAssert(NO, @"类型不合法");
        return nil;
    }
}
- (void)safeSetObject:(id)anObject forKey:(NSString *)aKey
{
    if (NotNilNull(self) && [self isKindOfClass:[NSMutableDictionary class]] && NotNilNull(anObject)) {
        NSMutableDictionary *obj = (NSMutableDictionary *)self;
        [obj setObject:anObject forKey:aKey];
    }
    else
    {
        NSAssert(NO, @"类型不合法");
    }
}

- (void)safeAddObject:(id)anObject
{
    if (self && [self isKindOfClass:[NSMutableArray class]] && anObject && NotNilNull(anObject)) {
        NSMutableArray *obj = (NSMutableArray *)self;
        [obj addObject:anObject];
    }
    else
    {
        NSAssert(NO, @"类型不合法");
    }
}
- (void)safeRemoveObject:(id)anObject
{
    if (self && [self isKindOfClass:[NSMutableArray class]] && NotNilNull(anObject)) {
        NSMutableArray *obj = (NSMutableArray *)self;
        if ([obj containsObject:anObject]) {
            [obj removeObject:anObject];
        }
    }
    else
    {
        NSAssert(NO, @"类型不合法");
    }
}


- (id)safeObjectAtIndex:(NSUInteger)index {
    NSArray *obj = nil;
    if (NotNilNull(self) && [self isKindOfClass:[NSArray class]]) {
        obj = (NSArray *)self;
    }else{
        NSAssert(NO, @"类型不合法");
    }
    return index < obj.count ? obj[index] : nil;
}

@end

//
//  UINavigationBar+HSY.m
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/15.
//

#import "UINavigationBar+HSY.h"

@implementation UINavigationBar (HSY)

-(void)hsy_setNavigationBarBackgroundClear{
    
    [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[[UIImage alloc] init]];
}

-(void)hsy_cancelNavigationBarBackgroundClear{
    
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:nil];
}

@end

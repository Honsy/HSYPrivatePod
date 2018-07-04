//
//  HSYEditorConfiguration.m
//  AFNetworking
//
//  Created by 烽行意志 on 2018/7/4.
//

#import "HSYEditorConfiguration.h"

@implementation HSYEditorConfiguration

+ (HSYEditorConfiguration *)sharedHSYEditorConfiguration{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}
@end

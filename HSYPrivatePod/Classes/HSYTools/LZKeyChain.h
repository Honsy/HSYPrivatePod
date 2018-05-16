//
//  LZKeyChain.h
//  ddchebao-ios
//
//  Created by 烽行意志 on 2017/6/23.
//  Copyright © 2017年 HSY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

#define kBundleIdentifier [[NSBundle mainBundle] bundleIdentifier]

//NSString * const KEY_UDID_INSTEAD = @"com.myapp.udid.test";

@interface LZKeyChain : NSObject

/**
 本方法是得到 UUID 后存入系统中的 keychain 的方法
 不用添加 plist 文件
 程序删除后重装,仍可以得到相同的唯一标示
 但是当系统升级或者刷机后,系统中的钥匙串会被清空,此时本方法失效
 */
+(NSString *)getDeviceIDInKeychain;

@end

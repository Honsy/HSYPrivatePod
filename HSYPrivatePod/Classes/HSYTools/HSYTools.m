//
//  HSYTools.m
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/15.
//

#import "HSYTools.h"

@implementation HSYTools

// 读取APP唯一标志符
+(NSString *)getAppUDID{
    
    return [HSYTools subStrForUDID:[LZKeyChain getDeviceIDInKeychain]];
}
//截取UDID
+(NSString *)subStrForUDID:(NSString *)UDID{
    NSArray * array = [UDID componentsSeparatedByString:@"-"];
    return [NSString stringWithFormat:@"用户%@",array[0]];
}

@end

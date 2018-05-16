//
//  HSYTools.h
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/15.
//

#import <Foundation/Foundation.h>
#import "LZKeyChain.h"

@interface HSYTools : NSObject

//读取APP唯一标志符
+(NSString *)getAppUDID;
//截取UDID
+(NSString *)subStrForUDID:(NSString *)UDID;


@end

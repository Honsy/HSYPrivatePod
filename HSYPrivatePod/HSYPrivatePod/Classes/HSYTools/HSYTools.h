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
// 去掉HTML标签
+(NSString *)filterHTML:(NSString *)html;
//去掉/n
+(NSString *)filterNewLine:(NSString *)content;
//处理WebView遇到/n不换行的问题
+(NSString *)handleNewlineWithWebView:(NSString *)html;

@end

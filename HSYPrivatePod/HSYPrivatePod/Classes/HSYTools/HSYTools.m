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

// 去掉HTML标签
+(NSString *)filterHTML:(NSString *)html {
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

//去掉/n
+(NSString *)filterNewLine:(NSString *)content{
    NSString *str = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return str;
}

//处理WebView遇到/n不换行的问题
+(NSString *)handleNewlineWithWebView:(NSString *)html{
    NSString *str = [html stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    return str;
}
@end

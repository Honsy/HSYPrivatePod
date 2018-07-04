//
//  HSYDefine.h
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/11.
//

#import <Foundation/Foundation.h>

#define statusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

#define navigationHeight self.navigationController.navigationBar.frame.size.height

// RGB颜色
#define HSYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define HSYHexColor(Str) [UIColor colorWithHexString:(Str)]

@interface HSYDefine : NSObject


@end

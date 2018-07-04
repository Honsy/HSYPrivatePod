//
//  HSYEditorConfiguration.h
//  AFNetworking
//
//  Created by 烽行意志 on 2018/7/4.
//

#import <Foundation/Foundation.h>

@interface HSYEditorConfiguration : NSObject

//是否隐藏标题
@property (assign,nonatomic) BOOL   showTitle;

+ (HSYEditorConfiguration *)sharedHSYEditorConfiguration;

@end

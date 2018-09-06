//
//  WeexController.h
//  AFNetworking
//
//  Created by 烽行意志 on 2018/9/6.
//

#import <UIKit/UIKit.h>

@interface WeexController : UIViewController

@property (nonatomic, strong) NSString *script;
@property (nonatomic, strong) NSURL *url;

//@property (nonatomic, strong) SRWebSocket *hotReloadSocket;
@property (nonatomic, strong) NSString *source;
@end

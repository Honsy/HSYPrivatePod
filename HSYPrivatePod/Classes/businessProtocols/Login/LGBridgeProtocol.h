//
//  LGBridgeProtocol.h
//  Pods
//
//  Created by 烽行意志 on 2018/5/10.
//

#ifndef LGBridgeProtocol_h
#define LGBridgeProtocol_h


#import "LGBridgeMacros.h"
#import "MGJRouter.h"

@protocol LGBridgeProtocol;

#define LG_GET_BRIDGE(LG_bridge)\
id <LGBridgeProtocol>LG_bridge = [MGJRouter objectForURL:LG_BRIDGE_OBJECT];

@protocol LGBridgeProtocol <NSObject>


/**
 返回当前登录对象

 @return LoginUserCenter
 */
-(id)loginUser;
@end

#endif /* LGBridgeProtocol_h */

//
//  IMBridgeProtocol.h
//  Pods
//
//  Created by 烽行意志 on 2018/5/10.
//

#ifndef IMBridgeProtocol_h
#define IMBridgeProtocol_h

#import "IMBridgeMacros.h"
#import "MGJRouter.h"


#define IM_GET_BRIDGE(IM_bridge)\
id <IMBridgeProtocol>IM_bridge = [MGJRouter objectForURL:IM_BRIDGE_OBJECT];

@protocol IMBridgeProtocol <NSObject>

/**
 APPLaunch调用
 */
- (void)registerIM;

@end
#endif /* IMBridgeProtocol_h */

//
//  MPBridgeProtocol.h
//  Pods
//
//  Created by 烽行意志 on 2018/5/10.
//

#ifndef MPBridgeProtocol_h
#define MPBridgeProtocol_h

#import "MPBridgeMacros.h"
#import "MGJRouter.h"

@protocol MPBridgeProtocol;

#define MP_GET_BRIDGE(MP_bridge)\
id <MPBridgeProtocol>MP_bridge = [MGJRouter objectForURL:MP_BRIDGE_OBJECT];

@protocol MPBridgeProtocol <NSObject>

@end

#endif /* MPBridgeProtocol_h */

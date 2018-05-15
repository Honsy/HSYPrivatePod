//
//  HPBridgeProtocol.h
//  Pods
//
//  Created by 烽行意志 on 2018/5/10.
//

#ifndef HPBridgeProtocol_h
#define HPBridgeProtocol_h

#import "HPBridgeMacros.h"
#import "MGJRouter.h"

@protocol HGBridgeProtocol;

#define HP_GET_BRIDGE(hp_bridge)\
id <HPBridgeProtocol>hp_bridge = [MGJRouter objectForURL:HP_BRIDGE_OBJECT];

@protocol HGBridgeProtocol <NSObject>

@end

#endif /* HPBridgeProtocol_h */

//
//  DCBridgeProtocol.h
//  Pods
//
//  Created by 烽行意志 on 2018/5/10.
//

#ifndef DCBridgeProtocol_h
#define DCBridgeProtocol_h

#import "DCBridgeMacros.h"
#import "MGJRouter.h"

@protocol DCBridgeProtocol;

#define DC_GET_BRIDGE(dc_bridge)\
id <DCBridgeProtocol>dc_bridge = [MGJRouter objectForURL:DC_BRIDGE_OBJECT];

@protocol DCBridgeProtocol <NSObject>

@end


#endif /* DCBridgeProtocol_h */

//
//  NBBridgeProtocol.h
//  Pods
//
//  Created by 烽行意志 on 2018/5/10.
//

#ifndef NBBridgeProtocol_h
#define NBBridgeProtocol_h

#import "NBBridgeMacros.h"
#import "MGJRouter.h"

@protocol NBBridgeProtocol;

#define NB_GET_BRIDGE(nb_bridge)\
id <NBBridgeProtocol>nb_bridge = [MGJRouter objectForURL:NB_BRIDGE_OBJECT];

@protocol NBBridgeProtocol <NSObject>

@end


#endif /* NBBridgeProtocol_h */

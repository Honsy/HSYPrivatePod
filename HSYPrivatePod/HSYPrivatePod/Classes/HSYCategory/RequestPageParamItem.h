//
//  RequestPageParamItem.h
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/9.
//

#import <Foundation/Foundation.h>

@interface RequestPageParamItem : NSObject

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) BOOL canLoadMore;


@end

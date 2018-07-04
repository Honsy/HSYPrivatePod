//
//  LGUserInfo.h
//  Pods
//
//  Created by 烽行意志 on 2018/5/18.
//

#ifndef LGUserInfo_h
#define LGUserInfo_h

@protocol LGUserInfo;
#define LG_GET_UseInfo_BRIDGE(useInfo_bridge)\
id <LGUserInfo>useInfo_bridge = [MGJRouter objectForURL:LG_USEINFO_OBJECT];

@protocol LGUserInfo <NSObject>

@property (nonatomic, assign) BOOL         isLogined; // 是否登录

@property (nonatomic, copy)  NSString        * nickname;//昵称
@property (nonatomic, copy)  NSString        * age;//年龄
@property (nonatomic, copy)  NSString        * faceUrl;//头像
@property (nonatomic, copy)  NSString        * sex;//性别
@property (nonatomic, copy)  NSString        * uid;//uid
@property (nonatomic, copy)  NSString        * username;//账号
@property (nonatomic, copy)  NSString        * signature;//签名
@property (nonatomic, copy)  NSString        * birthday;//生日
@property (nonatomic, copy)  NSString        * city;//城市
@property (nonatomic, copy)  NSString        * friendsCoverUrl;//朋友圈头像


/**
 抓取用户信息
 */
-(void)fetchUserInfo;
//清除信息
- (void)clearUserInfo;

@end

#endif /* LGUserInfo_h */

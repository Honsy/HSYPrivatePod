//
//  NSString+HSY.h
//  wnchebao
//
//  Created by 洪少远 on 2017/4/1.
//  Copyright © 2017年 zhengzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface NSString (HSY)


/**
 经纬度转字典

 @param location 经纬度

 @return 字符串
 */
+(NSDictionary *)stringWithLocation:(CLLocationCoordinate2D)location;

/**
 截取城市名

 @param address 地址

 @return 城市
 */
+(NSString *)cutOutCityName:(NSString *)address;

/**
 汉字转拼音

 @param chinese 汉字

 @return 拼音
 */
+ (NSString *)transform:(NSString *)chinese;

/**
 返回字符串对应高度

 @param font 字体
 @param width 限制宽度
 @param string 字符串
 @return 高度
 */
+(CGSize)heightWithFont:(UIFont*)font Width:(NSInteger)width String:(NSString *)string;


/**
 返回字符串对应宽度

 @param size 字体大小
 @param string 字符串
 @return 宽度
 */
+(CGFloat)widthWithFontSize:(NSInteger)size String:(NSString *)string;

/**
 将服务器返回距离 以及时间转化为字符串
 
 @param value 距离长度 unit
 @param unit 单位
 @param startTime 时间戳字符串
 @return 距离加时间字符串
 */
+(NSString *)stringWithDistanceAndTime:(NSString *)value Unit:(NSString *)unit StartTime:(NSString *)startTime;
/**
 判断字符串是否为空

 @param string 字符串
 @return YES or NO
 */
+ (BOOL)isEmpty:(NSString *)string;

//String转VC
-(UIViewController *)viewcontrollerWithString:(NSString *)string;


/**
 天气类型转天气图片名

 @param type 天气类型
 @return 天气图片名
 */
+(NSString *)weatherImageNameWithWeatherType:(NSString *)type;

/**
 指数类型 转图片名

 @param IndcationName 指数类型
 @return 图片名
 */
+(NSString *)IndcationImgNameWithIndcation:(NSString *)IndcationName;

/**
 指数对应背景

 @param indicationName 指数名称
 @return 对应图片名
 */
+(NSString *)indicationBackgroundImage:(NSString *)indicationName;
/**
 天气Banner图

 @param weatherType 天气类型
 @return 背景名
 */
+(NSString *)weatherBackNameWithWeatherType:(NSString *)weatherType;

/**
 数字转性别

 @param number 对应 0，1，2
 @return 性别对应 无 女 男
 */
+(NSString *)getSexWithNumber:(NSString *)number;
@end

//
//  NSString+HSY.m
//  wnchebao
//
//  Created by 洪少远 on 2017/4/1.
//  Copyright © 2017年 zhengzhou. All rights reserved.
//

#import "NSString+HSY.h"
#import "NSDate+HSY.h"

@implementation NSString (HSY)

// 经纬度转字典
+(NSDictionary *)stringWithLocation:(CLLocationCoordinate2D)location{
    
    NSNumber    * longitudeNumber = [NSNumber numberWithDouble:location.longitude];
    
    NSNumber    * latitudeNumber = [NSNumber numberWithDouble:location.latitude];    
    
    NSString    * longitude = [NSString stringWithFormat:@"%@",longitudeNumber];
    
    NSString    * latitude = [NSString stringWithFormat:@"%@",latitudeNumber];

    NSDictionary * locationDic = @{@"longitude":longitude,@"latitude":latitude};
    
    return locationDic;
}

//截取城市名
+(NSString *)cutOutCityName:(NSString *)address{
    NSArray *array = [address componentsSeparatedByString:@"市"]; //从字符A中分隔成2个元素的数组

    NSString * str = array[0];
    
    NSArray *array1 = [str componentsSeparatedByString:@"省"];

    return array1[1];
}

//汉字转拼音
+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}

//返回字符串对应高度
+(CGSize)heightWithFont:(UIFont*)font Width:(NSInteger)width String:(NSString *)string{
    
    NSDictionary *attributesDict = @{NSFontAttributeName:font};
    
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    
    CGRect subviewRect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDict context:nil];
    
    return subviewRect.size;
    
}

+(CGFloat)widthWithFontSize:(NSInteger)size String:(NSString *)string{
    
    return string.length * size;

}

//组合距离与时间字符串  附近界面使用 其他界面使用可套用
+(NSString *)stringWithDistanceAndTime:(NSString *)value Unit:(NSString *)unit StartTime:(NSString *)startTime{
    
    float value1 = [value floatValue];
    
    NSString * distance = [NSString stringWithFormat:@"%.2f %@",value1,unit];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    
    dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss";//指定转date得日期格式化形式
    
    return [NSString stringWithFormat:@"%@ %@",distance,[NSDate intervalSinceNow:startTime]];
}
#pragma mark - Utils
+ (BOOL)isEmpty:(NSString *)string
{
    if ([string isKindOfClass:[NSString class]]) {
        return string == nil || string.length == 0 || [string isEqualToString:@"(null)]"];
    }else{
        return YES;
    }
}

//String转VC
-(UIViewController *)viewcontrollerWithString:(NSString *)string{
    
    Class class = NSClassFromString(string);
    
    UIViewController *vc = [[class alloc]init];
    
    return vc;
}

//天气类型转天气图片名
+(NSString *)weatherImageNameWithWeatherType:(NSString *)type{
    
    //判断白天晚上
    
    if (![NSDate isNight]) {
        //白天
        if ([type isEqualToString:@"晴"]) {
            return @"fair_day";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }else if ([type isEqualToString:@"阴"]){
            return @"cloudy_day_night";
        }else if ([type isEqualToString:@"雷阵雨转阴"]){
            return @"scattered_thundershowers_day";
        }else if ([type isEqualToString:@"雷阵雨"]){
            return @"scattered_showers_day_night";
        }else if ([type isEqualToString:@"小雨"]){
            return @"light_rain_day_night";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }
        else{
            return @"fair_day";
        }
    }else{
        //黑夜
        if ([type isEqualToString:@"晴"]) {
            return @"fair_night";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_night";
        }else if ([type isEqualToString:@"阴"]){
            return @"cloudy_day_night";
        }else if ([type isEqualToString:@"雷阵雨转阴"]){
            return @"scattered_thundershowers_night";
        }else if ([type isEqualToString:@"雷阵雨"]){
            return @"scattered_showers_day_night";
        }else if ([type isEqualToString:@"小雨"]){
            return @"light_rain_day_night";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }else if ([type isEqualToString:@"多云"]){
            return @"partly_cloudy_day";
        }else{
            return @"fair_night";
        }
    }
}

//指数转图片名
+(NSString *)IndcationImgNameWithIndcation:(NSString *)IndcationName{
    if ([IndcationName isEqualToString:@"穿衣指数"]) {
        return @"icon_zhishu_clothing";
    }else if ([IndcationName isEqualToString:@"感冒指数"]){
        return @"icon_zhishu_ganmao";
    }else if ([IndcationName isEqualToString:@"紫外线指数"]){
        return @"icon_zhishu_zyx";
    }else if ([IndcationName isEqualToString:@"洗车指数"]){
        return @"icon_zhishu_xiche";
    }else if ([IndcationName isEqualToString:@"运动指数"]){
        return @"icon_zhishu_sport";
    }else if ([IndcationName isEqualToString:@"旅游指数"]){
        return @"icon_zhishu_trip";
    }else if ([IndcationName isEqualToString:@"约会指数"]){
        return @"icon_zhishu_yh";
    }else if ([IndcationName isEqualToString:@"晨练指数"]){
        return @"icon_zhishu_cl";
    }else if ([IndcationName isEqualToString:@"舒适度"]){
        return @"icon_zhishu_soft";
    }else if ([IndcationName isEqualToString:@"雨伞指数"]){
        return @"icon_zhishu_ys";
    }else if ([IndcationName isEqualToString:@"晾晒指数"]){
        return @"icon_zhishu_ls";
    }else{
        return @"icon_zhishu_other";
    }
}

//指数对应背景
+(NSString *)indicationBackgroundImage:(NSString *)indicationName{
    
    if ([indicationName containsString:@"较不"]) {
        return @"生活建议-较不适宜";
    }else if ([indicationName containsString:@"不"]){
        return @"生活建议-不适宜";
    }else if ([indicationName containsString:@"炎热"]){
        return @"生活建议-不适宜";
    }else if ([indicationName containsString:@"弱"]){
        return @"生活建议-较适宜";
    }else if ([indicationName containsString:@"少发"]){
        return @"生活建议-较适宜";
    }else if ([indicationName isEqualToString:@"适宜"]){
        return @"生活建议-适宜";
    }else{
        return @"生活建议-适宜";
    }
    
}

//天气Banner
+(NSString *)weatherBackNameWithWeatherType:(NSString *)weatherType{
    
    if ([weatherType containsString:@"晴"]) {
        return @"晴";
    }else if ([weatherType containsString:@"阴"]){
        return @"阴天";
    }else if ([weatherType containsString:@"雨"]){
        return @"雨";
    }else if ([weatherType containsString:@"雪"]){
        return @"雪";
    }else if ([weatherType containsString:@"雾"]){
        return @"雾霾";
    }else{
        return @"晴";
    }
}

//数字转性别
+(NSString *)getSexWithNumber:(NSString *)number{
    if ([number isEqualToString:@"0"]) {
        return @"无";
    }else if ([number isEqualToString:@"1"]){
        return @"女";
    }else{
        return @"男";
    }
}
@end

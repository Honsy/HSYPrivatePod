//
//  HSYCarProvinceView.h
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/31.
//

#import <UIKit/UIKit.h>

typedef void (^CarProvinceOption)(NSString * province);

@protocol HSYCarProvinceDelegate <NSObject>

-(void)carProvince:(NSString *)province;

@end

@interface HSYCarProvinceView : UIView

@property (assign,nonatomic) id<HSYCarProvinceDelegate>    delegate;

@property (copy,nonatomic) CarProvinceOption    option;

//初始化
-(instancetype)init;

//展示
-(void)showInView:(UIView *)view;

-(void)dismiss;

@end

#pragma mark Cell

@interface HSYProvinceCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *license;

@end

//
//  HSYLoginView.m
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/25.
//

#import "HSYLoginView.h"

@interface HSYLoginView()


@end


@implementation HSYLoginView

+(HSYLoginView *)shareInstance{
 
}

//加载到父视图
-(instancetype)initWithSuperView:(UIView *)superView{
    
    if (self = [super init]) {
        self.frame = superView.frame;
        
        [superView addSubview:self];
        
        UIImageView *  loginImage = [[UIImageView alloc]init];
        
        NSBundle *bundle = [NSBundle bundleForClass:[HSYLoginView class]];

        loginImage.image = [UIImage imageNamed:@"ic_login" inBundle:bundle compatibleWithTraitCollection:nil];
        
        [self addSubview:loginImage];
        
        [loginImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(-80);
            make.height.width.offset(100);
        }];
        
        UILabel * title = [[UILabel alloc]init];
        
        title.text = @"登录后才可以查看消息哦！";
        
        title.textColor = [UIColor colorWithRed:55/255.0 green:55/255.0 blue:55/255.0 alpha:1];
        
        title.font = [UIFont fontWithName:@"PingFangTC-Regular" size:12.f];
        
        [self addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(loginImage.mas_bottom).offset(8);
        }];
        
        UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        loginBtn.backgroundColor = [UIColor colorWithRed:38/255.0 green:137/255.0 blue:247/255.0 alpha:1];
        
        loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFangTC-Regular" size:14.f];
        
        [loginBtn setTitle:@"登录查看我的消息" forState:UIControlStateNormal];
        
        [loginBtn addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:loginBtn];
        
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(title.mas_bottom).offset(8);
            make.height.offset(32);
            make.width.equalTo(title.mas_width);
        }];
    }
    return self;
    
}

-(void)removeInSuperView{
    if (self) {
        [self removeFromSuperview];
    }
}


-(void)goLogin{
    if (self.loginOption) {
        self.loginOption();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

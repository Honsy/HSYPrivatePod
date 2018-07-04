//
//  HSYUnderLineTF.m
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/14.
//

#import "HSYUnderLineTF.h"

@implementation HSYUnderLineTF

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextFillRect(context,CGRectMake(0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 1));
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

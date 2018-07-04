//
//  HSYViewController.m
//  Pods
//
//  Created by 烽行意志 on 2018/5/10.
//

#import "HSYViewController.h"
#import "HSYCategory.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface HSYViewController ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation HSYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

}

//空数据
-(void)emptyDataForView:(id)view{
    if ([view isKindOfClass:[UITableView class]]) {
        UITableView * tableView = view;
        tableView.emptyDataSetDelegate = self;
        tableView.emptyDataSetSource = self;
    }else if ([view isKindOfClass:[UICollectionView class]]){
        UICollectionView * collection = view;
        collection.emptyDataSetSource = self;
        collection.emptyDataSetDelegate = self;
    }
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    NSBundle *bundle = [NSBundle bundleForClass:[HSYViewController class]];
    
    return [UIImage imageNamed:@"ic_empty" inBundle:bundle compatibleWithTraitCollection:nil];
}

//点击键盘消失
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  HSYCarProvinceView.m
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/31.
//

#import "HSYCarProvinceView.h"

#define screen_W    [UIScreen mainScreen].bounds.size.width
#define screen_H    [UIScreen mainScreen].bounds.size.height


@interface HSYCarProvinceView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView   * collectionView;

@property (strong,nonatomic) UIView             * contentView;

@property (strong,nonatomic) NSArray            * provinces;

@end

@implementation HSYCarProvinceView

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, screen_H-170, screen_W, 170)];
        
        _contentView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _collectionView.frame = CGRectMake(0, 10, screen_W, 160);
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[HSYProvinceCell class] forCellWithReuseIdentifier:@"province"];
        
        [_contentView addSubview:_collectionView];
        
        UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        cancelButton.frame = CGRectMake(screen_W-54, 170-36, 50, 30);

        cancelButton.backgroundColor = [UIColor redColor];
        
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentView addSubview:cancelButton];
        
    }
    return _contentView;
    
}

-(instancetype)init{
    if (self = [super init]) {
        
        NSBundle *bundle = [NSBundle bundleForClass:[HSYCarProvinceView class]];

        _provinces = [NSArray arrayWithContentsOfFile:[bundle pathForResource:@"CarProvince" ofType:@"plist"]];
        
        self.frame = [UIScreen mainScreen].bounds;

        UIView * view = [[UIView alloc]initWithFrame:self.frame];
        
        view.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        
        [view addGestureRecognizer:tap];
        
        [self addSubview:view];

        [self addSubview:self.contentView];
        
    }
    return self;
}

-(void)showInView:(UIView *)view{
    [view addSubview:self];
}

-(void)dismiss{
    [self removeFromSuperview];
}


#pragma mark CollectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _provinces.count;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(30,30);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HSYProvinceCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"province" forIndexPath:indexPath];
    
    cell.license.text = _provinces[indexPath.item];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [self dismiss];

    if (_option) {
        _option(_provinces[indexPath.item]);
    }
    
    if (![_delegate respondsToSelector:@selector(carProvince:)]) {
        [_delegate carProvince:_provinces[indexPath.item]];
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

#pragma mark Cell
@implementation HSYProvinceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _license = [[UILabel alloc]init];
        
        _license.frame = CGRectMake(6, 6, 18, 18);
        
        [self addSubview:_license];
    }
    return self;
    
}

@end

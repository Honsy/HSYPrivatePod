//
//  HSYEditorController.m
//  AFNetworking
//
//  Created by 烽行意志 on 2018/6/8.
//

#import "HSYEditorController.h"
#import "UIViewController+HSY.h"
#import "HSYNetworkManager.h"

#define UploadImageURL @"http://test.wnchebao.com/v1/file/add"

@interface HSYEditorController ()
@property(nonatomic, strong) NSMutableDictionary *mediaAdded;
@property(nonatomic, strong) NSString *selectedMediaID;
@property(nonatomic, strong) NSCache *videoPressCache;

@end

@implementation HSYEditorController

-(void)viewWillAppear:(BOOL)animated{
    [self configurationEditor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

-(void)initUI{    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self action:@selector(quitEdit)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(gotoNext)];

    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    WPEditorConfiguration *_WPEditorConfiguration = [WPEditorConfiguration sharedWPEditorConfiguration];

    _WPEditorConfiguration.localizable = kLMChinese;
    
    _WPEditorConfiguration.enableImageSelect =   ZSSRichTextEditorImageSelectPhotoLibrary |ZSSRichTextEditorImageSelectTakePhoto|ZSSRichTextEditorImageSelectInsertNetwork;
    
//    [self configurationEditor];

    self.delegate = self;
    
    self.itemTintColor = [UIColor redColor];
    self.mediaAdded = [NSMutableDictionary dictionary];
    self.videoPressCache = [[NSCache alloc] init];
    
    self.bodyPlaceholderText = @"写点什么吧";
    self.titlePlaceholderText = @"请输入标题";
    
//    _viewModel = [publishedArticleViewModel new];
//    _viewModel.article_id = [[NSUUID UUID] UUIDString];
//    _viewModel.userId = [[NSUUID UUID] UUIDString];
//    _viewModel.createTime = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    
}

-(void)configurationEditor{
    //是否显示标题
    if (_configuration.showTitle) {
        self.editorView.showTitleField = YES;     // 控制title 输入框是否显示
    }else{
        self.editorView.showTitleField = NO;
    }
}

-(void)quitEdit{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)gotoNext{
    if ([self.hsy_delegate respondsToSelector:@selector(editorNext:content:)]) {
        [self.hsy_delegate editorNext:self.titleText content:self.bodyText];
    }
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    
}
#pragma mark - WPEditorViewControllerDelegate

- (void)editorDidBeginEditing:(WPEditorViewController *)editorController
{
    NSLog(@"Editor did begin editing.");
}

- (void)editorDidEndEditing:(WPEditorViewController *)editorController
{
    NSLog(@"Editor did end editing.");
}

- (void)editorDidFinishLoadingDOM:(WPEditorViewController *)editorController
{
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"html"];
    //    NSString *htmlParam = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //      [self setTitleText:@""];
    //    [self setBodyText:htmlParam];
    
    [self startEditing];
}

- (BOOL)editorShouldDisplaySourceView:(WPEditorViewController *)editorController
{
    [self.editorView pauseAllVideos];
    return YES;
}

#pragma mark 图片选择
- (void)editorDidPressMedia:(int)type
{
    NSLog(@"Pressed Media!");
    
    [self pushImagePickerController:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//        if ([self.hsy_delegate respondsToSelector:@selector(selectImage:)]) {
//            [self.hsy_delegate selectImage:photos[0]];
//        }
        //直接这里上传
        UIImage * image = photos[0];
        
        NSData * data = UIImageJPEGRepresentation(image, 0.5);
        
        [[HSYNetworkManager sharedNetworkManager] POSTWithNoHandle:UploadImageURL Parameters:nil FileName:@"1" ImageData:data Success:^(id response) {
            
            NSString * str = [NSString stringWithFormat:@"%@",response[@"code"]];
            
            if ([str isEqualToString:@"200"]) {
                [self.editorView insertImage:response[@"data"][@"path"] alt:@""];
            }else{
                if (_errorMessage) {
                    _errorMessage(response[@"message"]);
                }
            }
        } Failure:^(NSError *error) {
            
        } Token:NO];
        
    } allowCrop:NO cropRect:CGRectZero];
    
}

- (void)editorTitleDidChange:(WPEditorViewController *)editorController
{
    NSLog(@"Editor title did change: %@", self.titleText);
    
//    _viewModel.title = self.titleText;
    
    [self initSaveTimer];
}

- (void)editorTextDidChange:(WPEditorViewController *)editorController
{
    NSLog(@"Editor body text changed: %@", self.bodyText);
    
//    _viewModel.content =  self.bodyText;
    
    [self initSaveTimer];
}
-(void)initSaveTimer{
    
//    if(!_saveTimer)
//        _saveTimer = [NSTimer scheduledTimerWithTimeInterval:30
//                                                      target:self
//                                                    selector:@selector(autoSaveArticle:)
//                                                    userInfo:nil
//                                                     repeats:YES];
    
}
- (void)editorViewController:(WPEditorViewController *)editorViewController fieldCreated:(WPEditorField*)field
{
//    NSLog(@"Editor field created: %@", field.nodeId);
}

- (void)editorViewController:(WPEditorViewController*)editorViewController
                 imageTapped:(NSString *)imageId
                         url:(NSURL *)url
                   imageMeta:(WPImageMeta *)imageMeta
{
    if (imageId.length == 0) {
//        [self showImageDetailsForImageMeta:imageMeta];
    } else {
//        [self showPromptForImageWithID:imageId];
    }
}

- (void)editorViewController:(WPEditorViewController*)editorViewController
                 videoTapped:(NSString *)videoId
                         url:(NSURL *)url
{
//    [self showPromptForVideoWithID:videoId];
}

- (void)editorViewController:(WPEditorViewController *)editorViewController imageReplaced:(NSString *)imageId
{
    [self.mediaAdded removeObjectForKey:imageId];
}

- (void)editorViewController:(WPEditorViewController *)editorViewController videoReplaced:(NSString *)videoId
{
    [self.mediaAdded removeObjectForKey:videoId];
}

- (void)editorViewController:(WPEditorViewController *)editorViewController videoPressInfoRequest:(NSString *)videoID
{
    NSDictionary * videoPressInfo = [self.videoPressCache objectForKey:videoID];
    NSString * videoURL = videoPressInfo[@"source"];
    NSString * posterURL = videoPressInfo[@"poster"];
    if (videoURL) {
        [self.editorView setVideoPress:videoID source:videoURL poster:posterURL];
    }
}

- (void)editorViewController:(WPEditorViewController *)editorViewController mediaRemoved:(NSString *)mediaID
{
    NSProgress * progress = self.mediaAdded[mediaID];
    [progress cancel];
}

- (void)editorFormatBarStatusChanged:(WPEditorViewController *)editorController
                             enabled:(BOOL)isEnabled
{
    NSLog(@"Editor format bar status is now %@.", (isEnabled ? @"enabled" : @"disabled"));
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

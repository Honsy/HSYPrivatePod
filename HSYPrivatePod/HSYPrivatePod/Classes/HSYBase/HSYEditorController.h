//
//  HSYEditorController.h
//  AFNetworking
//
//  Created by 烽行意志 on 2018/6/8.
//

#import "WPEditorViewController.h"
#import "WPEditorConfiguration.h"
#import "HSYEditorConfiguration.h"

typedef void(^HSYErrorMessage)(NSString *messge);

@protocol HSYEditorDelegate <NSObject>

-(void)editorNext:(NSString *)title content:(NSString *)content;

-(void)selectImageResult:(NSString *)image;

@end

@interface HSYEditorController : WPEditorViewController

@property (assign,nonatomic) id<HSYEditorDelegate> hsy_delegate;

@property (copy,nonatomic) HSYErrorMessage errorMessage;

@property (strong,nonatomic) HSYEditorConfiguration * configuration;

@end

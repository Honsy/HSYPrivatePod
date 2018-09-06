//
//  WeexManager.m
//  AFNetworking
//
//  Created by 烽行意志 on 2018/9/6.
//

#import "WeexManager.h"
#import "WeexSDK.h"
#import "WeexController.h"
#import "WXImgLoaderDefaultImpl.h"

@implementation WeexManager

+ (void)setup;
{
    NSURL *url = nil;
    
    NSBundle *bundle = [NSBundle bundleForClass:[WeexManager class]];

//    url = [NSURL URLWithString:[bundle pathForResource:@"bundlejs/index" ofType:@"js"]];
//
//    NSString * entryURL = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"WXEntryBundleURL"];
//    if (entryURL) {
//        if ([entryURL hasPrefix:@"http"]) {
//            url = [NSURL URLWithString:entryURL];
//        } else {
//            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSBundle bundleForClass:self] resourceURL].absoluteString, entryURL]];
//        }
//    }
    
//#ifdef UITEST
//    url = [NSURL URLWithString:UITEST_HOME_URL];
//#endif
    
    [self initWeexSDK];
//    [self loadCustomContainWithScannerWithUrl:url];
}

+ (void)initWeexSDK
{
    [WXAppConfiguration setAppGroup:@"Fxyz"];
    [WXAppConfiguration setAppName:@"CbApp"];
    [WXAppConfiguration setAppVersion:@"1.0"];
    [WXAppConfiguration setExternalUserAgent:@"ExternalUA"];
    
    [WXSDKEngine initSDKEnvironment];
    
    [WXSDKEngine registerHandler:[WXImgLoaderDefaultImpl new] withProtocol:@protocol(WXImgLoaderProtocol)];
    
    
    [WXLog setLogLevel:WXLogLevelAll];

//#ifdef DEBUG
//    [WXLog setLogLevel:WXLogLevelAll];
//#endif
}

+ (void)loadCustomContainWithScannerWithUrl:(NSURL *)url
{
    UIViewController *demo = [[WeexController alloc] init];
    ((WeexController *)demo).url = url;
    [[UIApplication sharedApplication] delegate].window.rootViewController = [[WXRootViewController alloc] initWithRootViewController:demo];
}


@end

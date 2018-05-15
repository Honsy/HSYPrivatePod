//
//  HSYNetworkManager.h
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/10.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


#define HSYWeak  __weak __typeof(self) weakSelf = self

/*! 过期属性或方法名提醒 */
#define HSYNetManagerDeprecated(instead) __deprecated_msg(instead)

/*! 判断是否有网 */
#ifndef kIsHaveNetwork
#define kIsHaveNetwork   [HSYNetManager HSY_isHaveNetwork]
#endif

/*! 判断是否为手机网络 */
#ifndef kIs3GOr4GNetwork
#define kIs3GOr4GNetwork [HSYNetManager HSY_is3GOr4GNetwork]
#endif

/*! 判断是否为WiFi网络 */
#ifndef kIsWiFiNetwork
#define kIsWiFiNetwork   [HSYNetManager HSY_isWiFiNetwork]
#endif

/*! 使用枚举NS_ENUM:区别可判断编译器是否支持新式枚举,支持就使用新的,否则使用旧的 */
typedef NS_ENUM(NSUInteger, HSYNetworkStatus)
{
    /*! 未知网络 */
    HSYNetworkStatusUnknown           = 0,
    /*! 没有网络 */
    HSYNetworkStatusNotReachable,
    /*! 手机 3G/4G 网络 */
    HSYNetworkStatusReachableViaWWAN,
    /*! wifi 网络 */
    HSYNetworkStatusReachableViaWiFi
};
/*！定义请求类型的枚举 */
typedef NS_ENUM(NSUInteger, HSYHttpRequestType)
{
    /*! get请求 */
    HSYHttpRequestTypeGet = 0,
    /*! post请求 */
    HSYHttpRequestTypePost,
    /*! put请求 */
    HSYHttpRequestTypePut,
    /*! delete请求 */
    HSYHttpRequestTypeDelete
};

typedef void(^HSYAFNetworkSuccessBlock)(NSURLSessionDataTask * task, id responseObject);
typedef void(^HSYAFNetworkFailBlock)(NSURLSessionDataTask * task, NSError * error);

//用来防止下拉刷新刷新回调Block
typedef void(^HSYAFNetworkSuccessErrorBLock)(NSURLSessionDataTask * task, id responseObject);

/*! 实时监测网络状态的 block */
typedef void(^HSYNetworkStatusBlock)(HSYNetworkStatus status);

/*! 定义请求成功的 block */
typedef void( ^ HSYResponseSuccess)(id response);
/*! 定义请求失败的 block */
typedef void( ^ HSYResponseFail)(NSError *error);
/*! 定义Code Error */
typedef void( ^ HSYResponseCodeError)(NSString *message);

/*! 定义上传进度 block */
typedef void( ^ HSYUploadProgress)(int64_t bytesProgress,
                                   int64_t totalBytesProgress);
/*! 定义下载进度 block */
typedef void( ^ HSYDownloadProgress)(int64_t bytesProgress,
                                     int64_t totalBytesProgress);

/*!
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask HSYURLSessionTask;



@interface HSYNetworkManager : NSObject

@property (nonatomic, assign) HSYAFNetworkSuccessErrorBLock successErrorBlock;


@property (nonatomic, copy) NSString      * accessToken;

/*! 获取当前网络状态 */
@property (nonatomic, assign) HSYNetworkStatus netWorkStatu;

/*!
 *  获得全局唯一的网络请求实例单例方法
 *
 *  @return 网络请求类HSYNetManager单例
 */
+ (HSYNetworkManager *)sharedNetworkManager;

+ (AFHTTPSessionManager *)sharedAFManager;

#pragma mark - 网络请求的类方法 --- get / post / put / delete
/*!
 *  网络请求方法,block回调
 *
 *  @param type         get / post
 *  @param urlString    请求的地址
 *  @param parameters    请求的参数
 *  @param successBlock 请求成功的回调
 *  @param failureBlock 请求失败的回调
 *  @param progress 进度
 */
+ (HSYURLSessionTask *)HSY_requestWithType:(HSYHttpRequestType)type
                                 urlString:(NSString *)urlString
                                parameters:(NSDictionary *)parameters
                              successBlock:(HSYResponseSuccess)successBlock
                              failureBlock:(HSYResponseFail)failureBlock
                                  progress:(HSYDownloadProgress)progress;

/*!
 *  上传图片(多图)
 *
 *  @param parameters   上传图片预留参数---视具体情况而定 可移除
 *  @param imageArray   上传的图片数组
 *  @param fileName     上传的图片数组fileName
 *  @param urlString    上传的url
 *  @param successBlock 上传成功的回调
 *  @param failureBlock 上传失败的回调
 *  @param progress     上传进度
 */
//+ (HSYURLSessionTask *)HSY_uploadImageWithUrlString:(NSString *)urlString
//                                       parameters:(NSDictionary *)parameters
//                                       imageArray:(NSArray *)imageArray
//                                         fileName:(NSString *)fileName
//                                     successBlock:(HSYResponseSuccess)successBlock
//                                      failurBlock:(HSYResponseFail)failureBlock
//                                   upLoadProgress:(HSYUploadProgress)progress;

/*!
 *  视频上传
 *
 *  @param parameters   上传视频预留参数---视具体情况而定 可移除
 *  @param videoPath    上传视频的本地沙河路径
 *  @param urlString     上传的url
 *  @param successBlock 成功的回调
 *  @param failureBlock 失败的回调
 *  @param progress     上传的进度
 */
+ (void)HSY_uploadVideoWithUrlString:(NSString *)urlString
                          parameters:(NSDictionary *)parameters
                           videoPath:(NSString *)videoPath
                        successBlock:(HSYResponseSuccess)successBlock
                        failureBlock:(HSYResponseFail)failureBlock
                      uploadProgress:(HSYUploadProgress)progress;

/*!
 *  文件下载
 *
 *  @param parameters   文件下载预留参数---视具体情况而定 可移除
 *  @param savePath     下载文件保存路径
 *  @param urlString        请求的url
 *  @param successBlock 下载文件成功的回调
 *  @param failureBlock 下载文件失败的回调
 *  @param progress     下载文件的进度显示
 */
+ (HSYURLSessionTask *)HSY_downLoadFileWithUrlString:(NSString *)urlString
                                          parameters:(NSDictionary *)parameters
                                            savaPath:(NSString *)savePath
                                        successBlock:(HSYResponseSuccess)successBlock
                                        failureBlock:(HSYResponseFail)failureBlock
                                    downLoadProgress:(HSYDownloadProgress)progress;

#pragma mark - 网络状态监测
/*!
 *  开启实时网络状态监测，通过Block回调实时获取(此方法可多次调用)
 */
+ (void)HSY_startNetWorkMonitoringWithBlock:(HSYNetworkStatusBlock)networkStatus;

/*!
 *  是否有网
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)HSY_isHaveNetwork;

/*!
 *  是否是手机网络
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)HSY_is3GOr4GNetwork;

/*!
 *  是否是 WiFi 网络
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)HSY_isWiFiNetwork;

#pragma mark - 取消 Http 请求
/*!
 *  取消所有 Http 请求
 */
+ (void)HSY_cancelAllRequest;

/*!
 *  取消指定 URL 的 Http 请求
 */
+ (void)HSY_cancelRequestWithURL:(NSString *)URL;


/**
 GET请求

 @param URL URL
 @param parameters 参数
 @param successBlock 成功回调
 @param failBlock 失败回调
 @param codeError 错误码失败处理
 @param token token
 */
-(void)GET:(NSString *)URL Parameters:(id)parameters Success:(HSYResponseSuccess)successBlock CodeError:(HSYResponseCodeError)codeError Failure:(HSYResponseFail)failBlock Token:(BOOL)token;

/**
 POST请求
 
 @param URL URL
 @param parameters 参数
 @param successBlock 成功回调
 @param failBlock 失败回调
 @param codeError 错误码失败处理
 @param showLoading 是否显示加载框
 */
-(void)POST:(NSString *)URL Parameters:(id)parameters Success:(HSYResponseSuccess)successBlock CodeError:(HSYResponseCodeError)codeError Failure:(HSYResponseFail)failBlock Token:(BOOL)token;

/**
 POST请求
 
 @param URL URL
 @param parameters 参数
 @param fileName 文件名
 @param imageData 图片字节流
 @param success 成功回调
 @param codeError 错误码失败处理
 @param failure 失败回调
 @param showLoading 是否显示加载框
 */
-(void)POST:(NSString *)URL Parameters:(id)parameters FileName:(NSString *)fileName ImageData:(NSData *)imageData Success:(HSYResponseSuccess)successBlock CodeError:(HSYResponseCodeError)codeError Failure:(HSYResponseFail)failBlock Token:(BOOL)token;

/**
 POST formData上传多张图片
 
 @param URL URL
 @param parameters 参数
 @param fileNames 文件名数组
 @param imageArray 图片数组 <UIImage *>
 @param successBlock 成功回调
 @param failBlock 失败回调
 @param codeError 错误码失败处理
 @param showLoading 是否显示加载框
 @param token Token
 */
-(void)POST:(NSString *)URL Parameters:(id)parameters FileNames:(NSArray *)fileNames ImageArray:(NSArray<UIImage *> *)imageArray Success:(HSYResponseSuccess)successBlock CodeError:(HSYResponseCodeError)codeError Failure:(HSYResponseFail)failBlock  Token:(BOOL)token;

#pragma mark 以下为不包含任何处理结果的网络请求
/**
 POST formData上传图片
 
 @param URL URL
 @param parameters 参数
 @param fileNames 文件名数组
 @param imageArray 图片数组 <UIImage *>
 @param successBlock 成功回调
 @param failBlock 失败回调
 @param token Token
 */
-(void)POSTWithNoHandle:(NSString *)URL Parameters:(id)parameters FileName:(NSString *)fileName ImageData:(NSData *)imageData Success:(HSYResponseSuccess)successBlock Failure:(HSYResponseFail)failBlock Token:(BOOL)token;
@end

//
//  AppDelegate.m
//  rongcloud-ios-imdemo-import
//
//  Created by 张一帆 on 2020/8/7.
//

#import "AppDelegate.h"

#import "RCSConfig.h"
#import "RCSConversationListViewController.h"

#import "RCSInformationMessage.h"

#import <RongIMKit/RongIMKit.h>

@interface AppDelegate () <RCIMReceiveMessageDelegate,RCIMUserInfoDataSource>

@end

@implementation AppDelegate


#pragma mark -- UIApplication
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initRongCloudSDK];

    [self registerMessage];
    
    [self setRongCloudDelegate];

    [self setRootViewController];
    
    [self connectRongCloud];
    
    
    return YES;
}

#pragma mark -- RongCloud
- (void)initRongCloudSDK{
    
    // SDK 的 init 方法。所有 SDK 操作都需要在此之后进行
    // 参考文档：https://docs.rongcloud.cn/v3/views/im/ui/guide/private/setting/init/ios.html
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_APPKEY];
    
    [RCIMClient sharedRCIMClient].logLevel = RC_Log_Level_Info;
}

- (void)connectRongCloud {
    
    // 连接融云服务，需要传入对应的 token。 测试情况 token 可直接在开发者后台获取。
    // 获取 token ：https://developer.rongcloud.cn/apitool/Mw8EsJmV43kZBugTMSAZXg
    // 参考文档：https://docs.rongcloud.cn/v3/views/im/ui/guide/private/connection/connect/ios4.html
    //SDK 在 4.0 版本后修改了连接的 API，所以根据 pod 安装的版本，执行对应的方法
#if SDK_VERSION == 2
    [[RCIM sharedRCIM] connectWithToken:RONGCLOUD_TOKEN success:^(NSString *userId) {
        // 连接成功
    } error:^(RCConnectErrorCode status) {
        // 连接失败
    } tokenIncorrect:^{
        // token 不匹配
    }];
#elif SDK_VERSION == 4 || SDK_VERSION == 5
    [[RCIM sharedRCIM] connectWithToken:RONGCLOUD_TOKEN dbOpened:^(RCDBErrorCode code) {
        
        // 数据库打开
    } success:^(NSString *userId) {
        
        // 连接成功
    } error:^(RCConnectErrorCode errorCode) {
        
        // 连接失败
    }];
#endif
}

- (void)setRongCloudDelegate{
    
    // 设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    
    [RCIM sharedRCIM].userInfoDataSource = self;
}

- (void)registerMessage{
    
    [[RCIM sharedRCIM] registerMessageType:[RCSInformationMessage class]];
}


#pragma mark --RongCloudDelegate
// 消息监听
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    
    NSLog(@"onRCIMReceiveMessage + messageuid:%@ + left:%d",message.messageUId,left);
}


// 获取用户信息
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    
    // 开发者此处可从自己服务器异步获取。 之后利用 completion 返回对用用户信息即可。
    if ([userId isEqual:@"10086"]) {
        
        RCUserInfo *informationUser = [[RCUserInfo alloc] initWithUserId:userId name:@"系统小助手" portrait:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598172881638&di=014c949f50f1855840bbc698cf4d7bb5&imgtype=0&src=http%3A%2F%2Fp9-dy.byteimg.com%2Faweme%2F720x720%2Fc1500084b30927d65e2.jpeg"];
        
        completion(informationUser);
    }
}

#pragma mark -- Custom
- (void)setRootViewController {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    // 设置需要显示的类型和需要聚合的类型
    // 注意：未设置的会话类型不会被显示出来！！！
    RCSConversationListViewController *conversationListViewController = [[RCSConversationListViewController alloc] initWithDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_SYSTEM),@(ConversationType_GROUP)] collectionConversationType:@[@(ConversationType_SYSTEM)]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:conversationListViewController];
    self.window.rootViewController = navigationController;
}





@end

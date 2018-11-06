//
//  HSAppConfigure.m
//  HSAppConfigure
//
//  Created by yuan on 2018/10/17.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import "YSAppConfigure.h"
#import <YYModel/YYModel.h>

#define YSAppConfigInstance [YSAppConfigure shareInstance]

#pragma mark - *********** YSAppConfigModel ***********

@interface YSAppConfigModel : NSObject

//host
@property (nonatomic,copy) NSString *BaseUrl;

//JiGuang
@property (nonatomic,copy) NSString *JiGuang;

//Bugly
@property (nonatomic,copy) NSString *Bugly;

//WeChat
@property (nonatomic,copy) NSString *WeChatAppID;
@property (nonatomic,copy) NSString *WeChatAppSecret;

//QQ
@property (nonatomic,copy) NSString *QQAppID;
@property (nonatomic,copy) NSString *QQAppSecret;

//WeiBo
@property (nonatomic,copy) NSString *WeiBoAppID;
@property (nonatomic,copy) NSString *WeiBoAppSecret;

@property (nonatomic,assign) YSAppConfigureType configType;

@end

@implementation YSAppConfigModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:@"WeChat.AppID"      forKey:@"WeChatAppID"];
    [dic setObject:@"WeChat.AppSecret"  forKey:@"WeChatAppSecret"];
    [dic setObject:@"QQ.AppID"          forKey:@"QQAppID"];
    [dic setObject:@"QQ.AppSecret"      forKey:@"QQAppSecret"];
    [dic setObject:@"WeiBo.AppID"       forKey:@"WeiBoAppID"];
    [dic setObject:@"WeiBo.AppSecret"   forKey:@"WeiBoAppSecret"];
    [dic setObject:@"JiGuang.AppID"     forKey:@"JiGuang"];
    
    YSAppConfigureType type = YSAppConfigure.currentType;
    
    if (type == YSAppConfigureType_debug) {
        [dic setObject:@"BaseUrl.debug"     forKey:@"BaseUrl"];
        [dic setObject:@"Bugly.debug"       forKey:@"Bugly"];
    }else if (type == YSAppConfigureType_test) {
        [dic setObject:@"BaseUrl.test"      forKey:@"BaseUrl"];
        [dic setObject:@"Bugly.debug"       forKey:@"Bugly"];
    }else if (type == YSAppConfigureType_pre) {
        [dic setObject:@"BaseUrl.pre"       forKey:@"BaseUrl"];
        [dic setObject:@"Bugly.debug"       forKey:@"Bugly"];
    }else{
        [dic setObject:@"BaseUrl.release"   forKey:@"BaseUrl"];
        [dic setObject:@"Bugly.release"     forKey:@"Bugly"];
    }
    
    return dic.copy;
}

@end

#pragma mark - *********** HSAppConfigure ***********

@interface YSAppConfigure()

@property (nonatomic,strong) YSAppConfigModel *currentConfigure;

@property (nonatomic,assign) YSAppConfigureType configType;

@end

@implementation YSAppConfigure

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static YSAppConfigure * instance = nil;
    dispatch_once(&onceToken, ^{
        instance = YSAppConfigure.new;
    });
    return instance;
}

+ (void)load{
#if DEBUG
    #if TEST
        [YSAppConfigInstance setUpAppConfigByType:YSAppConfigureType_test];
    #elif PRE
        [YSAppConfigInstance setUpAppConfigByType:YSAppConfigureType_pre];
    #else
        [YSAppConfigInstance setUpAppConfigByType:YSAppConfigureType_debug];
    #endif
#else
    [YSAppConfigInstance setUpAppConfigByType:YSAppConfigureType_release];
#endif
}

#pragma mark - *********** 加载配置 ***********

- (void)setUpAppConfigByType:(YSAppConfigureType)configType{
    
    _configType = configType;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"configure" ofType:@"plist"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    YSAppConfigModel *configure = [YSAppConfigModel yy_modelWithDictionary:dic];
    configure.configType = configType;
    
    _currentConfigure = configure;
    
#if DEBUG
    [self showConfigList];
#endif
    
}

- (void)showConfigList{
    NSLog(@"<<<<<<<<<<<<< %@ >>>>>>>>>>>>>",NSStringFromClass([self class]));
    NSString *typeStr = @"开发环境";
    YSAppConfigureType type = YSAppConfigure.currentType;
    if (type == YSAppConfigureType_test) {
        typeStr = @"测试环境";
    }else if (type == YSAppConfigureType_pre) {
        typeStr = @"预发环境";
    }else if (type == YSAppConfigureType_release) {
        typeStr = @"生产环境";
    }
    NSLog(@"当前是: %@",typeStr);
    NSLog(@"BaseUrl: %@",YSAppConfigure.BaseUrl);
    NSLog(@"JiGuang: %@",YSAppConfigure.JiGuang);
    NSLog(@"Bugly: %@",YSAppConfigure.Bugly);
    NSLog(@"WeChatAppID: %@",YSAppConfigure.WeChatAppID);
    NSLog(@"WeChatAppSecret: %@",YSAppConfigure.WeChatAppSecret);
    NSLog(@"QQAppID: %@",YSAppConfigure.QQAppID);
    NSLog(@"QQAppSecret: %@",YSAppConfigure.QQAppSecret);
    NSLog(@"WeiBoAppID: %@",YSAppConfigure.WeiBoAppID);
    NSLog(@"WeiBoAppSecret: %@",YSAppConfigure.WeiBoAppSecret);
    NSLog(@"<<<<<<<<<<<<< end >>>>>>>>>>>>>\n\n");
}

#pragma mark - *********** 环境 ***********

+ (YSAppConfigureType)currentType{
    return YSAppConfigInstance.configType;
}

#pragma mark - *********** 网络 ***********

+ (NSString *)BaseUrl{
    return YSAppConfigInstance.currentConfigure.BaseUrl;
}

#pragma mark - *********** JiGuang ***********

+ (NSString *)JiGuang{
    return YSAppConfigInstance.currentConfigure.JiGuang;
}

#pragma mark - *********** Bugly ***********

+ (NSString *)Bugly{
    return YSAppConfigInstance.currentConfigure.Bugly;
}

#pragma mark - *********** WeChat ***********

+ (NSString *)WeChatAppID{
    return YSAppConfigInstance.currentConfigure.WeChatAppID;
}

+ (NSString *)WeChatAppSecret{
    return YSAppConfigInstance.currentConfigure.WeChatAppSecret;
}

#pragma mark - *********** QQ ***********

+ (NSString *)QQAppID{
    return YSAppConfigInstance.currentConfigure.QQAppID;
}

+ (NSString *)QQAppSecret{
    return YSAppConfigInstance.currentConfigure.QQAppSecret;
}

#pragma mark - *********** WeiBo ***********

+ (NSString *)WeiBoAppID{
    return YSAppConfigInstance.currentConfigure.WeiBoAppID;
}

+ (NSString *)WeiBoAppSecret{
    return YSAppConfigInstance.currentConfigure.WeiBoAppSecret;
}

@end

//
//  HSAppConfigure.h
//  HSAppConfigure
//
//  Created by yuan on 2018/10/17.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    YSAppConfigureType_debug = 0,   //开发
    YSAppConfigureType_test,        //测试
    YSAppConfigureType_pre,         //预发布
    YSAppConfigureType_release      //生产
} YSAppConfigureType;

@interface YSAppConfigure : NSObject

//host
@property (nonatomic,class,readonly) NSString *BaseUrl;

//JiGuang
@property (nonatomic,class,readonly) NSString *JiGuang;

//Bugly
@property (nonatomic,class,readonly) NSString *Bugly;

//WeChat
@property (nonatomic,class,readonly) NSString *WeChatAppID;
@property (nonatomic,class,readonly) NSString *WeChatAppSecret;

//QQ
@property (nonatomic,class,readonly) NSString *QQAppID;
@property (nonatomic,class,readonly) NSString *QQAppSecret;

//WeiBo
@property (nonatomic,class,readonly) NSString *WeiBoAppID;
@property (nonatomic,class,readonly) NSString *WeiBoAppSecret;

@property (nonatomic,class,readonly) YSAppConfigureType currentType;

+ (instancetype)shareInstance;

- (void)setUpAppConfigByType:(YSAppConfigureType)configType;

@end

NS_ASSUME_NONNULL_END

//
//  YSViewController.m
//  YSAppConfigure
//
//  Created by yuansirios on 11/06/2018.
//  Copyright (c) 2018 yuansirios. All rights reserved.
//

#import "YSViewController.h"

@interface YSViewController ()

@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation YSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *typeStr = @"开发环境";
    YSAppConfigureType type = YSAppConfigure.currentType;
    if (type == YSAppConfigureType_test) {
        typeStr = @"测试环境";
    }else if (type == YSAppConfigureType_pre) {
        typeStr = @"预发环境";
    }else if (type == YSAppConfigureType_release) {
        typeStr = @"生产环境";
    }
    [_label setText:typeStr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

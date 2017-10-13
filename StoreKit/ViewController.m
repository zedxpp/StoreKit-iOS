//
//  ViewController.m
//  StoreKit
//
//  Created by peng on 2017/10/13.
//  Copyright © 2017年 peng. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>

@interface ViewController () <SKStoreProductViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // 判断系统版本号
    NSLog(@"%@", [[NSProcessInfo processInfo] operatingSystemVersionString]);
    NSLog(@"%zd", [[NSProcessInfo processInfo] operatingSystemVersion].majorVersion);
    NSLog(@"%zd", [[NSProcessInfo processInfo] operatingSystemVersion].minorVersion);
    NSLog(@"%zd", [[NSProcessInfo processInfo] operatingSystemVersion].patchVersion);
}

- (IBAction)goStore:(UIButton *)sender {
    // SDK iOS8.0  App内打开商店
    SKStoreProductViewController *vc = [[SKStoreProductViewController alloc] init];
    vc.delegate = self;
    
    __weak typeof(self) weakSelf = self;
    [vc loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"444934666"} completionBlock:^(BOOL result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"result: %d, error: %@", result, error.localizedDescription);
        } else {
            [weakSelf presentViewController:vc animated:YES completion:nil];
        }
    }];
}
- (IBAction)review:(UIButton *)sender {
    // 以下api必须在10.3开始才有, 在按钮阶段就应该判断版本控制按钮显示和隐藏
    NSOperatingSystemVersion v = [NSProcessInfo processInfo].operatingSystemVersion;
    if (v.majorVersion < 10) {
        return;
    } else {
        if (v.majorVersion == 10 && v.minorVersion < 3) {
            return;
        }
    }
    
    [SKStoreReviewController requestReview];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    // 打开商店, 点击完成按钮调用
    [viewController dismissViewControllerAnimated:true completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

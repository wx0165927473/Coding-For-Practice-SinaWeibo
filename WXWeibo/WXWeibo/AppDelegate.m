//
//  AppDelegate.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "AppDelegate.h"
#import "DDMenuController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "SinaWeibo.h"
#import "CONSTS.h"
#import "ThemeManager.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

//初始化微博对象
- (void)_initSinaWeibo {
    _sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:_mainCtrl];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
}

- (void)setTheme {
    NSString *themeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
    [[ThemeManager shareInstance] setThemeName:themeName];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //设置主题
    [self setTheme];
    
    _mainCtrl = [[MainViewController alloc] init];
    LeftViewController *leftCtrl = [[LeftViewController alloc] init];
    RightViewController *rightCtrl = [[RightViewController alloc] init];
    
    //初始化左右菜单
    _menuCtrl = [[DDMenuController alloc] initWithRootViewController:_mainCtrl];
    _menuCtrl.leftViewController = leftCtrl;
    _menuCtrl.rightViewController = rightCtrl;

    //初始化微博对象
    [self _initSinaWeibo];
    
    self.window.rootViewController = _menuCtrl;
    
    return YES;
}

@end

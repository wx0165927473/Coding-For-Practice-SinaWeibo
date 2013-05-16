//
//  AppDelegate.h
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMenuController.h"
#import "MainViewController.h"

@class SinaWeibo;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) SinaWeibo *sinaweibo;
@property (nonatomic,retain) MainViewController *mainCtrl;
@property (nonatomic,retain) DDMenuController *menuCtrl;

@end

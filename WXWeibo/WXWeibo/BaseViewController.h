//
//  BaseViewController.h
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "AppDelegate.h"

@class MBProgressHUD;
@interface BaseViewController : UIViewController {
    UIWindow *_tipWindow;
}

@property(nonatomic,assign)BOOL isBackButton; //navigation 返回
@property(nonatomic,assign)BOOL isCancelButton; //modal视图 取消
@property(nonatomic,retain)MBProgressHUD *hud;

- (SinaWeibo *)sinaweibo;
//获取appDelegate
- (AppDelegate *)appDelegate;

//显示加载提示
- (void)showHUD:(NSString *)title isDim:(BOOL)isDim;
//显示加载完成提示
- (void)showHUDComplete:(NSString *)title;
//隐藏加载提示
- (void)hideHUD;
//状态栏提示
- (void)showStatusTip:(BOOL)show title:(NSString *)title;

@end

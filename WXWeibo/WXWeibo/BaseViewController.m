//
//  BaseViewController.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import "UIFactory.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isBackButton = YES;
        self.isCancelButton = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1 && self.isBackButton) {
        UIButton *button = [UIFactory createButton:@"navigationbar_back.png" highlighted:@"navigationbar_back_highlighted.png"];
        button.frame = CGRectMake(0, 0, 24, 24);
        button.showsTouchWhenHighlighted = YES;
        [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = [backItem autorelease];
    }
    
    if (self.isCancelButton) {
        UIButton *cancelButton = [UIFactory createNavigationButton:CGRectMake(0, 0, 45, 30) title:@"取消" target:self action:@selector(cancelAction)];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
        self.navigationItem.leftBarButtonItem = [cancelItem autorelease];
    }
}

- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

//override
//设置导航栏上的标题
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    titleLabel.textColor = [UIColor blackColor];
    UILabel *titleLabel = [UIFactory createLabel:kNavigationBarTitleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
}

- (SinaWeibo *)sinaweibo {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaweibo = appDelegate.sinaweibo;
    return sinaweibo;
}

- (AppDelegate *)appDelegate {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate;
}
#pragma mark - loading tips 加载提示
//显示加载提示
- (void)showHUD:(NSString *)title isDim:(BOOL)isDim {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = title;
    self.hud.dimBackground = isDim;
}
//显示加载完成提示
- (void)showHUDComplete:(NSString *)title {
    self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.labelText = title;
}
//隐藏加载提示
- (void)hideHUD {
    [self.hud hide:YES];
}

//状态栏提示
- (void)showStatusTip:(BOOL)show title:(NSString *)title {
    if (_tipWindow == nil) {
        _tipWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        _tipWindow.windowLevel = UIWindowLevelStatusBar;
        _tipWindow.backgroundColor = [UIColor blackColor];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = [UIFont systemFontOfSize:13.0];
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.tag = 2013;
        [_tipWindow addSubview:tipLabel];
        
        UIImageView *progess = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"queue_statusbar_progress.png"]];
        progess.frame = CGRectMake(0, 14, 100, 6);
        progess.tag = 2014;
        [_tipWindow addSubview:progess];
    }
    
    UILabel *tipLabel = (UILabel *)[_tipWindow viewWithTag:2013];
    UIImageView *progess = (UIImageView *)[_tipWindow viewWithTag:2014];
    if (show) {
        tipLabel.text = title;
        _tipWindow.hidden = NO;
        
        progess.left = -100;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:2];
        [UIView setAnimationRepeatCount:1000];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        progess.left = ScreenWidth;
        [UIView commitAnimations];
    }else {
        progess.hidden = YES;
        tipLabel.text = title;
        [self performSelector:@selector(removeTipWindow) withObject:nil afterDelay:1.5];
    }
}

- (void)removeTipWindow {
    _tipWindow.hidden = YES;
    
    [_tipWindow release];
    _tipWindow = nil;
}

@end

//
//  MainViewController.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationController.h"
#import "UIFactory.h"
#import "ThemeButton.h"
#import "AppDelegate.h"
#import "UserViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _initViewController];
    [self _initTabbarView];
    
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UI
//初始化子控制器
- (void)_initViewController {
    _homeCtrl = [[[HomeViewController alloc] init] autorelease];
    MessageViewController *message = [[[MessageViewController alloc] init] autorelease];
    UserViewController *profile = [[[UserViewController alloc] init] autorelease];
    DiscoverViewController *discover = [[[DiscoverViewController alloc] init] autorelease];
    MoreViewController *more = [[[MoreViewController alloc] init] autorelease];
    
    profile.isLoginUser = YES;
    
    NSArray *views = @[_homeCtrl,message,profile,discover,more];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewController in views) {
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:viewController];
        [viewControllers addObject:nav];
        [nav release];
        
        nav.delegate = self;
    }
    
    self.viewControllers = viewControllers;
}

//创建自定义tabBar
- (void)_initTabbarView {
    _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-49-20, ScreenWidth, 49)];
//    _tabbarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    [self.view addSubview:_tabbarView];
    
    UIImageView *tabbarGroundImage = [UIFactory createImageView:@"tabbar_background.png"];
    tabbarGroundImage.frame = _tabbarView.bounds;
    [_tabbarView addSubview:tabbarGroundImage];
    
    NSArray *backgroud = @[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    
    NSArray *heightBackground = @[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png"];
    
    for (int i=0; i<backgroud.count; i++) {
        NSString *backImage = backgroud[i];
        NSString *heightImage = heightBackground[i];
        
//        ThemeButton *button = [[ThemeButton alloc] initWithImage:backImage highlighted:heightImage];
        UIButton *button = [UIFactory createButton:backImage highlighted:heightImage];
        button.frame = CGRectMake((64-30)/2+(i*64), (49-30)/2, 30, 30);
        button.tag = i;
        button.showsTouchWhenHighlighted = YES;
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbarView addSubview:button];
    }
    
    _sliderView = [[UIFactory createImageView:@"tabbar_slider.png"] retain];
    _sliderView.backgroundColor = [UIColor clearColor];
    _sliderView.frame = CGRectMake((64-15)/2, 5, 15, 44);
    [_tabbarView addSubview:_sliderView];
}

- (void)_resizeView:(BOOL)show {
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            if (show) {
                subView.height = ScreenHeight-49-20;
            }else {
                subView.height = ScreenHeight-20;
            }
        }
    }
}

//显示/隐藏未读数
- (void)showBadge:(BOOL)show {
    _badgeView.hidden = !show;
}

//是否隐藏tabbar
- (void)showTabbar:(BOOL)show {
    [UIView animateWithDuration:0.35 animations:^{
        if (show) {
            _tabbarView.left = 0;
        }else {
            _tabbarView.left = -ScreenWidth;
        }
    }];
    
    [self _resizeView:show];
}

#pragma mark - Load data
- (void)loadUnreadData {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaweibo = appDelegate.sinaweibo;
    [sinaweibo requestWithURL:@"remind/unread_count.json" params:nil httpMethod:@"GET" delegate:self];
}

#pragma mark - SinaWeiboRequest delegate 显示未读数
//显示未读数
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    //新浪未读数
    NSNumber *status = [result objectForKey:@"status"];
    
    if (_badgeView == nil) {
        _badgeView = [UIFactory createImageView:@"main_badge.png"];
        _badgeView.frame = CGRectMake(64-25, 5, 22, 22);
        [_tabbarView addSubview:_badgeView];
        
        UILabel *badgeLabel = [[UILabel alloc] initWithFrame:_badgeView.bounds];
        badgeLabel.textAlignment = NSTextAlignmentCenter;
        badgeLabel.backgroundColor = [UIColor clearColor];
        badgeLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        badgeLabel.textColor = [UIColor purpleColor];
        badgeLabel.tag = 202;
        [_badgeView addSubview:badgeLabel];
        [badgeLabel release];
    }
    
    int n = [status intValue];
    if (n>0) {
        UILabel *badgeLabel = (UILabel *)[_badgeView viewWithTag:202];
        if (n>99) {
            n=99;
        }
        badgeLabel.text = [NSString stringWithFormat:@"%d",n];
        _badgeView.hidden = NO;
    }else {
        _badgeView.hidden = YES;
    }
}

#pragma mark - actions
//tab 按钮的点击事件
- (void)selectedTab:(UIButton *)button {
    
    float x = button.left + (button.width-_sliderView.width)/2;
    [UIView animateWithDuration:0.2 animations:^{
        _sliderView.left = x;
    }];
    
    //判断是否是重复点击tab按钮
    if (button.tag == self.selectedIndex && button.tag == 0) {
        [_homeCtrl autorefreshWeibo];
    }
    
    self.selectedIndex = button.tag;
}

- (void)timeAction:(NSTimer *)timer {
    [self loadUnreadData];
}

#pragma mark - SinaWeibo delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo {
    //保存认证的数据到本地
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_homeCtrl loadWeiboData];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo {
    //移除认证的数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注销成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo {
    NSLog(@"sinaweiboLogInDidCancel");    
}

#pragma mark - UINavigationController delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //导航控制器子控制器的个数
    int count = navigationController.viewControllers.count;
    
    if (count == 1) {
        [self showTabbar:YES];
    }else if (count == 2) {
        [self showTabbar:NO];
    }
}


@end

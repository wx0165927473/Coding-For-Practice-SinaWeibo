//
//  HomeViewController.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboModel.h"
#import "UIFactory.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MainViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"微博";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //绑定按钮
    UIBarButtonItem *bindItem = [[UIBarButtonItem alloc] initWithTitle:@"绑定账号" style:UIBarButtonItemStyleBordered target:self action:@selector(bindAction:)];
    self.navigationItem.rightBarButtonItem = [bindItem autorelease];
    
    //注销按钮
    UIBarButtonItem *logoutItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutAction:)];
    self.navigationItem.leftBarButtonItem = [logoutItem autorelease];
    
    //创建tableView
    _tableView = [[WeiboTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49-20-44) style:UITableViewStylePlain];
    _tableView.eventDelegate = self;
    [self.view addSubview:_tableView];
    
    //判断是否认证
    if (self.sinaweibo.isAuthValid) {
        //加载微博列表数据
        [self loadWeiboData];
    } else {
        [self.sinaweibo logIn];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //开启右滑手势
    [self.appDelegate.menuCtrl setEnableGesture:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //禁用右滑手势
    [self.appDelegate.menuCtrl setEnableGesture:NO];
}

#pragma mark - UI
- (void)showNewWeiboCount:(int)count {
    if (barView == nil) {
        barView = [[UIFactory createImageView:@"timeline_new_status_background.png"] retain];
        UIImage *image = [barView.image stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        barView.image = image;
        barView.topCapHeight = 5;
        barView.leftCapWidth = 5;
        barView.frame = CGRectMake(5, -40, ScreenWidth-10, 40);
        [self.view addSubview:barView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.tag = 201;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:16.0f];
        [barView addSubview:label];
        [label release];
    }
    
    if (count>0) {
        UILabel *label = (UILabel *)[barView viewWithTag:201];
        label.text = [NSString stringWithFormat:@"%d条新微博",count];
        [label sizeToFit];
        label.origin = CGPointMake((barView.width-label.width)/2, (barView.height-label.height)/2);
        
        [UIView animateWithDuration:0.6 animations:^{
            barView.top = 5;
        } completion:^(BOOL finished) {
            if (finished) {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDelay:1];
                [UIView setAnimationDuration:0.6];
                barView.top = -40;
                [UIView commitAnimations];
            }
        }];
        
        //播放提示声音
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:filePath];
        
        CFURLRef CFUrl = (CFURLRef)url;
        SystemSoundID soundId;
        AudioServicesCreateSystemSoundID(CFUrl, &soundId);
        AudioServicesPlaySystemSound(soundId);
    }

        //双击首页图表 隐藏未读图标
        MainViewController *mainCtrl = (MainViewController *)self.tabBarController;
        [mainCtrl showBadge:NO];
}

#pragma mark - SinaWeiboRequest delegate & load Data
// load Data
- (void)loadWeiboData {
    
    //显示加载提示
    [super showHUD:@"正在加载..请耐心等候" isDim:YES];
    self.tableView.hidden = YES;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"20" forKey:@"count"];
    _request = [self.sinaweibo requestWithURL:@"statuses/home_timeline.json"
                                       params:params
                                   httpMethod:@"GET"
                                     delegate:self];
    _request.tag = 101;//首次加载tag 101
}

// SinaWeiboRequest delegate
//网络加载失败
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"网络加载失败:%@",error);
}

//网络加载完成
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    
    //隐藏加载提示
    [super hideHUD];
    self.tableView.hidden = NO;
    
    if (_request.tag == 101) {
        NSArray *statues = [result objectForKey:@"statuses"];
        NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
        for (NSDictionary *statuesDic in statues) {
            WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
            [weibos addObject:weibo];
            [weibo release];
            self.tableView.data = weibos;
            self.weibos = weibos;
        }
        
        if (weibos.count>0) {
            WeiboModel *topWeibo = [weibos objectAtIndex:0];
            WeiboModel *lastWeibo = [weibos lastObject];
            self.topWeiboId = [topWeibo.weiboId stringValue];
            self.lastWeiboId = [lastWeibo.weiboId stringValue];
        }
        
        if (statues.count >= 20) {
            self.tableView.isMore = YES;
        } else {
            self.tableView.isMore = NO;
        }

        //刷新tableView
        [self.tableView reloadData];
    }
    
    if (_request.tag == 102) {
        NSArray *statues = [result objectForKey:@"statuses"];
        NSMutableArray *refreshWeibos = [NSMutableArray arrayWithCapacity:statues.count];
        for (NSDictionary *statuesDic in statues) {
            WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
            [refreshWeibos addObject:weibo];
            [weibo release];
        }
        
        [refreshWeibos addObjectsFromArray:self.weibos];
        //刷新完数据..再次赋给weibos..下次刷新接着加再weibos前面
        self.tableView.data = refreshWeibos;
        
        //更新topID
        if (refreshWeibos.count>0) {
            WeiboModel *topWeibo = [refreshWeibos objectAtIndex:0];
            self.topWeiboId = [topWeibo.weiboId stringValue];
        }
        
        //刷新tableView
        [self.tableView reloadData];
        [self.tableView doneLoadingTableViewData];
        
        //显示更新微博的数目
        int updateCount = [statues count];
        [self showNewWeiboCount:updateCount];
    }
    
    if (_request.tag == 103) {
        NSArray *statues = [result objectForKey:@"statuses"];
        NSMutableArray *lastWeibos = [NSMutableArray arrayWithCapacity:statues.count];
        for (NSDictionary *statuesDic in statues) {
            WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
            [lastWeibos addObject:weibo];
            [weibo release];
        }
        
        //刷新完数据..再次赋给weibos..下次刷新接着加在weibos前面
        self.tableView.data = self.weibos;
        
        //更新lastID
        if (lastWeibos.count>0) {
            WeiboModel *lastWeibo = [lastWeibos lastObject];
            self.lastWeiboId = [lastWeibo.weiboId stringValue];
            
            [lastWeibos removeObjectAtIndex:0];
        }
        if (statues.count >= 20) {
            self.tableView.isMore = YES;
        }else {
            self.tableView.isMore = NO;
        }
        
        [self.weibos addObjectsFromArray:lastWeibos];
        //刷新tableView
        [self.tableView reloadData];
    }
    
}

//自动刷新
- (void)autorefreshWeibo {
    //UI自动下拉
    [self.tableView autoRefreshData];
    
    //取数据
    [self pullDownData];
}

#pragma mark - UITableViewEvent delegate 自写的
//下拉
- (void)pullDown:(BaseTableView *)tableView {
    [self pullDownData];//加载网络数据
}

- (void)pullDownData {
    
    if (self.topWeiboId == 0) {
        NSLog(@"微博Id为空");
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.topWeiboId forKey:@"since_id"];
    _request = [self.sinaweibo requestWithURL:@"statuses/home_timeline.json"
                                       params:params
                                   httpMethod:@"GET"
                                     delegate:self];
    _request.tag = 102;//下拉加载tag 102
}
//上拉
- (void)pullUp:(BaseTableView *)tableView {
    [self pullUpData];
}

- (void)pullUpData {
    if (self.lastWeiboId == 0) {
        NSLog(@"微博Id为空");
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.lastWeiboId forKey:@"max_id"];
    _request = [self.sinaweibo requestWithURL:@"statuses/home_timeline.json"
                                       params:params
                                   httpMethod:@"GET"
                                     delegate:self];
    _request.tag = 103;//上拉加载tag 103
}

#pragma mark - actions
- (void)bindAction:(UIBarButtonItem *)buttonItem {
    [self.sinaweibo logIn];
}

- (void)logoutAction:(UIBarButtonItem *)buttonItem {
    [self.sinaweibo logOut];
}

#pragma mark - Memery Manager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}

@end

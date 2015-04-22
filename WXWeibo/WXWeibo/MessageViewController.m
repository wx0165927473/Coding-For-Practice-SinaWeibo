#import "MessageViewController.h"
#import "UIFactory.h"
#import "WeiboModel.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)initViews {
    NSArray *messageButtons = [NSArray arrayWithObjects:@"navigationbar_mentions.png",
                                                        @"navigationbar_comments.png",
                                                        @"navigationbar_messages.png",
                                                        @"navigationbar_notice.png",
                                                        nil];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    for (int i=0; i<messageButtons.count; i++) {
        NSString *imageName = [messageButtons objectAtIndex:i];
        UIButton *button = [UIFactory createButton:imageName highlighted:imageName];
        button.tag = 100 + i;
        button.frame = CGRectMake(50*i+20, 10, 22, 22);
        button.showsTouchWhenHighlighted = YES;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
    }
    
    self.navigationItem.titleView = [titleView autorelease];
}
     
#pragma mark - Action
- (void)buttonAction:(UIButton *)button {
    if (button.tag == 100) {
        //显示@微博
        [self showAtWeibo];
    }
    else if (button.tag == 101) {
        
    }
    else if (button.tag == 102) {
        
    }
    else if (button.tag == 103) {
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];
    //创建tableView
    _tableView = [[WeiboTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49-20-44) style:UITableViewStylePlain];
    _tableView.eventDelegate = self;
    [self.view addSubview:_tableView];
}

//显示最新@微博
- (void)showAtWeibo {
    [self loadWeiboData];
}

#pragma mark - SinaWeiboRequest delegate & load Data
// load Data
- (void)loadWeiboData {
    
    //显示加载提示
    [super showHUD:@"正在加载..请耐心等候" isDim:YES];
    self.tableView.hidden = YES;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"20" forKey:@"count"];
    _request = [self.sinaweibo requestWithURL:@"statuses/mentions.json"
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
    _request = [self.sinaweibo requestWithURL:@"statuses/mentions.json"
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
    _request = [self.sinaweibo requestWithURL:@"statuses/mentions.json"
                                       params:params
                                   httpMethod:@"GET"
                                     delegate:self];
    _request.tag = 103;//上拉加载tag 103
}


- (void)dealloc {
    [super dealloc];
}
@end

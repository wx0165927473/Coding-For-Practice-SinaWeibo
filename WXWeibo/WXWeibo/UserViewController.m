#import "UserViewController.h"
#import "UIFactory.h"
#import "UserModel.h"
#import "WeiboModel.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人资料";
    
    if (self.isLoginUser) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
        self.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
    self.userInfo = [[[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)] autorelease];
    
    UIButton *homeButton = [UIFactory createButtonWithBackground:@"tabbar_home.png" backgroundHighlighted:@"tabbar_home_highlighted.png"];
    homeButton.frame = CGRectMake(0, 0, 34, 27);
    [homeButton addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *homeItem = [[UIBarButtonItem alloc] initWithCustomView:homeButton];
    self.navigationItem.rightBarButtonItem = [homeItem autorelease];
    
    [self loadUserData];
    [self loadWeiboData];
}

#pragma mark - data
- (void)loadUserData {
    if(self.userName.length == 0 && self.userID.length == 0) {
        NSLog(@"error:用户为空");
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.userID.length != 0) {
        [params setObject:self.userID forKey:@"uid"];
    }else {
        [params setObject:self.userName forKey:@"screen_name"];
    }
    
    _request = [self.sinaweibo requestWithURL:@"users/show.json"
                                       params:params
                                   httpMethod:@"GET"
                                     delegate:self];
}

- (void)loadWeiboData {
    if(self.userName.length == 0 && self.userID.length == 0) {
        NSLog(@"error:用户为空");
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.userID.length != 0) {
        [params setObject:self.userID forKey:@"uid"];
    }else {
        [params setObject:self.userName forKey:@"screen_name"];
    }
    _request = [self.sinaweibo requestWithURL:@"statuses/user_timeline.json"
                                       params:params
                                   httpMethod:@"GET"
                                     delegate:self];
}

#pragma mark - SinaWeiboRequest delegate 
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    //获取用户资料

        self.userInfo.userModel = [[UserModel alloc] initWithDataDic:result];
        [self refreshUI];

    
    //获取用户微博
        NSArray *statues = [result objectForKey:@"statuses"];
        NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
        for (NSDictionary *statuesDic in statues) {
            WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
            [weibos addObject:weibo];
            [weibo release];
        }
        
        if (statues.count >= 20) {
            self.tableView.isMore = YES;
        } else {
            self.tableView.isMore = NO;
        }
        
        self.tableView.data = weibos;
        
        //刷新tableView
        [self.tableView reloadData];
    
    
}

#pragma mark - actions
- (void)goHome {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UI
- (void)refreshUI {
    self.tableView.tableHeaderView = _userInfo;
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}

@end

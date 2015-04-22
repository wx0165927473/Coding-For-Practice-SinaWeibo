#import "BaseViewController.h"
#import "WeiboTableView.h"

@class ThemeImageView;
@interface HomeViewController : BaseViewController<UITableViewEventDelegate,SinaWeiboRequestDelegate> {
    ThemeImageView *barView;
}

@property (retain, nonatomic) WeiboTableView *tableView;
@property (nonatomic,retain)  SinaWeiboRequest *request;
@property (nonatomic,copy) NSString *topWeiboId;
@property (nonatomic,copy) NSString *lastWeiboId;
@property (nonatomic,retain) NSMutableArray *weibos;

//自动刷新微博
- (void)autorefreshWeibo;

//登陆完刷新微博
- (void)loadWeiboData;

@end

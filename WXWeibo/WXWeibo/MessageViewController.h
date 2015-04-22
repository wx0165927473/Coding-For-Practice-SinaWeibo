#import "BaseViewController.h"
#import "WeiboTableView.h"

@interface MessageViewController : BaseViewController <UITableViewEventDelegate,SinaWeiboRequestDelegate>

@property (retain, nonatomic) WeiboTableView *tableView;
@property (nonatomic,retain)  SinaWeiboRequest *request;
@property (nonatomic,copy) NSString *topWeiboId;
@property (nonatomic,copy) NSString *lastWeiboId;
@property (nonatomic,retain) NSMutableArray *weibos;
@end

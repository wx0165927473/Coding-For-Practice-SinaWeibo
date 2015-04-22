#import "BaseViewController.h"
#import "WeiboTableView.h"
@class WeiboModel;
@interface TopicViewController : BaseViewController <SinaWeiboRequestDelegate>

@property (copy, nonatomic) NSString *topicName;
@property (retain, nonatomic) WeiboModel *weiboModel;
@property (retain, nonatomic) IBOutlet WeiboTableView *tableView;
@end

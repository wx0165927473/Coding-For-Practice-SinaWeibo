#import "BaseViewController.h"

@interface MoreViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

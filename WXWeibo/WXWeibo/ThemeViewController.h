#import "BaseViewController.h"

@interface ThemeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *themes;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@end

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>

typedef void (^SelectDoneBlock)(NSDictionary *);

@interface NearByViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,SinaWeiboRequestDelegate>

@property (retain, nonatomic) NSArray *data;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) SelectDoneBlock selectBlock;
@end

#import "BaseViewController.h"

@interface DiscoverViewController : BaseViewController

@property (retain, nonatomic) IBOutlet UIButton *nearWeibo;
@property (retain, nonatomic) IBOutlet UIButton *nearPeople;
- (IBAction)nearWeiboAction:(id)sender;

- (IBAction)nearPeopleAction:(id)sender;
@end

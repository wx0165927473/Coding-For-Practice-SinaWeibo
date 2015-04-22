#import "RightViewController.h"
#import "SendViewController.h"
#import "BaseNavigationController.h"

@interface RightViewController ()

@end

@implementation RightViewController

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
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (IBAction)sendAction:(UIButton *)sender {
    if (sender.tag == 101) {
        SendViewController *sendVC = [[SendViewController alloc] init];
        BaseNavigationController *sendNav = [[BaseNavigationController alloc] initWithRootViewController:sendVC];
        [self.appDelegate.menuCtrl presentViewController:sendNav animated:YES completion:^{
            
        }];
        [sendNav release];
        [sendVC release];
    }
    
    if (sender.tag == 102) {
        SendViewController *sendVC = [[SendViewController alloc] init];
        BaseNavigationController *sendNav = [[BaseNavigationController alloc] initWithRootViewController:sendVC];
        [self.appDelegate.menuCtrl presentViewController:sendNav animated:YES completion:^{
            
        }];
        [sendVC selectImage];
        [sendNav release];
        [sendVC release];
    }
}

@end

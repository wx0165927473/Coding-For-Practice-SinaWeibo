#import "DiscoverViewController.h"
#import "NearWeiboMapViewController.h"
#import "NearUserViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"广场";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    for (int i=100; i<=101; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        button.layer.shadowColor = [UIColor blackColor].CGColor;
        button.layer.shadowOffset = CGSizeMake(3, 3);
        button.layer.shadowOpacity = 1;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_nearWeibo release];
    [_nearPeople release];
    [super dealloc];
}
- (IBAction)nearWeiboAction:(id)sender {
    NearWeiboMapViewController *nearByMapVC = [[NearWeiboMapViewController alloc] init];
    [self.navigationController pushViewController:nearByMapVC animated:YES];
    [nearByMapVC release];
}

- (IBAction)nearPeopleAction:(id)sender {
    NearUserViewController *nearByUserVC = [[NearUserViewController alloc] init];
    [self.navigationController pushViewController:nearByUserVC animated:YES];
    [nearByUserVC release];
}
@end

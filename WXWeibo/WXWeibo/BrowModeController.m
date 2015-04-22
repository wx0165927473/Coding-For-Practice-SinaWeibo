#import "BrowModeController.h"

@interface BrowModeController ()

@end

@implementation BrowModeController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"图片浏览模式";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"大图";
        cell.detailTextLabel.text = @"所有网络加载大图";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"小图";
        cell.detailTextLabel.text = @"所有网络加载小图";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int mode = -1;
    if (indexPath.row == 0) {
        mode = LargeBrowMode;
    }else if (indexPath.row == 1) {
        mode = SmallBrowMode;
    }
    
    //将浏览模式存储到本地
    [[NSUserDefaults standardUserDefaults] setInteger:mode forKey:kBrowMode];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //发送刷新微博列表通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kReloadWeiboTableNotification object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

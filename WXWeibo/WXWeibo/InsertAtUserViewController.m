#import "InsertAtUserViewController.h"
#import "AtUserCell.h"

@interface InsertAtUserViewController ()

@end

@implementation InsertAtUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _users = [[NSMutableArray alloc] init];
        _userImage = [[UIImageView alloc] init];
        self.title = @"@用户";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    [self loadData];
}

#pragma mark - data
- (void)loadData {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1068202327",@"uid",nil];
    [self.sinaweibo requestWithURL:@"friendships/friends.json" params:params httpMethod:@"GET" delegate:self];
}

#pragma mark - SinaWeiboRequest delegate
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    NSArray *array = [result objectForKey:@"users"];
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        UserModel *user = [[UserModel alloc] initWithDataDic:dic];
        [_users addObject:user];
        [user release];
    }
    
    [self.tablieView reloadData];
}

- (void)dealloc {
    [_tablieView release];
    [_searchBar release];
    [super dealloc];
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentify = @"cell";
    AtUserCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell == nil) {
        cell = [[[AtUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify] autorelease];
        UserModel *userModel = [_users objectAtIndex:indexPath.row];
        cell.userModel = userModel;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AtUserCell *cell = (AtUserCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString *selectTopic = cell.nickLabel.text;
    [self dismissViewControllerAnimated:YES completion:NULL];
    _block(selectTopic);
    Block_release(_block);
    _block = nil;
}



#pragma mark - Action
- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end

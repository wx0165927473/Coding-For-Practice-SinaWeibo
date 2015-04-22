#import "WeiboTableView.h"
#import "WeiboCell.h"
#import "WeiboModel.h"
#import "WeiboView.h"
#import "DetailViewController.h"

@implementation WeiboTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kReloadWeiboTableNotification object:nil];
    }
    return self;
}

#pragma mark - UITableView delegate
//父类已经实现。。没必要重写
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.data.count;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"WeiboCell";
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
    }
    
    WeiboModel *weibo = [self.data objectAtIndex:indexPath.row];
    cell.weiboModel = weibo;
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboModel *weibo = [self.data objectAtIndex:indexPath.row];
    float height = [WeiboView getWeiboViewHeight:weibo isRepost:NO isDetail:NO];
    
    height += 60;
    
    return height;
}

//选中
- (void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboModel *weibo = [self.data objectAtIndex:indexPath.row];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.weiboModel = weibo;
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
    
    //取消选中cell
    [self deselectRowAtIndexPath:indexPath animated:NO];
}

@end

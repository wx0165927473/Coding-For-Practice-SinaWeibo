#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initView];
    }
    return self;
}

#pragma mark - UI
//如果使用nib文件创建
- (void)awakeFromNib {
    [self _initView];
}

- (void)_initView {
    
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    _refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    self.delegate = self;
    self.dataSource = self;
    self.refreshHeader = YES;
    
    _moreButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    _moreButton.frame = CGRectMake(0, 0, ScreenWidth, 40);
    _moreButton.backgroundColor = [UIColor clearColor];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [_moreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
    [_moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(loadMoreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.tag = 2013;
    indicatorView.frame = CGRectMake(100, 10, 20, 20);
    [indicatorView stopAnimating];
    [_moreButton addSubview:indicatorView];
    
    self.tableFooterView = _moreButton;
}

- (void)setRefreshHeader:(BOOL)refreshHeader {
    _refreshHeader = refreshHeader;
    if (_refreshHeader) {
        [self addSubview:_refreshHeaderView];
    }else {
        if ([_refreshHeaderView superview]) {
            [_refreshHeaderView removeFromSuperview];
        }
    }
}

#pragma mark - Action
- (void)loadMoreAction {
    if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
        [self.eventDelegate pullUp:self];
        [self _startLoadMore];
    }
}

- (void)_startLoadMore {
    [_moreButton setTitle:@"正在加载..." forState:UIControlStateNormal];
    _moreButton.enabled = NO;
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[_moreButton viewWithTag:2013];
    [indicatorView startAnimating];
}

- (void)_stopLoadMore {
    if (self.data.count > 0 ) {
         _moreButton.hidden = NO;
        [_moreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
        _moreButton.enabled = YES;
        UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[_moreButton viewWithTag:2013];
        [indicatorView stopAnimating];
        
        if (!self.isMore) {
            [_moreButton setTitle:@"到底啦..." forState:UIControlStateNormal];
            _moreButton.enabled = NO;
        }
    } else {
        _moreButton.hidden = YES;
    }
}

- (void)reloadData {
    [super reloadData];
    
    [self _stopLoadMore];
}

#pragma mark tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    return cell;
}

#pragma mark - 以下是 下拉刷新 相关 delegate
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}

- (void)autoRefreshData {
    [_refreshHeaderView initLoading:self];
}

#pragma mark UIScrollViewDelegate Methods
//当滑动时，调用此方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

//手指停止拖拽的时候调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
    if (!self.isMore) {
        return;
    }
    
    float sub = scrollView.contentSize.height - scrollView.contentOffset.y;
    if (scrollView.height - sub >30) {
        
        [self _startLoadMore];
        
        if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
            [self.eventDelegate pullUp:self];
        }
    }
	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.eventDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.eventDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}


#pragma mark EGORefreshTableHeaderDelegate Methods
//下拉到一定距离，手指放开时调用
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	//设置为正在加载的状态
	[self reloadTableViewDataSource];
    
    //停止加载，弹回下拉
//	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    if ([self.eventDelegate respondsToSelector:@selector(pullDown:)]) {
        [self.eventDelegate pullDown:self];
    }
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading;
	
}

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date];
	
}


@end

//
//  BaseTableView.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-1.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@class BaseTableView;
@protocol UITableViewEventDelegate <NSObject>
//下拉
- (void)pullDown:(BaseTableView *)tableView;
//上拉
- (void)pullUp:(BaseTableView *)tableView;
//选中
- (void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BaseTableView : UITableView <EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate> {
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    UIButton *_moreButton; //下拉刷新
}

@property (nonatomic,assign)BOOL refreshHeader; //是否需要下拉刷新
@property (nonatomic,retain)NSArray *data;      //为tableView提供数据
@property (nonatomic,assign)id<UITableViewEventDelegate> eventDelegate;
@property (nonatomic,assign)BOOL isMore;        //是否还有更多 下一页

- (void)doneLoadingTableViewData;

//自动下拉刷新
- (void)autoRefreshData;
@end

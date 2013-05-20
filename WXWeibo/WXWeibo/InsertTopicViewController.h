//
//  InsertTopicViewController.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-18.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

typedef void (^SelectTopicBlock)(NSString *);

#import "BaseViewController.h"

@interface InsertTopicViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,SinaWeiboRequestDelegate> {
    NSMutableArray *_usedTopic;
    NSMutableArray *_hotTopic;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;
@property (copy, nonatomic) SelectTopicBlock block;


@end

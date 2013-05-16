//
//  FriendShipsViewController.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-16.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import "FriendShipsTableView.h"
@interface FriendShipsViewController : BaseViewController <SinaWeiboRequestDelegate,UITableViewEventDelegate>

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, retain) NSMutableArray *data; //装的数组["用户1","用户2","用户3"]
@property (nonatomic, assign) BOOL isFriends;
@property (nonatomic, copy) NSString *cursor;

@property (retain, nonatomic) IBOutlet FriendShipsTableView *tableView;
@end

//
//  FriendShipsViewController.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-16.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "FriendShipsViewController.h"
#import "UserModel.h"

@interface FriendShipsViewController ()

@end

@implementation FriendShipsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data = [NSMutableArray array];
    
    if (self.isFriends) {
        self.title = @"关注数";
    }else {
        self.title = @"粉丝数";
    }
    self.tableView.eventDelegate = self;
    [self loadAtData];
}

- (void)loadAtData {
    if (self.userID.length == 0) {
        NSLog(@"用户ID为空");
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.userID forKey:@"uid"];
    
    if (self.cursor.length > 0) {
        [params setObject:self.cursor forKey:@"cursor"];
    }
    
    if (self.isFriends) {
        [self.sinaweibo requestWithURL:@"friendships/friends.json" params:params httpMethod:@"GET" delegate:self];
    }else {
        [self.sinaweibo requestWithURL:@"friendships/followers.json" params:params httpMethod:@"GET" delegate:self];
    }
}

/*
 * [
        ["用户1","用户2","用户3"],
        ["用户1","用户2","用户3"],
        ["用户1","用户2","用户3"],...
    ];
*/
#pragma mark - SinaWeiboRequest delegate
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    NSArray *usersArray = [result objectForKey:@"users"];
    
    NSMutableArray *users2D = nil;
    for (int i=0; i<usersArray.count; i++) {
        users2D = [self.data lastObject];
        
        //每次判断最后一个数组是否填满数据
        if (users2D.count == 3 || users2D == nil) {
            users2D = [NSMutableArray arrayWithCapacity:3];
            [self.data addObject:users2D];
        }
        NSDictionary *userDic = [usersArray objectAtIndex:i];
        UserModel *userModel = [[UserModel alloc] initWithDataDic:userDic];
        [users2D addObject:userModel];
        [userModel release];
    }
    
    if (usersArray.count < 40) {
        self.tableView.isMore = NO;
    }else {
        self.tableView.isMore = YES;
    }
    
    self.tableView.data = self.data;
    [self.tableView reloadData];
    
    //收起下拉
    if (self.cursor == nil) {
        [self.tableView doneLoadingTableViewData];
    }
    
    //记录下一页游标值
    self.cursor = [[result objectForKey:@"next_cursor"] stringValue];
}

#pragma mark - UITableViewEvent delegate
//下拉
- (void)pullDown:(BaseTableView *)tableView {
    self.cursor = nil;
    [self.data removeAllObjects];
    [self loadAtData];
}

//上拉
- (void)pullUp:(BaseTableView *)tableView {
    [self loadAtData];
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end

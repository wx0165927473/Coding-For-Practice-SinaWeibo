//
//  DetailViewController.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-3.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "WeiboModel.h"
#import "WeiboView.h"
#import "CommentModel.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - UI
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initView];
    self.title = @"微博正文";
    _tableView.eventDelegate = self;
    [self loadData];
}

- (void)_initView {
    //建立TableView头视图
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    
    //微博用户头像
    NSString *userImageUrl = _weiboModel.user.profile_image_url;
    [self.userImageView setImageWithURL:[NSURL URLWithString:userImageUrl]];
    self.userImageView.layer.cornerRadius = 5;
    self.userImageView.layer.masksToBounds = YES;
    
    //微博用户昵称
    self.nickLabel.text = _weiboModel.user.screen_name;
    [tableHeaderView addSubview:self.userBarView];
    tableHeaderView.height += 60;
    
    //微博视图WeiboView
    float h = [WeiboView getWeiboViewHeight:_weiboModel isRepost:NO isDetail:YES];
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectMake(10, _userBarView.bottom+10, ScreenWidth-20, h)];
    _weiboView.isDetail = YES;
    _weiboView.weiboModel = _weiboModel;
    [tableHeaderView addSubview:_weiboView];
    tableHeaderView.height += (h+10);
    
    self.tableView.tableHeaderView = tableHeaderView;
    [tableHeaderView release];
}

#pragma mark - Load data
- (void)loadData {
    NSString *weiboId = [_weiboModel.weiboId stringValue];
    if (weiboId.length == 0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:weiboId forKey:@"id"];
    _request = [self.sinaweibo requestWithURL:@"comments/show.json" params:params httpMethod:@"GET" delegate:self];
    _request.tag = 201;
}

#pragma mark - SinaWeiboRequest delegate
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    //第一次加载评论列表
    if (request.tag == 201) {
        NSArray *statues = [result objectForKey:@"comments"];
        NSMutableArray *comments = [NSMutableArray arrayWithCapacity:statues.count];
        for (NSDictionary *statuesDic in statues) {
            CommentModel *commentModel = [[CommentModel alloc] initWithDataDic:statuesDic];
            [comments addObject:commentModel];
            [commentModel release];
            self.tableView.data = comments;
            self.weibos = comments;
        }
        
        self.tableView.commentDic = result;
        
        if (comments.count>0) {
            CommentModel *lastComment = [comments lastObject];
            self.lastCommentId = [lastComment.id stringValue];
        }
        
        if (statues.count >= 50) {
            self.tableView.isMore = YES;
        } else {
            self.tableView.isMore = NO;
        }
        
        [self.tableView reloadData];
    }
    
    //上拉刷新评论列表
    if (request.tag == 202) {
        NSArray *statues = [result objectForKey:@"comments"];
        NSMutableArray *lastComments = [NSMutableArray arrayWithCapacity:statues.count];
        for (NSDictionary *statuesDic in statues) {
            CommentModel *commentModal = [[CommentModel alloc] initWithDataDic:statuesDic];
            [lastComments addObject:commentModal];
            [commentModal release];
        }
        
        [self.weibos addObjectsFromArray:lastComments];
        //刷新完数据..再次赋给weibos..下次刷新接着加在comments前面
        self.tableView.data = self.weibos;
        
        //更新lastID
        if (lastComments.count>0) {
            CommentModel *lastComment = [lastComments lastObject];
            self.lastCommentId = [lastComment.id stringValue];
        }
        
        if (statues.count >= 50) {
            self.tableView.isMore = YES;
        } else {
            self.tableView.isMore = NO;
        }
        
        //刷新tableView
        [self.tableView reloadData];
    }
}


#pragma mark - memory management
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [_userImageView release];
    [_nickLabel release];
    [_userBarView release];
    [super dealloc];
}

#pragma mark - UITableViewEvent delegate 自写的
//下拉
- (void)pullDown:(BaseTableView *)tableView {
    //评论没有下拉。。。可以删除。。待定
}
//上拉
- (void)pullUp:(BaseTableView *)tableView {
    [self pullUpData];
}

- (void)pullUpData {
    if (self.lastCommentId == 0) {
        NSLog(@"微博Id为空");
        return;
    }
    NSString *weiboId = [_weiboModel.weiboId stringValue];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:weiboId ,@"id",self.lastCommentId,@"max_id", nil];
    _request = [self.sinaweibo requestWithURL:@"comments/show.json"
                                       params:params
                                   httpMethod:@"GET"
                                     delegate:self];
    _request.tag = 202;
}
//选中
- (void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end

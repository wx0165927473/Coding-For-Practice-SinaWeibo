//
//  TopicViewController.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-11.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "TopicViewController.h"
#import "WeiboModel.h"

@interface TopicViewController ()

@end

@implementation TopicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.topicName;
    [self loadTopicData];
}

#pragma mark - Data
- (void)loadTopicData {
    if (self.topicName == 0) {
        NSLog(@"话题名称为空");
        return;
    }else {
        self.topicName = [self.topicName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"编码:%@",self.topicName);
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.topicName forKey:@"q"];
    [self.sinaweibo requestWithURL:@"search/topics.json"
                                       params:params
                                   httpMethod:@"GET"
                                     delegate:self];
}

#pragma mark - SinaWeiboRequest delegate
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    NSArray *statues = [result objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statuesDic in statues) {
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
        [weibos addObject:weibo];
        [weibo release];
    }
    
    self.tableView.data = weibos;
    
    //刷新tableView
    [self.tableView reloadData];
    NSLog(@"%@",statues);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end

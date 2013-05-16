//
//  TopicViewController.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-11.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboTableView.h"
@class WeiboModel;
@interface TopicViewController : BaseViewController <SinaWeiboRequestDelegate>

@property (copy, nonatomic) NSString *topicName;
@property (retain, nonatomic) WeiboModel *weiboModel;
@property (retain, nonatomic) IBOutlet WeiboTableView *tableView;
@end

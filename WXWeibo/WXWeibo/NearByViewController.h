//
//  NearByViewController.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-12.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>

typedef void (^SelectDoneBlock)(NSDictionary *);

@interface NearByViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,SinaWeiboRequestDelegate>

@property (retain, nonatomic) NSArray *data;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) SelectDoneBlock selectBlock;
@end

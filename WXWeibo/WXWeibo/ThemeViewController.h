//
//  ThemeViewController.h
//  WXWeibo
//
//  Created by wei.chen on 13-1-22.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"

@interface ThemeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *themes;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@end

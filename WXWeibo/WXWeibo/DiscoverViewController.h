//
//  DiscoverViewController.h
//  WXWeibo
//  广场控制器

//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"

@interface DiscoverViewController : BaseViewController

@property (retain, nonatomic) IBOutlet UIButton *nearWeibo;
@property (retain, nonatomic) IBOutlet UIButton *nearPeople;
- (IBAction)nearWeiboAction:(id)sender;

- (IBAction)nearPeopleAction:(id)sender;
@end

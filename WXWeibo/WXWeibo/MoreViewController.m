//
//  MoreViewController.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MoreViewController.h"
#import "ThemeViewController.h"
#import "BrowModeController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"更多";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"主题";
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"图片浏览模式";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ThemeViewController *themeCtrl = [[ThemeViewController alloc] init];
        [self.navigationController pushViewController:themeCtrl animated:YES];
        [themeCtrl release];
    }
    if (indexPath.row == 1) {
        BrowModeController *browCtrl = [[BrowModeController alloc] init];
        [self.navigationController pushViewController:browCtrl animated:YES];
        [browCtrl release];
    }
}

@end

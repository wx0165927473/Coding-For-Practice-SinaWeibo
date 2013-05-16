//
//  ThemeViewController.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-22.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeManager.h"
#import "UIFactory.h"

@interface ThemeViewController ()

@end

@implementation ThemeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //取得所有的主题名
        themes = [[ThemeManager shareInstance].themesPlist allKeys];
        [themes retain];
        
        self.title = @"主题切换";
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
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return themes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"themeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *textLabel = [UIFactory createLabel:kThemeListLabel];
        textLabel.frame = CGRectMake(10, 10, 200, 30);
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        textLabel.tag = 2013;
        [cell.contentView addSubview:textLabel];
    }
    
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:2013];
    //当前cell中的主题名
    NSString *name = themes[indexPath.row];
    textLabel.text = name;
    
    //当前使用的主题名称
    NSString *themeName = [ThemeManager shareInstance].themeName;
    if (themeName == nil) {
        themeName = @"默认";
    }
    
    //比较cell中的主题名和当前使用的主题名是否相同
    if ([themeName isEqualToString:name]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

//切换主题
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //主题名称
    NSString *themeName = themes[indexPath.row];
    if ([themeName isEqualToString:@"默认"]) {
        themeName = nil;
    }
    
    //保存主题到本地
    [[NSUserDefaults standardUserDefaults] setObject:themeName forKey:kThemeName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [ThemeManager shareInstance].themeName = themeName;
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNofication object:themeName];
    
    //刷新列表
    [tableView reloadData];
}

@end

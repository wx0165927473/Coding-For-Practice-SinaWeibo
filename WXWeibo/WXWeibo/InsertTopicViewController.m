//
//  InsertTopicViewController.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-18.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "InsertTopicViewController.h"

@interface InsertTopicViewController ()

@end

@implementation InsertTopicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"插入话题";
        _hotTopic = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _searchBar.placeholder = @"直接输入话题";
    UITextField *searchField = [[_searchBar subviews] lastObject];
    [searchField setReturnKeyType:UIReturnKeyDone];
    [self loadData];
}

#pragma mark - data
- (void)loadData {
    [self.sinaweibo requestWithURL:@"trends/weekly.json" params:nil httpMethod:@"GET" delegate:self];
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _hotTopic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *indentify = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify] autorelease];
            NSString *topic = [_hotTopic objectAtIndex:indexPath.row];
            cell.textLabel.text = topic;
        }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *selectTopic = cell.textLabel.text;
    [self dismissViewControllerAnimated:YES completion:NULL];
    _block(selectTopic);
    Block_release(_block);
    _block = nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"热门微博";
}

#pragma mark - SinaWeiboRequest delegate
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    //yyyy-M-d HH:mm
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString * dateString = [formatter stringFromDate:date];

    NSDictionary *weekly = [result objectForKey:@"trends"];
    NSArray *array = [weekly objectForKey:dateString];//2013-05-18 17:24
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        NSString *topicString = [dic objectForKey:@"name"];
        NSString *topic = [NSString stringWithFormat:@"#%@#",topicString];
        [_hotTopic addObject:topic];
    }

    [self.tableView reloadData];
}

#pragma mark - UISearchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *text = searchBar.text;
    NSString *topic = [NSString stringWithFormat:@"#%@#",text];
    _block(topic);
    Block_release(_block);
    _block = nil;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    _searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _searchBar.text = @"";
    [_searchBar resignFirstResponder];
    _searchBar.showsCancelButton = NO;
}

- (void)dealloc {
    [_tableView release];
    [_searchBar release];
    [super dealloc];
}
@end

//
//  FriendShipsTableView.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-16.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "FriendShipsTableView.h"
#import "FriendShipsCell.h"

@implementation FriendShipsTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentify = @"cell";
    FriendShipsCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell == nil) {
        cell = [[[FriendShipsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSArray *usersArray = [self.data objectAtIndex:indexPath.row];
    cell.data = usersArray;
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

@end

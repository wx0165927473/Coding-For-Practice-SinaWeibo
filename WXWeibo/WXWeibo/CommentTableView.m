//
//  CommentTableView.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-5.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentCell.h"
#import "CommentModel.h"

@implementation CommentTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark tableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"CommentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil] lastObject];
    }
    CommentModel *commentModel = [self.data objectAtIndex:indexPath.row];
    cell.commentModel = commentModel;
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentModel *commentModel = [self.data objectAtIndex:indexPath.row];
    float h = [CommentCell getCommentHeight:commentModel];
    return h+50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *commentCount = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    commentCount.backgroundColor = [UIColor clearColor];
    commentCount.font = [UIFont systemFontOfSize:16.0f];
    commentCount.textColor = [UIColor blueColor];
    
    NSNumber *totalNumber = [self.commentDic objectForKey:@"total_number"];
    commentCount.text = [NSString stringWithFormat:@"评论:%@",totalNumber];
    [view addSubview:commentCount];
    [commentCount release];
    
    UIImageView *separateView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userinfo_header_separator.png"]];
    separateView.frame = CGRectMake(0, 39, tableView.width, 1);
    separateView.backgroundColor = [UIColor clearColor];
    [view addSubview:separateView];
    [separateView release];
    
    return [view autorelease];
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end

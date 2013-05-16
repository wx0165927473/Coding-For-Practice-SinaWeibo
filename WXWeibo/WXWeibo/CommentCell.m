//
//  CommentCell.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-5.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    _userImage = [(UIImageView *)[self viewWithTag:100] retain];
    _nickLabel = [(UILabel *)[self viewWithTag:101] retain];
    _timeLabel = [(UILabel *)[self viewWithTag:102] retain];
    
    _contentLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    _contentLabel.font = [UIFont systemFontOfSize:14.0f];
    _contentLabel.delegate = self;
    //设置链接的颜色
    _contentLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    //设置链接高亮的颜色
    _contentLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];
    [self.contentView addSubview:_contentLabel];
}

//设置数据，布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSString *urlString = self.commentModel.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:urlString]];
    _userImage.layer.cornerRadius = 5;  //圆弧半径
    _userImage.layer.borderWidth = .5;
    _userImage.layer.borderColor = [UIColor grayColor].CGColor;
    _userImage.layer.masksToBounds = YES;
    
    _nickLabel.text = self.commentModel.user.screen_name;
    _timeLabel.text = [UIUtils fomateString:self.commentModel.created_at];
    
    _contentLabel.frame = CGRectMake(_userImage.right+10, _nickLabel.bottom+5, 240, 20);
    _contentLabel.text = self.commentModel.text;
    //解析文本，显示超链接
    _contentLabel.text = [UIUtils parseLink:_contentLabel.text];
    _contentLabel.height = _contentLabel.optimumSize.height;
    
}

+(float)getCommentHeight:(CommentModel *)commentModel {
    RTLabel *rt = [[RTLabel alloc] initWithFrame:CGRectMake(0, 0, 240, 0)];
    rt.font = [UIFont systemFontOfSize:14.0f];
    rt.text = commentModel.text;
    return rt.optimumSize.height;
}

#pragma mark - RTLabel delegate
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url {
    
}

@end

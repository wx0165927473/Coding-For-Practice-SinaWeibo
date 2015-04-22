#import "WeiboCell.h"
#import <QuartzCore/QuartzCore.h>
#import "WeiboView.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"
#import "RegexKitLite.h"
#import "WXImageView.h"
#import "UserViewController.h"

@implementation WeiboCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    return self;
}

//初始化子视图
- (void)_initView {
    //用户头像
    _userImage = [[WXImageView alloc] initWithFrame:CGRectZero];
    _userImage.backgroundColor = [UIColor clearColor];
    _userImage.layer.cornerRadius = 5;  //圆弧半径
    _userImage.layer.borderWidth = .5;
    _userImage.layer.borderColor = [UIColor grayColor].CGColor;
    _userImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_userImage];
    [_userImage release];
    
    //昵称
    _nickLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nickLabel.backgroundColor = [UIColor clearColor];
    _nickLabel.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_nickLabel];
    [_nickLabel release];
    
    //转发数
    _repostCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _repostCountLabel.font = [UIFont systemFontOfSize:12.0];
    _repostCountLabel.backgroundColor = [UIColor clearColor];
    _repostCountLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_repostCountLabel];
    [_repostCountLabel release];
    
    //回复数
    _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _commentLabel.font = [UIFont systemFontOfSize:12.0];
    _commentLabel.backgroundColor = [UIColor clearColor];
    _commentLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_commentLabel];
    [_commentLabel release];
    
    
    //微博来源
    _sourceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _sourceLabel.font = [UIFont systemFontOfSize:12.0];
    _sourceLabel.backgroundColor = [UIColor clearColor];
    _sourceLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_sourceLabel];
    [_sourceLabel release];
    
    //发布时间
    _createLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _createLabel.font = [UIFont systemFontOfSize:12.0];
    _createLabel.backgroundColor = [UIColor clearColor];
    _createLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:_createLabel];
    [_createLabel release];
    
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_weiboView];
    [_weiboView release];
    
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    selectedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"statusdetail_cell_sepatator.png"]];
    self.selectedBackgroundView = selectedBackgroundView;
    [selectedBackgroundView release];
}

- (void)setWeiboModel:(WeiboModel *)weiboModel {
    if (_weiboModel != weiboModel) {
        [_weiboModel release];
        _weiboModel = [weiboModel retain];
    }

    __block WeiboCell *this = self;
    _userImage.touchBlock = ^{
        NSString *nickName = this.weiboModel.user.screen_name;
        UserViewController *userCtrl = [[UserViewController alloc] init];
        userCtrl.userName = nickName;
        [this.viewController.navigationController pushViewController:userCtrl animated:YES];
        [userCtrl release];
    };
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //5.0---weiboView重新布局，调用weiboView LayoutSubviews
    [_weiboView setNeedsLayout];
    
    //-----------用户头像视图_userImage--------
    _userImage.frame = CGRectMake(5, 5, 35, 35);
    NSString *userImageUrl = _weiboModel.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:userImageUrl]];
    
    //昵称_nickLabel
    _nickLabel.frame = CGRectMake(50, 5, 200, 20);
    _nickLabel.text = _weiboModel.user.screen_name;

    //回复数_commentLabel
    _commentLabel.frame = CGRectMake(self.width-_commentLabel.width-8, 5, 100, 20);
    NSString *commentsCount = [_weiboModel.commentsCount stringValue];
    _commentLabel.text = [NSString stringWithFormat:@"回复:%@",commentsCount];
    [_commentLabel sizeToFit];
    
    //转发数_repostCountLabel
    _repostCountLabel.frame = CGRectMake(_commentLabel.left-_repostCountLabel.width-8, 5, 100, 20);
    NSString *repostsCount = [_weiboModel.repostsCount stringValue];
    _repostCountLabel.text = [NSString stringWithFormat:@"转发:%@",repostsCount];
    [_repostCountLabel sizeToFit];
    
    //微博视图_weiboView
    _weiboView.weiboModel = _weiboModel;
    //获取微博视图的高度
    float h = [WeiboView getWeiboViewHeight:_weiboModel isRepost:NO isDetail:NO];
    _weiboView.frame = CGRectMake(50, _nickLabel.bottom+10, kWeibo_Width_List, h);
    
    //发布时间
    //源日期字符串：Tue May 31 17:46:55 +0800 2011
    //M d HH:mm:ss Z yyyy
    //目标日期字符串：MM-dd HH:mm 01-23 15:23
    NSString *createDate = _weiboModel.createDate;
    if (createDate != nil) {
        _createLabel.hidden = NO;
        NSString *dateString = [UIUtils fomateString:createDate];
        _createLabel.text = dateString;
        _createLabel.frame = CGRectMake(50, self.height-20, 100, 20);
        [_createLabel sizeToFit];
    }else {
        _createLabel.hidden = YES;
    }
    
    //消息来源
    NSString *source = _weiboModel.source;
    NSString *ret = [self parseSource:source];
    if (ret != nil) {
        _sourceLabel.hidden = NO;
        _sourceLabel.text = [NSString stringWithFormat:@"来自%@",ret];
        _sourceLabel.frame = CGRectMake(_createLabel.right+8, _createLabel.top, 100, 20);
        [_sourceLabel sizeToFit];
    }else {
        _sourceLabel.hidden = YES;
    }
}

- (NSString *)parseSource:(NSString *)source {
    NSString *regex = @">\\w+<";
    NSArray *matchArray = [source componentsMatchedByRegex:regex];
    if (matchArray.count>0) {
        NSString *ret = [matchArray objectAtIndex:0];
        NSRange range;
        range.location = 1;
        range.length = ret.length - 2;
        NSString *resultString = [ret substringWithRange:range];
        return resultString;
    }
    else
        return nil;
}

@end

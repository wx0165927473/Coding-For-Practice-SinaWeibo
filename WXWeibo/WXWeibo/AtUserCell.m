#import "AtUserCell.h"
#import "UIImageView+WebCache.h"
#import "InsertAtUserViewController.h"

@implementation AtUserCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)_initView {
    
    //用户头像
    _userImage = [[UIImageView alloc] initWithFrame:CGRectZero];
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
    _nickLabel.font = [UIFont systemFontOfSize:17.0];
    [self.contentView addSubview:_nickLabel];
    [_nickLabel release];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //-----------用户头像视图_userImage--------
    _userImage.frame = CGRectMake(5, 5, 35, 35);
    NSString *userImageUrl = _userModel.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:userImageUrl]];
    
    //昵称_nickLabel
    _nickLabel.frame = CGRectMake(50, 5, 200, 20);
    _nickLabel.text = _userModel.name;
}


@end

#import "UserInfoView.h"
#import "UIImageView+WebCache.h"
#import "FriendShipsViewController.h"

@implementation UserInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view= [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil] lastObject];
//        view.backgroundColor = Color(245, 245, 245, 1);
        [self addSubview:view];
        self.size = view.size;
    }
    return self;
}

- (void)layoutSubviews {
    //用户头像
    NSString *userImage = self.userModel.avatar_large;
    [self.userImage setImageWithURL:[NSURL URLWithString:userImage]];
    
    //昵称
    self.nickLabel.text = self.userModel.name;
    
    //性别
    NSString *gender = self.userModel.gender;
    NSString *sexName = @"未知";
    if ([gender isEqualToString:@"f"]) {
        sexName = @"女";
    }else if ([gender isEqualToString:@"m"]) {
        sexName = @"男";
    }
    
    //地址
    NSString *location = self.userModel.location;
    if (location == nil) {
        location = @"";
    }
    self.addressLabel.text = [NSString stringWithFormat:@"%@ %@",sexName,location];
    
    //简介
    self.infoLabel.text = self.userModel.description;
    
    //粉丝数
    NSString *count = [self.userModel.statuses_count stringValue];
    self.countLabel.text = [NSString stringWithFormat:@"共%@条微博",count];
    
    long favL = [self.userModel.followers_count longValue];
    NSString *fans = [NSString stringWithFormat:@"%ld",favL];
    if (favL > 10000) {
        favL = favL/1000;
        fans = [NSString stringWithFormat:@"%ld万",favL];
    }
    self.fansButton.subtitle = fans;
    self.fansButton.title = @"粉丝";
    
    //关注数
    self.attButton.subtitle = [self.userModel.friends_count stringValue];
    self.attButton.title = @"关注";
    
    //本来不应该有的。。直接拿userModel获取 但是点击RTButton。获取不了self.usermodel
    self.userID = self.userModel.idstr;
}

- (IBAction)attAction:(id)sender {
    FriendShipsViewController *friendShipsVC = [[FriendShipsViewController alloc] init];
    friendShipsVC.userID = self.userID;
    friendShipsVC.isFriends = YES;
    [self.viewController.navigationController pushViewController:friendShipsVC animated:YES];
    [friendShipsVC release];
}

- (IBAction)fansAction:(id)sender {
    FriendShipsViewController *friendShipsVC = [[FriendShipsViewController alloc] init];
    friendShipsVC.userID = self.userID;
    friendShipsVC.isFriends = NO;
    [self.viewController.navigationController pushViewController:friendShipsVC animated:YES];
    [friendShipsVC release];
}

- (void)dealloc {
    [_userImage release];
    [_nickLabel release];
    [_addressLabel release];
    [_infoLabel release];
    [_countLabel release];
    [_attButton release];
    [_fansButton release];
    [super dealloc];
}
@end

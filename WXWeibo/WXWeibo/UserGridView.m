//
//  UserGridView.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-15.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UserGridView.h"
#import "UserModel.h"
#import "UIButton+WebCache.h"
#import "UserViewController.h"

@implementation UserGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"UserGridView" owner:self options:nil] lastObject];
        view.backgroundColor = [UIColor clearColor];
        self.size = view.size;
        [self addSubview:view];
        
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_button3_1.png"]];
        backgroundView.frame = self.bounds;
        [self insertSubview:backgroundView atIndex:0];
        [backgroundView release];
    }
    return self;
}

- (void)layoutSubviews {
    
    //昵称
    self.nickLabel.text = self.userModel.screen_name;
    
    //粉丝数
    long favL = [self.userModel.followers_count longValue];
    NSString *fans = [NSString stringWithFormat:@"%ld",favL];
    if (favL > 10000) {
        favL = favL/1000;
        fans = [NSString stringWithFormat:@"%ld万",favL];
    }
    self.fansLabel.text = [NSString stringWithFormat:@"%@粉丝",fans];
    
    //头像
    NSString *imageString = self.userModel.profile_image_url;
    [self.imageButton setImageWithURL:[NSURL URLWithString:imageString]];
}

- (void)dealloc {
    [_nickLabel release];
    [_fansLabel release];
    [_imageButton release];
    [super dealloc];
}
- (IBAction)userImageAction:(id)sender {
    UserViewController *userVC = [[UserViewController alloc] init];
    userVC.userID = self.userModel.idstr;
    [self.viewController.navigationController pushViewController:userVC animated:YES];
    [userVC release];
}
@end

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "RectButton.h"
@interface UserInfoView : UIView

@property (retain, nonatomic) UserModel *userModel;
@property (retain, nonatomic) IBOutlet UIImageView *userImage;
@property (retain, nonatomic) IBOutlet UILabel *nickLabel;
@property (retain, nonatomic) IBOutlet UILabel *addressLabel;
@property (retain, nonatomic) IBOutlet UILabel *infoLabel;
@property (retain, nonatomic) IBOutlet UILabel *countLabel;
@property (retain, nonatomic) IBOutlet RectButton *attButton;
@property (retain, nonatomic) IBOutlet RectButton *fansButton;

@property (copy, nonatomic) NSString *userID; //本来不应该有的。。直接拿userModel获取 但是点击RTButton。获取不了self.usermodel

- (IBAction)attAction:(id)sender;
- (IBAction)fansAction:(id)sender;
@end

#import <UIKit/UIKit.h>

@class UserModel;
@interface UserGridView : UIView

@property (retain, nonatomic) UserModel *userModel;
@property (retain, nonatomic) IBOutlet UILabel *nickLabel;
@property (retain, nonatomic) IBOutlet UILabel *fansLabel;
@property (retain, nonatomic) IBOutlet UIButton *imageButton;
- (IBAction)userImageAction:(id)sender;
@end

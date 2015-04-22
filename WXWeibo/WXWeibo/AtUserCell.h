#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface AtUserCell : UITableViewCell {
    UIImageView     *_userImage;
}

//微博数据模型对象
@property(nonatomic,retain)UserModel *userModel;
@property(nonatomic,retain)UILabel *nickLabel;
@end

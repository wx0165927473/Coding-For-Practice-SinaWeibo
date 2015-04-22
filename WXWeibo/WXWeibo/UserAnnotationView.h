#import <MapKit/MapKit.h>
#import "UserModel.h"

@interface UserAnnotationView : MKAnnotationView {
    UIImageView *userImage;     //用户头像
}

@property (nonatomic,retain)    UserModel *userModel;

@end

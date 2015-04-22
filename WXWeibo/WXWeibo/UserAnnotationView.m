#import "UserAnnotationView.h"
#import "UserAnnotation.h"
#import "UIImageView+WebCache.h"

@implementation UserAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    userImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:userImage];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UserAnnotation *userAnnotation = self.annotation;
    if ([userAnnotation isKindOfClass:[UserAnnotation class]]) {
        self.userModel = userAnnotation.userModel;
    }
    
    self.image = [UIImage imageNamed:@"nearby_map_photo_bg.png"];
    
    //加载用户头像
    userImage.frame = CGRectMake(15, 15, 90, 85);
    NSString *userImageURL = self.userModel.avatar_large;
    [userImage setImageWithURL:[NSURL URLWithString:userImageURL]];
}
@end

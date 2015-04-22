#import <UIKit/UIKit.h>

@interface RectButton : UIButton {
    UILabel *_rectTitleLabel;
    UILabel *_subtitleLabel;
}

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;

@end

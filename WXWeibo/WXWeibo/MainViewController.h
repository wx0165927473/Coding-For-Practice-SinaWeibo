#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@class HomeViewController;
@interface MainViewController : UITabBarController<SinaWeiboDelegate,SinaWeiboRequestDelegate,UINavigationControllerDelegate> {
    UIView *_tabbarView;
    UIImageView *_sliderView;
    UIImageView *_badgeView;
    HomeViewController *_homeCtrl;
}
//是否显示未读图标
- (void)showBadge:(BOOL)show;
//是否隐藏tabbar
- (void)showTabbar:(BOOL)show;

@end

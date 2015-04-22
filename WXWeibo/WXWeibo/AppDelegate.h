
#import <UIKit/UIKit.h>
#import "DDMenuController.h"
#import "MainViewController.h"

@class SinaWeibo;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) SinaWeibo *sinaweibo;
@property (nonatomic,retain) MainViewController *mainCtrl;
@property (nonatomic,retain) DDMenuController *menuCtrl;

@end

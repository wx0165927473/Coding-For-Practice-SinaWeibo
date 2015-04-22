#import "BaseViewController.h"
#import "WeiboTableView.h"
#import "UserInfoView.h"

@interface UserViewController : BaseViewController <SinaWeiboRequestDelegate>

@property (nonatomic,retain)  SinaWeiboRequest *request;
@property (copy, nonatomic)   NSString *userName;
@property (copy, nonatomic)   NSString *userID;
@property (nonatomic, assign) BOOL isLoginUser;

@property (retain, nonatomic) IBOutlet WeiboTableView *tableView;
@property (retain, nonatomic) UserInfoView *userInfo;
@end

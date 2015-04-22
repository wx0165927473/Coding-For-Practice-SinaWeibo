typedef void (^SelectTopicBlock)(NSString *);

#import "BaseViewController.h"
#import "UserModel.h"

@interface InsertAtUserViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,SinaWeiboRequestDelegate> {
    NSMutableArray *_users;
    UIImageView *_userImage;
}

@property (retain, nonatomic) IBOutlet UITableView *tablieView;
@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;

@property (copy, nonatomic) SelectTopicBlock block;
@end

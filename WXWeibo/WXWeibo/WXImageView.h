#import <UIKit/UIKit.h>

//点击头像 进入详情页面
typedef void(^ImageBlock)(void);

@interface WXImageView : UIImageView

@property (nonatomic,copy) ImageBlock touchBlock;

@end

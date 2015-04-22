#import <UIKit/UIKit.h>
#import "RTLabel.h"

@class CommentModel;
@interface CommentCell : UITableViewCell <RTLabelDelegate> {
    UIImageView     *_userImage;    //用户头像视图
    UILabel         *_nickLabel;    //昵称
    UILabel         *_timeLabel;    //评论时间
    RTLabel         *_contentLabel; //评论内容
}
@property (nonatomic,retain)CommentModel *commentModel;

+(float)getCommentHeight:(CommentModel *)commentModel;
@end

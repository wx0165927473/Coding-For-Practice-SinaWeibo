#import "CommentModel.h"

@implementation CommentModel

- (void)setAttributes:(NSDictionary *)dataDic {
    [super setAttributes:dataDic];
    
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    NSDictionary *weiboDic = [dataDic objectForKey:@"status"];
    
    WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:weiboDic];
    UserModel *user = [[UserModel alloc] initWithDataDic:userDic];
    
    self.weibo = [weibo autorelease];
    self.user = [user autorelease];
}
@end

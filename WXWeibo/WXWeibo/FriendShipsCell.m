#import "FriendShipsCell.h"
#import "UserGridView.h"
#import "UserModel.h"

@implementation FriendShipsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)setData:(NSArray *)data {
    if (_data != data) {
        [_data release];
        _data = [data retain];
    }

    for (int i=0; i<3; i++) {
        UserGridView *userGridView = (UserGridView *)[self.contentView viewWithTag:2013+i];
        userGridView.hidden = YES;
    }
}

- (void)initViews {
    for (int i=0; i<3; i++) {
        UserGridView *userGridView = [[UserGridView alloc] initWithFrame:CGRectZero];
        userGridView.tag = 2013 + i;
        [self.contentView addSubview:userGridView];
        [userGridView release];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
        
    for (int i=0; i<self.data.count; i++) {
        UserModel *userModel = [self.data objectAtIndex:i];
        UserGridView *userGridView = (UserGridView *)[self.contentView viewWithTag:(2013+i)];
        userGridView.frame = CGRectMake(100*i+13, 10, 96, 96);
        userGridView.userModel = userModel;
        
        userGridView.hidden = NO;
        
        //让gridView 异步调用layoutSubviews
        [userGridView setNeedsLayout];
    }
}

@end

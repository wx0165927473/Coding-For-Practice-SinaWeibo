#import "WXImageView.h"

@implementation WXImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesture];
        [tapGesture release];
    }
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGesture {
    if (self.touchBlock) {
        _touchBlock();
    }
}

- (void)dealloc
{
    [super dealloc];
    Block_release(_touchBlock);
}

@end

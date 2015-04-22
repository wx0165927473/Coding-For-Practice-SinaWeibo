#import "RectButton.h"

@implementation RectButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        [_title release];
        _title = [title copy];
    }

    
    if (_rectTitleLabel == nil) {
        _rectTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 70, 30)];
        _rectTitleLabel.backgroundColor = [UIColor clearColor];
        _rectTitleLabel.font = [UIFont systemFontOfSize:15.0f];
        _rectTitleLabel.textColor = [UIColor blackColor];
        _rectTitleLabel.textAlignment = NSTextAlignmentCenter;
        _rectTitleLabel.text = title;
        [self addSubview:_rectTitleLabel];
    }
}

- (void)setSubtitle:(NSString *)subtitle {
    if (_subtitle != subtitle) {
        [_subtitle release];
        _subtitle = [subtitle copy];
    }

    
    if (_subtitleLabel == nil) {
        _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 70, 25)];
        _subtitleLabel.backgroundColor = [UIColor clearColor];
        _subtitleLabel.font = [UIFont systemFontOfSize:18.0f];
        _subtitleLabel.textColor = [UIColor blueColor];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        _subtitleLabel.text = subtitle;
        [self addSubview:_subtitleLabel];
    }
}

@end

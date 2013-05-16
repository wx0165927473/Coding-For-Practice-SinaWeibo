//
//  WXImageView.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-10.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

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

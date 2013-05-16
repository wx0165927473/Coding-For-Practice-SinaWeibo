//
//  WXFaceScrollView.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-15.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXFaceView.h"

@interface WXFaceScrollView : UIView <UIScrollViewDelegate> {
    UIScrollView *faceScrollView;
    UIPageControl *pageControl;
    WXFaceView *faceView;
}

- (id)initWithBlock:(SelectBlock)block;
@end

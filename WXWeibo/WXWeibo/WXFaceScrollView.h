#import <UIKit/UIKit.h>
#import "WXFaceView.h"

@interface WXFaceScrollView : UIView <UIScrollViewDelegate> {
    UIScrollView *faceScrollView;
    UIPageControl *pageControl;
    WXFaceView *faceView;
}

- (id)initWithBlock:(SelectBlock)block;
@end

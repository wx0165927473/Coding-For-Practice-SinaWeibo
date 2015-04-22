#import "WXFaceScrollView.h"

@implementation WXFaceScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (id)initWithBlock:(SelectBlock)block {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        faceView.block = block;
    }
    return self;
}

- (void)initViews {
    faceView = [[WXFaceView alloc] initWithFrame:CGRectZero];
    
    faceScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, faceView.height)];
    faceScrollView.backgroundColor = [UIColor clearColor];
    faceScrollView.contentSize = CGSizeMake(faceView.width, faceView.height);
    faceScrollView.pagingEnabled = YES;
    faceScrollView.showsHorizontalScrollIndicator = NO;
    faceScrollView.clipsToBounds = NO;
    faceScrollView.delegate = self;
    [faceScrollView addSubview:faceView];
    [self addSubview:faceScrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, faceScrollView.bottom, 40, 20)];
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.numberOfPages = faceView.pageNumber;
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
    
    self.height = faceScrollView.height + pageControl.height;
    self.width = faceView.width;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int pageNumber = scrollView.contentOffset.x / 320;
    pageControl.currentPage = pageNumber;
}

- (void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"emoticon_keyboard_background.png"] drawInRect:rect];
}

- (void)dealloc
{
    [faceView release];
    [faceScrollView release];
    [super dealloc];
}

@end

//
//  WXFaceView.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-14.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WXFaceView.h"

#define item_width  42
#define item_height 45

@implementation WXFaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        self.pageNumber = items.count;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/**
 *  行  row = 4;
 *  列  colum = 7
 *  表情尺寸   30 * 30 pixel
 */

/*
 *items = [
                ["表情1","表情2","表情3",....."表情28"],
                ["表情1","表情2","表情3",....."表情28"],
                ["表情1","表情2","表情3",....."表情28"],
          ];
*/
- (void)initData {
    items = [[NSMutableArray alloc] init];
    
    //整理表情成2维数组
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *fileArray = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *items2D = nil;
    for (int i = 0; i<fileArray.count; i++) {
        NSDictionary *item = [fileArray objectAtIndex:i];
        if (i % 28 == 0) {
            items2D = [NSMutableArray arrayWithCapacity:28];
            [items addObject:items2D];
        }
        [items2D addObject:item];
    }
    
    //设置尺寸
    self.width = items.count * 320;
    self.height = 4 * item_height;
    
    //放大镜
    magnifierView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 92)];
    magnifierView.image = [UIImage imageNamed:@"emoticon_keyboard_magnifier.png"];
    magnifierView.backgroundColor = [UIColor clearColor];
    magnifierView.hidden = YES;
    [self addSubview:magnifierView];
    
    UIImageView *faceItem = [[UIImageView alloc] initWithFrame:CGRectMake((64-30)/2, 15, 30, 30)];
    faceItem.tag = 2013;
    [magnifierView addSubview:faceItem];
}

/*
 *items = [
 ["表情1","表情2","表情3",....."表情28"],
 ["表情1","表情2","表情3",....."表情28"],
 ["表情1","表情2","表情3",....."表情28"],
 ];
 */

//绘制表情
- (void)drawRect:(CGRect)rect
{
    //定义列 行
    int row = 0 , colum = 0;
    for (int i = 0; i<items.count; i++) {
        NSArray *items2D = [items objectAtIndex:i];
        
        for (int j = 0; j<items2D.count; j++) {
            NSDictionary *item = [items2D objectAtIndex:j];
            NSString *imageString = [item objectForKey:@"png"];
            UIImage *image= [UIImage imageNamed:imageString];
            
            CGRect frame = CGRectMake(item_width*colum + 15, item_height*row + 15, 30, 30);
            
            //考虑页数,需要加上前几页的宽度
            float x = (i * 320) + frame.origin.x;
            frame.origin.x = x;
            [image drawInRect:frame];
            
            //更新列 行
            colum++;
            if (colum % 7 == 0) {
                row++;
                colum = 0;
            }
            if (row == 4) {
                row = 0;
            }
        }
    }
}

- (void)touchFace:(CGPoint)point {
    //页数
    int page = point.x / 320;
    
    float x = point.x - (page*320) - 10;
    float y = point.y - 10;
    
    int colum = x / item_width;
    int row = y / item_height;
    
    if (colum > 6) {
        colum = 6;
    }
    if (colum < 0) {
        colum = 0;
    }
    
    if (row > 3) {
        row = 3;
    }
    if (row < 0) {
        row = 0;
    }
    
    int index = colum + row*7;
    
    NSArray *items2D = [items objectAtIndex:page];
    NSDictionary *item = [items2D objectAtIndex:index];
    NSString *itemName = [item objectForKey:@"chs"];
    
    if (![self.selectedFaceName isEqualToString:itemName] || self.selectedFaceName == nil) {
        NSString *itemString = [item objectForKey:@"png"];
        
        UIImageView *faceItem = (UIImageView *)[magnifierView viewWithTag:2013];
        faceItem.image = [UIImage imageNamed:itemString];
        
        //移动放大镜
        magnifierView.left = page*320 + item_width*colum;
        magnifierView.bottom = item_height*row + 30;
        
        self.selectedFaceName = itemName;
    }

}

//touch事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    magnifierView.hidden = NO;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    [self touchFace:point];
    
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        scrollView.scrollEnabled = NO;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    [self touchFace:point];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    magnifierView.hidden = YES;
    
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        scrollView.scrollEnabled = YES;
    }
    
    if (self.block != nil) {
        _block(self.selectedFaceName);
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    magnifierView.hidden = YES;
    
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        scrollView.scrollEnabled = YES;
    }
}

- (void)dealloc
{
    Block_release(_block);
    [super dealloc];
}


@end

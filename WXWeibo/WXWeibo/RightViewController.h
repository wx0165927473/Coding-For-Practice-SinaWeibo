//
//  RightViewController.h
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"

@interface RightViewController : BaseViewController <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (retain, nonatomic) UIImage *image;
@property (retain, nonatomic) UIButton *sengImageButton;

- (IBAction)sendAction:(id)sender;
@end

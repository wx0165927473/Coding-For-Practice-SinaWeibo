//
//  SendViewController.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-12.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "SendViewController.h"
#import "UIFactory.h"
#import "NearByViewController.h"
#import "BaseNavigationController.h"

@interface SendViewController ()

@end

@implementation SendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //监听键盘显示/隐藏通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        
        self.isCancelButton = YES;
        self.isBackButton = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"发微博";
    _buttons = [[NSMutableArray alloc] initWithCapacity:6];
    
    UIButton *sendButton = [UIFactory createNavigationButton:CGRectMake(0, 0, 45, 30) title:@"发送" target:self action:@selector(sendAction)];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = [sendItem autorelease];
    
    [self _initView];
}

- (void)_initView {
    //键盘成为第一响应者
    [self.textView becomeFirstResponder];
    self.textView.delegate = self;
    
    NSArray *imageNames = [NSArray arrayWithObjects:@"compose_locatebutton_background.png",
                                                    @"compose_camerabutton_background.png",
                                                    @"compose_trendbutton_background.png",
                                                    @"compose_mentionbutton_background.png",
                                                    @"compose_emoticonbutton_background.png",
                                                    @"compose_keyboardbutton_background.png",
                                                    nil];
    
    NSArray *imageHighted = [NSArray arrayWithObjects:@"compose_locatebutton_background_highlighted.png",
                                                      @"compose_camerabutton_background_highlighted.png",
                                                      @"compose_trendbutton_background_highlighted.png",
                                                      @"compose_mentionbutton_background_highlighted.png",
                                                      @"compose_emoticonbutton_background_highlighted.png",
                                                      @"compose_keyboardbutton_background.png_highlighted.png",
                                                      nil];
    for (int i = 0; i<imageNames.count; i++) {
        NSString *imageName = [imageNames objectAtIndex:i];
        NSString *hightedName = [imageHighted objectAtIndex:i];
        UIButton *button = [UIFactory createButton:imageName highlighted:hightedName];
        [button setImage:[UIImage imageNamed:hightedName] forState:UIControlStateSelected];
        button.tag = 10+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(20+(64*i), 25, 23, 19);
        [self.editorBar addSubview:button];
        [_buttons addObject:button];
        
        if (i == 5) {
            button.hidden = YES;
            button.left -= 64;
        }
    }
    
    self.placeBackgroundView.image = [self.placeBackgroundView.image stretchableImageWithLeftCapWidth:30 topCapHeight:0];
    self.placeBackgroundView.width = 230;
    
    self.placeLabel.left = 35;
    self.placeLabel.width = 180;
}

//定位
- (void)location {
    NearByViewController *nearByVC = [[NearByViewController alloc] init];
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:nearByVC];
    [self presentViewController:baseNav animated:YES completion:NULL];
    [nearByVC release];
    [baseNav release];
    
    nearByVC.selectBlock = ^(NSDictionary *result){
        //记录位置坐标
        self.longitude = [result objectForKey:@"lon"];
        self.latitude = [result objectForKey:@"lat"];
        
        NSString *address = [result objectForKey:@"address"];
        if ([address isKindOfClass:[NSNull class]] || address.length == 0) {
            address = [result objectForKey:@"title"];
        }
        
        self.placeView.hidden = NO;
        self.placeLabel.text = address;
        
        UIButton *locationButton = [_buttons objectAtIndex:0];
        locationButton.selected = YES;
    };
}

//选择图片/相机
- (void)selectImage {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}
//显示表情
- (void)showFaceView {
    [self.textView resignFirstResponder];
    
    if (_faceScrollView == nil) {
        __block SendViewController *this = self;
        _faceScrollView = [[WXFaceScrollView alloc] initWithBlock:^(NSString *faceName) {
            NSString *text = this.textView.text;
            NSString *appendText = [text stringByAppendingString:faceName];
            this.textView.text = appendText;
        }];
        _faceScrollView.top = ScreenHeight - 20 - 44 - _faceScrollView.height;
        _faceScrollView.transform = CGAffineTransformTranslate(_faceScrollView.transform, 0, ScreenHeight - 20 - 44);
        [self.view addSubview:_faceScrollView];
    }
    
    UIButton *faceButton = [_buttons objectAtIndex:4];
    UIButton *keyboardButton = [_buttons objectAtIndex:5];
    faceButton.alpha = 1;
    keyboardButton.alpha = 0;
    keyboardButton.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _faceScrollView.transform = CGAffineTransformIdentity;
        faceButton.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            keyboardButton.alpha = 1;
        }];
    }];
    
    //调整textView editorBar Y坐标
    self.editorBar.bottom = ScreenHeight - _faceScrollView.size.height - 20 -44;
    self.textView.height = self.editorBar.top;
}

//显示键盘
- (void)showKeyboard {
    [self.textView becomeFirstResponder];
    
    UIButton *faceButton = [_buttons objectAtIndex:4];
    UIButton *keyboardButton = [_buttons objectAtIndex:5];
    keyboardButton.alpha = 1;
    faceButton.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        _faceScrollView.transform = CGAffineTransformTranslate(_faceScrollView.transform, 0, ScreenHeight - 20 - 44);
        keyboardButton.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            faceButton.alpha = 1;
        }];
    }];
}

#pragma mark - Action
- (void)sendAction {
    [self doSendData];
}

- (void)buttonAction:(UIButton *)button {
    if (button.tag == 10) {
        //定位
        [self location];
    }
    else if (button.tag == 11) {
        //图片 相机
        [self selectImage];
    }
    else if (button.tag == 12) {
        
    }
    else if (button.tag == 13) {
        
    }
    else if (button.tag == 14) {
        //显示表情
        [self showFaceView];
    }
    else if (button.tag == 15) {
        //显示键盘
        [self showKeyboard];
    }
}

//全屏放大图片
- (void)imageAction:(UIButton *)button {
    if (_fullImageView == nil) {
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _fullImageView.backgroundColor = [UIColor blackColor];
        _fullImageView.userInteractionEnabled = YES;
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImageAction:)];
        [_fullImageView addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        //创建删除按钮
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setImage:[UIImage imageNamed:@"trash.png"] forState:UIControlStateNormal];
        deleteButton.frame = CGRectMake(280, 40, 20, 26);
        deleteButton.tag = 100;
        [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        deleteButton.hidden = YES;
        [_fullImageView addSubview:deleteButton];
    }
    
    [self.textView resignFirstResponder];
    
    if (![_fullImageView superview]) {
        _fullImageView.image = self.image;
        
        _fullImageView.frame = CGRectMake(5, ScreenHeight - 250, 20, 20);
        [UIView animateWithDuration:0.5 animations:^{
            _fullImageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        } completion:^(BOOL finished) {
            [UIApplication sharedApplication].statusBarHidden = YES;
            [_fullImageView viewWithTag:100].hidden = NO;
        }];
        [self.view.window addSubview:_fullImageView];
    }
}

//缩小图片
- (void)scaleImageAction:(UIGestureRecognizer *)gesture {
    [_fullImageView viewWithTag:100].hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        _fullImageView.frame = CGRectMake(5, ScreenHeight - 250, 20, 20);
    } completion:^(BOOL finished) {
        [_fullImageView removeFromSuperview];
    }];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    [self.textView becomeFirstResponder];
}

//删除图片
- (void)deleteAction:(UIButton *)deleteButton {
    //缩小图片
    [self scaleImageAction:nil];
    //删除图片
    self.image = nil;
    //移除缩略图按钮
    [self.sengImageButton removeFromSuperview];
    
    UIButton *button1 = [_buttons objectAtIndex:0];
    UIButton *button2 = [_buttons objectAtIndex:1];
    [UIView animateWithDuration:0.5 animations:^{
        button1.transform = CGAffineTransformIdentity;
        button2.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - data
- (void)doSendData {
    [self showStatusTip:YES title:@"发送中..."];
    
    NSString *text = self.textView.text;
    if (text.length == 0) {
        NSLog(@"微博内容为空");
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:text forKey:@"status"];
    if (self.longitude.length > 0) {
        [params setObject:self.longitude forKey:@"long"];
    }
    if (self.latitude.length > 0) {
        [params setObject:self.latitude forKey:@"lat"];
    }
    
    //不带图
    if (self.image == nil) {
        [self.sinaweibo requestWithURL:@"statuses/update.json" params:params httpMethod:@"POST" delegate:self];
    }
    //带图
    else {
        NSData *data = UIImageJPEGRepresentation(self.image, 0.6);
        [params setObject:data forKey:@"pic"];
        [self.sinaweibo requestWithURL:@"statuses/upload.json" params:params httpMethod:@"POST" delegate:self];
    }
    
}

#pragma mark - UITextView delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self showKeyboard];
    
    return YES;
}

#pragma mark - UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex == 0) {
        //判断是否有摄像头
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此设备没有摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            [alertView release];
            return;
        }else {
            sourceType = UIImagePickerControllerSourceTypeCamera;
        }
    }
    else if (buttonIndex == 1) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else if (buttonIndex == 2) {
        
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = sourceType;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:NULL];
    [imagePicker release];
}

#pragma mark - UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    if (self.sengImageButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.frame = CGRectMake(5, 20, 25, 25);
        [button addTarget:self action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
        self.sengImageButton = button;
    }
    
    [self.sengImageButton setImage:self.image forState:UIControlStateNormal];
    [self.editorBar addSubview:self.sengImageButton];
    UIButton *button1 = [_buttons objectAtIndex:0];
    UIButton *button2 = [_buttons objectAtIndex:1];
    [UIView animateWithDuration:0.5 animations:^{
        button1.transform = CGAffineTransformTranslate(button1.transform, 20, 0);
        button2.transform = CGAffineTransformTranslate(button2.transform, 5, 0);
    }];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - SinaWeiboRequest delegate
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    [self showStatusTip:NO title:@"发送成功"];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - NSNotification
- (void)keyboardShowNotification:(NSNotification *)notification {
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [value CGRectValue];
    self.editorBar.bottom = ScreenHeight - frame.size.height - 20 -44;
    self.textView.height = self.editorBar.top;
}

#pragma mark - Memory Managerment
- (void)dealloc {
    [_faceScrollView release];
    [_textView release];
    [_editorBar release];
    [_placeView release];
    [_placeBackgroundView release];
    [_placeLabel release];
    [super dealloc];
}
@end

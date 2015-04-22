#import "BaseViewController.h"
#import "WXFaceScrollView.h"

@interface SendViewController : BaseViewController<SinaWeiboRequestDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextViewDelegate> {
    NSMutableArray *_buttons;
    UIImageView *_fullImageView;
    
    //表情视图
    WXFaceScrollView *_faceScrollView;
}

//发微博所需要的属性
@property (copy, nonatomic) NSString *latitude;
@property (copy, nonatomic) NSString *longitude;
@property (retain, nonatomic) UIImage *image;

@property (retain, nonatomic) UIButton *sengImageButton;
@property (retain, nonatomic) IBOutlet UITextView *textView;
@property (retain, nonatomic) IBOutlet UIView *editorBar;
@property (retain, nonatomic) IBOutlet UIView *placeView;
@property (retain, nonatomic) IBOutlet UIImageView *placeBackgroundView;
@property (retain, nonatomic) IBOutlet UILabel *placeLabel;

- (void)selectImage;
@end

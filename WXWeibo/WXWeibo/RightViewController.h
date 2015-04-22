#import "BaseViewController.h"

@interface RightViewController : BaseViewController <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (retain, nonatomic) UIImage *image;
@property (retain, nonatomic) UIButton *sengImageButton;

- (IBAction)sendAction:(id)sender;
@end

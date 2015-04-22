#import <Foundation/Foundation.h>
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"

@interface UIFactory : NSObject

//创建button
+ (ThemeButton *)createButton:(NSString *)imageName highlighted:(NSString *)highlightedName;
+ (ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName
                                backgroundHighlighted:(NSString *)highlightedName;

//创建ImageView
+ (ThemeImageView *)createImageView:(NSString *)imageName;

//创建Label
+ (ThemeLabel *)createLabel:(NSString *)colorName;

//根据主题创建Navigation Button
+ (UIButton *)createNavigationButton:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action;
@end

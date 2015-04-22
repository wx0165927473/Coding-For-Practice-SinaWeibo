#import <UIKit/UIKit.h>

@interface ThemeLabel : UILabel

@property(nonatomic,copy)NSString *colorName;

- (id)initWithColorName:(NSString *)colorName;

@end

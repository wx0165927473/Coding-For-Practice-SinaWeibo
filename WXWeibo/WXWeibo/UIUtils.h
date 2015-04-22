#import <Foundation/Foundation.h>

@interface UIUtils : NSObject

//获取documents下的文件路径
+ (NSString *)getDocumentsPath:(NSString *)fileName;

// date 格式化为 string
+ (NSString*) stringFromFomate:(NSDate*)date formate:(NSString*)formate;
// string 格式化为 date
+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate;
//以上俩个合一了
+ (NSString *)fomateString:(NSString *)datestring;

//解析文本,显示超链接
+ (NSString *)parseLink:(NSString *)text;


@end

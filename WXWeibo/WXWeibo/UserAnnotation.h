#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "UserModel.h"

@interface UserAnnotation : NSObject <MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, retain) UserModel *userModel;

- (id)initWithUserModel:(UserModel *)userModel;
@end

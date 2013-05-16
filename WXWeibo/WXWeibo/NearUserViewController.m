//
//  NearUserViewController.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-16.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "NearUserViewController.h"
#import "UserModel.h"
#import "UserAnnotation.h"
#import "UserAnnotationView.h"
#import "UserViewController.h"

@interface NearUserViewController ()

@end

@implementation NearUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManager delegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
    
    [manager stopUpdatingLocation];
    
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    
	MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region animated:YES];
    
    if (self.data == nil) {
        NSString *longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
        NSString *latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:longitude,@"long",latitude,@"lat", nil];
        
        [self.sinaweibo requestWithURL:@"place/nearby/users.json" params:params httpMethod:@"GET" delegate:self];

    }
}

#pragma mark - SinaWeiboRequest
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    
        //附近的人
        NSArray *users = [result objectForKey:@"users"];
        NSMutableArray *useres = [NSMutableArray arrayWithCapacity:users.count];
        for (int i=0; i<users.count; i++) {
            NSDictionary *statusDic = [users objectAtIndex:i];
            UserModel *user = [[UserModel alloc] initWithDataDic:statusDic];
            [useres addObject:user];
            [user release];
            
            //创建Anatation对象，添加到地图上
            UserAnnotation *userAnnotation = [[UserAnnotation alloc] initWithUserModel:user];
            [self.mapView performSelector:@selector(addAnnotation:) withObject:userAnnotation afterDelay:i*0.1];
            [userAnnotation release];
    }
}

#pragma mark - MKAnnotationView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *indentify = @"UserAnnotationView";
    UserAnnotationView *userAnnotationView = (UserAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:indentify];
    if (userAnnotationView == nil) {
        userAnnotationView = [[[UserAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:indentify] autorelease];
    }
    
    return userAnnotationView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    for (UIView *annotationView in views) {
        CGAffineTransform transform = annotationView.transform;
        annotationView.transform = CGAffineTransformScale(transform, 0.7, 0.7);
        annotationView.alpha = 0;
        
        [UIView animateWithDuration:0.4 animations:^{
            annotationView.transform = CGAffineTransformScale(transform, 1.3, 1.3);
            annotationView.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.4 animations:^{
                annotationView.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(UserAnnotationView *)view {
    UserViewController *userVC = [[UserViewController alloc] init];
    userVC.userID = view.userModel.idstr;
    [self.navigationController pushViewController:userVC animated:YES];
    [userVC release];
}

- (void)dealloc {
    [_mapView release];
    [super dealloc];
}
@end

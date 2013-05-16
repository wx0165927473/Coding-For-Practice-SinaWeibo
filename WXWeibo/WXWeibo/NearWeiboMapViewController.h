//
//  NearWeiboMapViewController.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-16.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NearWeiboMapViewController : BaseViewController <SinaWeiboRequestDelegate,CLLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic, retain) NSArray *data;

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@end

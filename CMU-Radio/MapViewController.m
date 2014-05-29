//
//  MapViewController.m
//  CMU-Radio
//
//  Created by Narota, Amninder Singh on 11/13/13.
//  Copyright (c) 2013 Narota, Amninder Singh. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController ()

@end

@implementation MapViewController{
    GMSMapView *mapView_;
    UIViewController *enrollViewController;
}
@synthesize test;
@synthesize viewTest;

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
    [enrollViewController.view setFrame:CGRectMake(0, 0, 320, 440)];
	
    @try {
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                                longitude:151.20
                                                                     zoom:6];
        mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        mapView_.myLocationEnabled = YES;
        self.view = mapView_;
        
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
        marker.title = @"Sydney";
        marker.snippet = @"Australia";
        marker.map = mapView_;
    }
    @catch (NSException *exception) {
        NSLog(@"EXCEPTION:\n%@\n\n", exception);
    }
    @finally {
        NSLog(@"Finally");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

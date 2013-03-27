//
//  ViewController.m
//  maps
//
//  Created by Mark Mevorah on 3/22/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    GMSMapView *map_;
}

@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"Hello");
    latitude = 40.419345;
    longitude = -74.411001;
    bearing = 0;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude 
                                                            longitude:longitude                                                              zoom:30
                                                              bearing:bearing
                                                         viewingAngle:45];
    
    
    map_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, 320, 548) camera:camera];
    map_.myLocationEnabled = YES;
    [self.view addSubview:map_];
    [self.view addSubview:mapView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)upButton:(UIButton *)sender {
    latitude += .0001;
    [map_ animateToLocation:CLLocationCoordinate2DMake(latitude, longitude)];
}

- (IBAction)downButton:(UIButton *)sender {
    latitude -= .0001;
    [map_ animateToLocation:CLLocationCoordinate2DMake(latitude, longitude)];
}

- (IBAction)leftButton:(UIButton *)sender {
    bearing -= 1;
    [map_ animateToBearing:bearing];
}

- (IBAction)rightButton:(UIButton *)sender {
    bearing += 1;
    [map_ animateToBearing:bearing];
}





@end

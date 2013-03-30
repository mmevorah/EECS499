//
//  GameViewController.m
//  Mevorah Grand Prix
//
//  Created by Mark Mevorah on 3/30/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController{
    GMSMapView *mapView_;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        double latitude = 40.419345;
        double longitude = -74.411001;
        double bearing = 0;
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                                longitude:longitude                                                              zoom:30
                                                                  bearing:bearing
                                                             viewingAngle:45];
        
        
        mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, 320, 548) camera:camera];
        mapView_.myLocationEnabled = YES;
        [self.view addSubview:mapView_];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

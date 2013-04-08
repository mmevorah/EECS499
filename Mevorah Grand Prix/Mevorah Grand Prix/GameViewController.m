//
//  GameViewController.m
//  Mevorah Grand Prix
//
//  Created by Mark Mevorah on 3/30/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import "GameViewController.h"
#import "UIViewColorOfPoint.h"

@interface GameViewController ()

@end

@implementation GameViewController{
    GMSMapView *mapView_;
}
@synthesize controllerView;
@synthesize clock;
@synthesize camera;

@synthesize car = car_;

@synthesize accellerateButton;
@synthesize reverseButton;
@synthesize leftButton;
@synthesize rightButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    double latitude = 42.271291;
    double longitude = -83.729918;
    double bearing = 0;
    
    checkPixelInterval = 0;
    
    camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude                                                              zoom:19
                                                              bearing:bearing
                                                         viewingAngle:0];
    
    
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, 480, 300) camera:camera];
    mapView_.myLocationEnabled = NO;
    [self.view addSubview:mapView_];
    [self.view addSubview:controllerView];
    car_ = [[Car alloc] initWithFrame:CGRectMake(240, 150, 10, 20) withImage:[UIImage imageNamed:@"carA.png"]];
    [self.view addSubview:car_];
    clock = [NSTimer scheduledTimerWithTimeInterval:(1/20)
                                             target:self
                                           selector:@selector(update)
                                           userInfo:nil
                                            repeats:YES];
    
    

}

-(void)update{
    if(accellerateButton.state == UIControlStateHighlighted) [car_ accellerate];
    if(reverseButton.state == UIControlStateHighlighted) [car_ reverse];
    if(leftButton.state == UIControlStateHighlighted) [car_ turnLeft];
    if(rightButton.state == UIControlStateHighlighted) [car_ turnRight];
    
    checkPixelInterval++;
    if(checkPixelInterval == 40){
        checkPixelInterval = 0;
        [self.view colorOfPoint:CGPointMake(240, 150)];
    }
    
    [car_ updateValues];
    
//    NSLog(@"Velocity X: %f, Velocity Y: %f", engine.velocityX, engine.velocityY);
  //  [mapView_ animateToCameraPosition:[GMSCameraPosition cameraWithLatitude:engine.positionY longitude:engine.positionX zoom:18.5 bearing:engine.angle viewingAngle:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (IBAction)accellerate:(UIButton *)sender {
    [car_ accellerate];
}*/

@end

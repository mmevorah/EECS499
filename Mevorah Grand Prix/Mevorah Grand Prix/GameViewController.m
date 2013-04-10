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
@synthesize bounds;

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

    cameraPosition = CLLocationCoordinate2DMake(42.271291, -83.729918);
    moveDistance = .00055;

    checkPixelInterval = 0;
    
    camera = [GMSCameraPosition cameraWithLatitude:cameraPosition.latitude
                                        longitude:cameraPosition.longitude
                                              zoom:19
                                           bearing:0
                                      viewingAngle:0];
    
    
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, 480, 300) camera:camera];
    mapView_.myLocationEnabled = NO;
    [self.view addSubview:mapView_];
    [self.view addSubview:controllerView];
    car_ = [[Car alloc] initWithFrame:CGRectMake(240, 150, 7, 13) withImage:[UIImage imageNamed:@"carA-01.png"]];
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
    //    UIColor *color = [self.view colorOfPoint:CGPointMake(car_.frame.origin.x, car_.frame.origin.y-(car_.frame.size.height/2)-1)];
        for(int i = 0; i < bounds.count; i++){
        }
    }
    
    
    if(car_.frame.origin.y <= 40){
        cameraPosition = CLLocationCoordinate2DMake(cameraPosition.latitude + moveDistance, cameraPosition.longitude);
        [self moveCamera:CGPointMake(1, 0)];
    }else if(car_.frame.origin.y >= 260){
        cameraPosition = CLLocationCoordinate2DMake(cameraPosition.latitude - moveDistance, cameraPosition.longitude);
        [self moveCamera:CGPointMake(-1, 0)];
    }else if(car_.frame.origin.x <= 40){
        cameraPosition = CLLocationCoordinate2DMake(cameraPosition.latitude, cameraPosition.longitude - moveDistance);
        [self moveCamera:CGPointMake(0, 1)];
    }else if(car_.frame.origin.x >= 420){
        cameraPosition = CLLocationCoordinate2DMake(cameraPosition.latitude, cameraPosition.longitude + moveDistance);
        [self moveCamera:CGPointMake(0, -1)];
    }
    
    [car_ updateValues];
    
//    NSLog(@"Velocity X: %f, Velocity Y: %f", engine.velocityX, engine.velocityY);
  //  [mapView_ animateToCameraPosition:[GMSCameraPosition cameraWithLatitude:engine.positionY longitude:engine.positionX zoom:18.5 bearing:engine.angle viewingAngle:0]];
}

-(void)moveCamera:(CGPoint)movement{
    [mapView_ animateToLocation:cameraPosition];
    [car_ cameraMoved:movement];
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

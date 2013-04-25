//
//  GameViewController.m
//  Mevorah Grand Prix
//
//  Created by Mark Mevorah on 3/30/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import "GameViewController.h"
#import "UIViewColorOfPoint.h"
#import "UIImageColorOfPoint.h"

@interface GameViewController ()

@end

@implementation GameViewController{
    GMSMapView *mapView_;
}

@synthesize controllerView;
@synthesize updateClock;
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
    
    //Start Zoomed Out
    
    cameraPosition = CLLocationCoordinate2DMake(42.271291, -83.729918);
    moveDistance = .00055;
    camera = [GMSCameraPosition cameraWithLatitude:cameraPosition.latitude
                                        longitude:cameraPosition.longitude
                                              zoom:19
                                           bearing:0
                                      viewingAngle:0];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, 480, 300) camera:camera];
    mapView_.myLocationEnabled = NO;
    
    [self.view addSubview:mapView_];
    
    car_ = [[Car alloc] initWithFrame:CGRectMake(240, 150, 13, 29) withImage:[UIImage imageNamed:@"carA-01.png"]];
    [self.view addSubview:car_];
    
    [self.view addSubview:controllerView];

    updateClock = [NSTimer scheduledTimerWithTimeInterval:(1/20)
                                             target:self
                                           selector:@selector(update)
                                           userInfo:nil
                                            repeats:YES];
    
    [self performSelector:@selector(chooseStartLocation)];
}

-(void)chooseStartLocation{
    //Wait for touch event
    //break
    //Record loction of touch, get long and lat
    //animate to that camera position, long, lat, zoom 19
    //begin update clock
    
    //if free ride
    //console prints enjoy
    
   // if(playing){
   //     [self performSelector:@selector(startGame) withObject:nil afterDelay:1];
   // }
}

-(void)startGame{
    //set first destination
    //calculate direction ahead to the right
    
    //call reset values
    //perform stop light animation
    //start updating
}

/*
-(void)setDestination{
    pause clock
    print in console "you made it to your location"
    pause two seconds
    take the current destination and generate new location based off this
    print "now go to  [destination]" to console, adress through reverse geocoding
    increase level by one
    increase clock time
    increase total time by same amount
    delay 2 seconds
    start clock again
 }
*/

/*
-(void)crashed{
    move to last safe location
    car can move = false for three seconds
 }
*/
 /*
-(void)resetValues{
 level = 0;
 clock = starting clock time
  total time = starting clock time
 }
*/

/*
-(void)gameOver{
    call reset values
    print message with total time
    set zoom to be far out again
    make button appear play again
        button calls choose start location
    or button go back to main menu
 }
*/
-(void)update{
    
    //if(timer <= 0) call game over function
    
    /* if playing
        update direction arrows in console view --> check car location relative to destination
            show arrows based on this
        
        check a crash, if crash call crashed{
            if level 0{ check hazardbox[0-8]
            else if level 1{ checkhazardBoz[0-15]       
                          2{                0-20
                          3{                0-25
        }
     
        update last safe location
     
        if car gets to destination, call get destination
    */
    //if(can Move){
    if(accellerateButton.state == UIControlStateHighlighted) [car_ accellerate];
    if(reverseButton.state == UIControlStateHighlighted) [car_ reverse];
    if(leftButton.state == UIControlStateHighlighted) [car_ turnLeft];
    if(rightButton.state == UIControlStateHighlighted) [car_ turnRight];
    //}
    
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
}

-(void)moveCamera:(CGPoint)movement{
    [mapView_ animateToLocation:cameraPosition];
    [car_ cameraMoved:movement];
    //Call carPool update hazards (int currentLevel);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

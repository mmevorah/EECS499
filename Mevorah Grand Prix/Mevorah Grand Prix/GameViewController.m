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
#include <stdlib.h>

@interface GameViewController ()

@end

@implementation GameViewController{
    GMSMapView *mapView_;
    GMSGeocoder *geoCoder_;
}

@synthesize controllerView;
@synthesize updateClock;
@synthesize camera;

@synthesize consoleView;
@synthesize nextDestinationAddress;

@synthesize car = car_;

@synthesize accellerateButton;
@synthesize reverseButton;
@synthesize leftButton;
@synthesize rightButton;

@synthesize consoleLabel;
@synthesize gameTimer;
@synthesize timerLabel;

@synthesize playAgainButton;
@synthesize mainMenuButton;

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
    
    startLocation = CLLocationCoordinate2DMake(42.271291, -83.729918);
    cameraPosition = startLocation;
    moveDistance = .00055;
    camera = [GMSCameraPosition cameraWithLatitude:cameraPosition.latitude
                                        longitude:cameraPosition.longitude
                                              zoom:15
                                           bearing:0
                                      viewingAngle:0];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, 480, 300) camera:camera];
    mapView_.myLocationEnabled = NO;
    [self.view addSubview:mapView_];
    geoCoder_ = [[GMSGeocoder alloc] init];

    car_ = [[Car alloc] initWithFrame:CGRectMake(240, 150, 13, 29) withImage:[UIImage imageNamed:@"carA-01.png"]];
    car_.hidden = true;
    [self.view addSubview:car_];
    [self.view addSubview:consoleView];
    [self.view addSubview:mainMenuButton];
    
    playing = true; //change to be set

    consoleLabel.text = @"Press a start location!";

    mapView_.delegate = self;
}

//Add directions/ game
//Add Hazards
//Add Crash
//Add zoom in

#pragma mark - GMSMapViewDelegate

-(void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate{
    mapView_.userInteractionEnabled = false;
    startLocation = coordinate;
    cameraPosition = startLocation;
    [mapView_ animateToCameraPosition:[GMSCameraPosition cameraWithTarget:coordinate
                                                                     zoom:19
                                                                  bearing:0
                                                             viewingAngle:0]];
    
    [self.view addSubview:controllerView];
    [self.view addSubview:playAgainButton];

    if(playing) [self performSelector:@selector(startGame) withObject:nil afterDelay:1];
}

-(void)startGame{
    canMove = false;
    car_.hidden = false;
    controllerView.hidden = false;
    [self resetValues];
    consoleLabel.text = @"Ready";
    nextDestination = [self setDestination];
    [self getLocationName:nextDestination];
    [self performSelector:@selector(preGame) withObject:nil afterDelay:5];
    canMove = true;
}

-(void)preGame{
    consoleLabel.text = [NSString stringWithFormat:@"Go to %@!", nextDestinationAddress];
    updateClock = [NSTimer scheduledTimerWithTimeInterval:(1/20)
                                                   target:self
                                                 selector:@selector(update)
                                                 userInfo:nil
                                                  repeats:YES];
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                 target:self
                                               selector:@selector(updateGameTimer)
                                               userInfo:nil
                                                repeats:YES];
}

-(void)arrivedAtDestination{
    [gameTimer invalidate];
    gameTimer = nil;
    canMove = false;
    consoleLabel.text = @"You made it!";
    
    nextDestination = [self setDestination];
    GMSMarkerOptions *options = [GMSMarkerOptions options];
    options.position = nextDestination;
    [mapView_ addMarkerWithOptions:options];
    //clock updated in above method
    [self getLocationName:nextDestination];
    level++;
    [self performSelector:@selector(beginNextTrip) withObject:nil afterDelay:2];
}

-(void)beginNextTrip{
    consoleLabel.text = [NSString stringWithFormat:@"Ok, now go to %@!", nextDestinationAddress];
    canMove = true;
    gameTimer = [NSTimer timerWithTimeInterval:1
                                        target:self
                                      selector:@selector(updateGameTimer)
                                      userInfo:nil
                                       repeats:YES];
}

-(CLLocationCoordinate2D)setDestination{
    double i = arc4random_uniform(50);
    double miles = (i/100)+.25;
    double distance = miles/69; //calculate magnitude in degrees
    int direction = arc4random_uniform(4);
    
    currentTime += car_.timeItTakesToDriveAMile * miles + 5;
    totalTime += car_.timeItTakesToDriveAMile * miles + 5;
    CLLocationCoordinate2D coordinate;
    
    if(direction == 0){ //north
        coordinate = CLLocationCoordinate2DMake(startLocation.latitude + distance, startLocation.longitude);
    }else if(direction == 1){ //east
        coordinate = CLLocationCoordinate2DMake(startLocation.latitude, startLocation.longitude + distance);
    }else if(direction == 2){ //south
        coordinate = CLLocationCoordinate2DMake(startLocation.latitude - distance, startLocation.longitude);
    }else{ //west
        coordinate = CLLocationCoordinate2DMake(startLocation.latitude, startLocation.longitude - distance);
    }
    
    NSLog(@"Next Destination: Distance: %f, Direction:%i", miles, direction);
    NSLog(@"Current Time: %i", currentTime);
    return coordinate;
}


/*
-(void)crashed{
    move to last safe location
    car can move = false for three seconds
 }
*/
 
-(void)resetValues{
    int startingTime = 15;  //to be tweaked in game mechanics
    level = 0;
    currentTime =  startingTime;
    totalTime = startingTime;
    [gameTimer invalidate];
    [updateClock invalidate];
}


-(void)gameOver{
    consoleLabel.text = [NSString stringWithFormat:@"Game Over, you lasted %i seconds", totalTime];
    [mapView_ animateToZoom:15];
    car_.hidden = true;
    controllerView.hidden = true;
    mainMenuButton.hidden = false;
    mainMenuButton.enabled = true;
    playAgainButton.hidden = false;
    playAgainButton.enabled = true;
 }

- (IBAction)playAgainButton:(UIButton *)sender {
    consoleLabel.text = @"Press a start location!";
    timerLabel.text = @"";
    playAgainButton.hidden = true;
    mainMenuButton.hidden = true;
    mapView_.userInteractionEnabled = true;
    mainMenuButton.enabled =false;
    playAgainButton.enabled = false;
    [self resetValues];
}


-(void)moveCamera:(CGPoint)movement{
    [mapView_ animateToLocation:cameraPosition];
    [car_ cameraMoved:movement];
    //Call carPool update hazards (int currentLevel);
}

-(void)update{
    
    
    /* if playing
        update direction arrows in console view --> check car location relative to destination
            show arrows based on this
     NEED to mae graphics fr this
        
        check a crash, if crash call crashed{
            if level 0{ check hazardbox[0-8]
            else if level 1{ checkhazardBoz[0-15]       
                          2{                0-20
                          3{                0-25
        }
     
        update last safe location
     
        if car gets to destination, call get destination
    */
    
    if(canMove){
        if(accellerateButton.state == UIControlStateHighlighted) [car_ accellerate];
        if(reverseButton.state == UIControlStateHighlighted) [car_ reverse];
        if(leftButton.state == UIControlStateHighlighted) [car_ turnLeft];
        if(rightButton.state == UIControlStateHighlighted) [car_ turnRight];
    }
    
    
    //NEED TO FIX THIS CAR MOVEMENT AND PIXEL-COORDINATE TRANSLATION
    //SOO LOOK INTO MOVE DISTANCE
    
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

-(void)updateGameTimer{
    currentTime -= 1;
    int minutes = 0;
    int seconds = 0;
    if(currentTime >= 0){
        minutes = (currentTime % 3600) / 60;
        seconds = (currentTime %3600) % 60;
        timerLabel.text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    }else{
        timerLabel.text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
        [self gameOver];
    }
}

-(void)getLocationName:(CLLocationCoordinate2D)coordinate{
    GMSReverseGeocodeCallback handler =
    ^(GMSReverseGeocodeResponse *response, NSError *error){
        if (response && response.firstResult) {
            nextDestinationAddress = [NSString stringWithString:response.firstResult.addressLine1];
        } else {
            NSLog(@"Could not reverse geocode point (%f,%f): %@",
                  coordinate.latitude, coordinate.longitude, error);
        }
    };
    [geoCoder_ reverseGeocodeCoordinate:coordinate
                      completionHandler:handler];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

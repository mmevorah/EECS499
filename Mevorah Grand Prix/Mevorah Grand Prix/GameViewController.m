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
    
    [self.view addSubview:consoleView];
    
    playing = true; //change to be set

    consoleLabel.text = @"Press a start location!";

    mapView_.delegate = self;
}

//Add directions/ game
//Add Hazards
//Add Crash
//Add zoom in


-(void)newGame{
    
}

#pragma mark - GMSMapViewDelegate

-(void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate{
    mapView_.userInteractionEnabled = false;
    startLocation = coordinate;
    [mapView_ animateToCameraPosition:[GMSCameraPosition cameraWithTarget:coordinate
                                                                     zoom:19
                                                                  bearing:0
                                                             viewingAngle:0]];

    if(playing) [self performSelector:@selector(startGame) withObject:nil afterDelay:1];
}

-(void)startGame{
    canMove = false;
    nextDestination = CLLocationCoordinate2DMake(42.272351, -83.72987); //need to change it to something relative to last location
    [self.view addSubview:car_];
    [self.view addSubview:controllerView];
    [self resetValues];
    consoleLabel.text = @"Ready?!";
    [self getLocationName:nextDestination];
    [self performSelector:@selector(preGame) withObject:nil afterDelay:5];
    canMove = true;
}

-(void)preGame{
    consoleLabel.text = [NSString stringWithFormat:@"Go to %@", nextDestinationAddress]; //Make go to location: determined by reverse geocoding
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

-(void)setDestination{
    [gameTimer invalidate];
    gameTimer = nil;
    //reset timer at the current time

    /*
    print in console "you made it to your location"
    pause two seconds
    take the current destination and generate new location based off this
    print "now go to  [destination]" to console, adress through reverse geocoding
    increase level by one
    increase clock time
    increase total time by same amount
    delay 2 seconds
    start clock again
     */
 }


/*
-(void)crashed{
    move to last safe location
    car can move = false for three seconds
 }
*/
 
-(void)resetValues{
    int startingTime = 20;  //to be tweaked in game mechanics
    level = 0;
    currentTime =  startingTime;
    totalTime = startingTime;
}



-(void)gameOver{
    consoleLabel.text = [NSString stringWithFormat:@"Game Over, you lasted %i seconds", totalTime];
    //set zoom to be far out again
    //make button appear play again
        //button calls choose start location
    //or button go back to main menu
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
        
        check a crash, if crash call crashed{
            if level 0{ check hazardbox[0-8]
            else if level 1{ checkhazardBoz[0-15]       
                          2{                0-20
                          3{                0-25
        }
     
        update last safe location
     
        if car gets to destination, call get destination
    */
    /*
    if(canMove){
        if(accellerateButton.state == UIControlStateHighlighted) [car_ accellerate];
        if(reverseButton.state == UIControlStateHighlighted) [car_ reverse];
        if(leftButton.state == UIControlStateHighlighted) [car_ turnLeft];
        if(rightButton.state == UIControlStateHighlighted) [car_ turnRight];
    }
    
    
    //NEED TO FIX THIS CAR MOVEMENT AND PIXEL-COORDINATE TRANSLATION
    //FIND OUT HOW MUCH A PIXEL AT THIS ZOOM LEVEL COMPARES TO A DEGREE
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
    
    [car_ updateValues];*/
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

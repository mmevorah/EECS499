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
@synthesize game;

@synthesize accellerateButton;
@synthesize reverseButton;
@synthesize leftButton;
@synthesize rightButton;

@synthesize consoleLabel;
@synthesize gameTimer;
@synthesize timerLabel;
@synthesize distanceLabel;
@synthesize directionLabel;
@synthesize livesLabel;
@synthesize nameInput;
@synthesize saveButton;

@synthesize playAgainButton;

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
    
    //Plist Setup
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *plistPath = [docDir stringByAppendingPathComponent:@"highScore.plist"];
    if([[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        NSLog(@"[FOUND PLIST For ID Manager]");
        highScores = [NSMutableArray arrayWithContentsOfFile:plistPath];
        highScore = [highScores objectAtIndex:0];
        highScoreName = [highScores objectAtIndex:1];
    }else
    {
        NSLog(@"[COULD NO FIND PLIST For ID Manager] CREATING A NEW ONE");
        highScores = [[NSMutableArray alloc] init];
        highScore = [[NSNumber alloc] initWithInt:0];
        highScoreName = [[NSString alloc] initWithFormat:@"Mark Mevorah"];
        [highScores addObject:highScore];
        [highScores addObject:highScoreName];
    }
    
    //Start Zoomed Out
    startLocation = CLLocationCoordinate2DMake(42.271291, -83.729918);
    cameraPosition = startLocation;
    moveDistanceY = .00055;
    moveDistanceX = .0009;
    camera = [GMSCameraPosition cameraWithLatitude:cameraPosition.latitude
                                        longitude:cameraPosition.longitude
                                              zoom:15
                                           bearing:0
                                      viewingAngle:0];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, 480, 300) camera:camera];
    mapView_.myLocationEnabled = NO;
    [self.view addSubview:mapView_];
    geoCoder_ = [[GMSGeocoder alloc] init];
    
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

    car_ = [[Car alloc] initWithFrame:CGRectMake(240, 150, 20, 40) withImage:[UIImage imageNamed:@"zeppelin-01.png"]];
    car_.hidden = true;
    
    game = [[carPool alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
        
    [self.view addSubview:consoleView];
    
    consoleLabel.text = @"Press a start location!";
    
    lives = 3;
    justCrashed = false;
    
    distanceLabel.hidden = true;
    directionLabel.hidden = true;
    
    mapView_.delegate = self;
}

//Game Dialog
//Add sound
//Add Crash

#pragma mark - GMSMapViewDelegate

-(void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate{
    mapView_.userInteractionEnabled = false;
    startLocation = coordinate;
    cameraPosition = startLocation;
    
    [mapView_ animateToCameraPosition:[GMSCameraPosition cameraWithTarget:coordinate
                                                                     zoom:19
                                                                  bearing:0
                                                             viewingAngle:0]];
    [self.view addSubview:game];
    [self.view addSubview:car_];
    [self.view addSubview:controllerView];
    [self.view addSubview:playAgainButton];

    [self performSelector:@selector(startGame) withObject:nil afterDelay:1];
}

-(void)startGame{
    canMove = false;
    car_.hidden = false;
    controllerView.hidden = false;
    
    distanceLabel.hidden = false;
    directionLabel.hidden = false;
    
    [self resetValues];
    consoleLabel.text = @"Ready";
    
    nextDestination = [self setDestination];
    
    GMSMarkerOptions *options = [GMSMarkerOptions options];
    options.position = nextDestination;
    [mapView_ addMarkerWithOptions:options];
    [self getLocationName:nextDestination];
    [self performSelector:@selector(preGame) withObject:nil afterDelay:5];
}

-(void)preGame{
    consoleLabel.text = [NSString stringWithFormat:@"Go to %@!", nextDestinationAddress];
    double distFromDest = sqrt(pow(cameraPosition.latitude - nextDestination.latitude, 2) + pow(cameraPosition.longitude - nextDestination.longitude, 2));
    distanceLabel.text = [NSString stringWithFormat:@"%0.2f mi", distFromDest*69];
    [self generateDirection];
    livesLabel.text = [NSString stringWithFormat:@"Lives: %i", lives];

    justCrashed = true;
    canMove = true;
    shouldTime = true;
}

-(void)arrivedAtDestination{
    shouldTime = false;    
    canMove = false;
    consoleLabel.text = @"You made it!";
    
    startLocation = nextDestination;
    nextDestination = [self setDestination];
       
    GMSMarkerOptions *options = [GMSMarkerOptions options];
    options.position = nextDestination;
    [mapView_ addMarkerWithOptions:options];
    
    //zoom out to show next location
    [mapView_ animateToZoom:15];
    //clock updated in above method
    
    level++;
    lives++;
    car_.hidden = true;
    game.hidden = true;
    
    [self getLocationName:nextDestination];
    [self performSelector:@selector(beginNextTrip) withObject:nil afterDelay:8];
}

-(void)beginNextTrip{
    //zoom back in
    [mapView_ animateToZoom:19];
    car_.hidden = false;
    game.hidden = false;
    [mapView_ clear];
    
    GMSMarkerOptions *options = [GMSMarkerOptions options];
    options.position = nextDestination;
    [mapView_ addMarkerWithOptions:options];
    
    consoleLabel.text = [NSString stringWithFormat:@"Ok, now go to %@!", nextDestinationAddress];
    double distFromDest = sqrt(pow(cameraPosition.latitude - nextDestination.latitude, 2) + pow(cameraPosition.longitude - nextDestination.longitude, 2));
    distanceLabel.text = [NSString stringWithFormat:@"%0.2f mi", distFromDest*69];
    [self generateDirection];
    livesLabel.text = [NSString stringWithFormat:@"Lives: %i", lives];
    
    canMove = true;
    shouldTime = true;
}



-(CLLocationCoordinate2D)setDestination{
    double i = arc4random_uniform(50);
    double miles = (i/100)+.20;
    double distance = miles/69; //calculate magnitude in degrees
    int direction = arc4random_uniform(7);
    
    currentTime += car_.timeItTakesToDriveAMile * miles + 5;
    CLLocationCoordinate2D coordinate;
    
    if(direction == 0){ //north
        coordinate = CLLocationCoordinate2DMake(startLocation.latitude + distance, startLocation.longitude);
    }else if(direction == 1){ //east
        coordinate = CLLocationCoordinate2DMake(startLocation.latitude, startLocation.longitude + distance);
    }else if(direction == 2){ //south
        coordinate = CLLocationCoordinate2DMake(startLocation.latitude - distance, startLocation.longitude);
    }else if(direction == 3){ //west
        coordinate = CLLocationCoordinate2DMake(startLocation.latitude, startLocation.longitude - distance);
    }else if(direction == 4){ //north east
        coordinate = CLLocationCoordinate2DMake(startLocation.latitude + (distance/2), startLocation.longitude + (distance/2));
    }else if(direction == 5){ //south east
        coordinate = CLLocationCoordinate2DMake(startLocation.latitude - (distance/2), startLocation.longitude + (distance/2));
    }else if(direction == 6){ //south west
        coordinate = CLLocationCoordinate2DMake(startLocation.latitude - (distance/2), startLocation.longitude - (distance/2));
    }else{ //north west
        coordinate = CLLocationCoordinate2DMake(startLocation.latitude + (distance/2), startLocation.longitude - (distance)/2);
    }
    
    
    NSLog(@"Next Destination: Distance: %f, Direction:%i", miles, direction);
    NSLog(@"Current Time: %i", currentTime);
    return coordinate;
}



-(void)crashed{
    consoleLabel.text = @"CRASHED!";
    shouldTime = false;
    canMove = false;
    lives--;
    justCrashed = true;
    game.hidden = true;
    [self performSelector:@selector(afterCrash) withObject:nil afterDelay:4];
 }

-(void)afterCrash{
    if(lives == 0){ [self gameOver];
    }else{
        canMove = true;
        shouldTime = true;
        consoleLabel.text = [NSString stringWithFormat:@"Ok, now go to %@!", nextDestinationAddress];
        livesLabel.text = [NSString stringWithFormat:@"Lives: %i", lives];
    }
}


-(void)resetValues{
    int startingTime = 15;  //to be tweaked in game mechanics
    level = 0;
    lives = 3;
    currentTime =  startingTime;
    totalTime = 0;
    [mapView_ clear];
}


-(void)gameOver{
    consoleLabel.text = [NSString stringWithFormat:@"Game Over, you lasted %i seconds", totalTime];
    [mapView_ animateToZoom:15];
 
    car_.hidden = true;
    game.hidden = true;
    car_.frame = CGRectMake(240, 150, 13, 29);
    
    controllerView.hidden = true;
    distanceLabel.hidden = true;
    distanceLabel.text = @"";
    directionLabel.hidden = true;
    directionLabel.text = @"";
    timerLabel.text = @"";
    livesLabel.text = @"";

    shouldTime = false;
   
    int blah = [highScore integerValue];
    if(totalTime > blah){
        [self highScore];
    }else{
        playAgainButton.hidden = false;
        playAgainButton.enabled = true;
    }
 }

- (IBAction)playAgainButton:(UIButton *)sender {
    consoleLabel.text = @"Press a start location!";
    timerLabel.text = @"";
    
    playAgainButton.hidden = true;
    playAgainButton.enabled = false;
    
    mapView_.userInteractionEnabled = true;
    
    [game removeFromSuperview];
    game.hidden = true;
    [car_ removeFromSuperview];
    [controllerView removeFromSuperview];

    [self resetValues];
}

-(void)highScore{
    consoleLabel.text = [NSString stringWithFormat:@"You beat %@'s high score!", highScoreName];
    nameInput.hidden = false;
    saveButton.hidden = false;
        
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *plistPath = [docDir stringByAppendingPathComponent:@"productID.plist"];
    
    NSLog(@"Highscore contains: %@", highScores);
    NSNumber *foo = [NSNumber numberWithInt:totalTime];
    [highScores replaceObjectAtIndex:0 withObject:foo];
    
    NSString *name = nameInput.text;
    [highScores replaceObjectAtIndex:1 withObject:name];
    
    [highScores writeToFile:plistPath atomically:YES];
}

- (IBAction)save:(id)sender {
    [self.view endEditing:true];
    nameInput.hidden = true;
    saveButton.hidden = true;
    playAgainButton.hidden = false;
    playAgainButton.enabled = true;
}

-(void)generateDirection{
    //North -> SE
    
    if((cameraPosition.latitude > nextDestination.latitude + .0005) &&
       (cameraPosition.longitude < (nextDestination.longitude + .0005)) &&
       (cameraPosition.longitude > (nextDestination.longitude - .0005))){
        directionLabel.text = [NSString stringWithFormat:@"S"];
    }else if((cameraPosition.latitude > (nextDestination.latitude + .0005)) &&
             (cameraPosition.longitude > (nextDestination.longitude + .0005))){
        directionLabel.text = [NSString stringWithFormat:@"SW"];
    }else if((cameraPosition.latitude < (nextDestination.latitude + .0005)) &&
             (cameraPosition.latitude > (nextDestination.latitude - .0005)) &&
             (cameraPosition.longitude > (nextDestination.longitude + .0005))){
        directionLabel.text = [NSString stringWithFormat:@"W"];
    }else if((cameraPosition.latitude < (nextDestination.latitude - .0005)) &&
             (cameraPosition.longitude > (nextDestination.longitude + .0005))){
        directionLabel.text = [NSString stringWithFormat:@"NW"];
    }else if((cameraPosition.latitude < nextDestination.latitude - .0005) &&
             (cameraPosition.longitude < (nextDestination.longitude + .0005)) &&
             (cameraPosition.longitude > (nextDestination.longitude - .0005))){
        directionLabel.text = [NSString stringWithFormat:@"N"];
    }else if((cameraPosition.latitude < (nextDestination.latitude - .0005)) &&
             (cameraPosition.longitude < (nextDestination.longitude - .0005))){
        directionLabel.text = [NSString stringWithFormat:@"NE"];
    }else if((cameraPosition.latitude < (nextDestination.latitude + .0005)) &&
             (cameraPosition.latitude > (nextDestination.latitude - .0005)) &&
             (cameraPosition.longitude < (nextDestination.longitude - .0005))){
        directionLabel.text = [NSString stringWithFormat:@"E"];
    }else if((cameraPosition.latitude > (nextDestination.latitude + .0005)) &&
             (cameraPosition.longitude < (nextDestination.longitude - .0005))){
        directionLabel.text = [NSString stringWithFormat:@"SE"];
    }
}

-(void)moveCamera:(CGPoint)movement{
    [mapView_ animateToLocation:cameraPosition];
    [car_ cameraMoved:movement];
    
    game.hidden = false;
    [game switchedView:level];
    
    justCrashed = false;
    
    //MAKE THIS MORE SPECIFIC
    double distFromDest = sqrt(pow(cameraPosition.latitude - nextDestination.latitude, 2) + pow(cameraPosition.longitude - nextDestination.longitude, 2));
    distanceLabel.text = [NSString stringWithFormat:@"%0.2f mi", distFromDest*69];
    if(distFromDest < .0006) [self arrivedAtDestination];
    
    [self generateDirection];
}

-(void)update{
    if(canMove){
        //Check Crash
        if(!justCrashed){
            for(int i = 0; i < [game.hazards count]; i++){
                UIImageView *foo = [game.hazards objectAtIndex:i];
                if((car_.frame.origin.x < (foo.frame.origin.x + foo.frame.size.width)) &&
                   (car_.frame.origin.x > (foo.frame.origin.x)) &&
                   (car_.frame.origin.y < (foo.frame.origin.y + foo.frame.size.height)) &&
                   (car_.frame.origin.y > (foo.frame.origin.y))){
                    [self crashed];
                }
            }
        }
        
        if(accellerateButton.state == UIControlStateHighlighted) [car_ accellerate];
        if(reverseButton.state == UIControlStateHighlighted) [car_ reverse];
        if(leftButton.state == UIControlStateHighlighted) [car_ turnLeft];
        if(rightButton.state == UIControlStateHighlighted) [car_ turnRight];
        
        
        if(car_.frame.origin.y <= 40){
            cameraPosition = CLLocationCoordinate2DMake(cameraPosition.latitude + moveDistanceY, cameraPosition.longitude);
            [self moveCamera:CGPointMake(1, 0)];
        }else if(car_.frame.origin.y >= 260){
            cameraPosition = CLLocationCoordinate2DMake(cameraPosition.latitude - moveDistanceY, cameraPosition.longitude);
            [self moveCamera:CGPointMake(-1, 0)];
        }else if(car_.frame.origin.x <= 40){
            cameraPosition = CLLocationCoordinate2DMake(cameraPosition.latitude, cameraPosition.longitude - moveDistanceX);
            [self moveCamera:CGPointMake(0, 1)];
        }else if(car_.frame.origin.x >= 420){
            cameraPosition = CLLocationCoordinate2DMake(cameraPosition.latitude, cameraPosition.longitude + moveDistanceX);
            [self moveCamera:CGPointMake(0, -1)];
        }
        
        [car_ updateValues];
    }
}

-(void)updateGameTimer{
    if(shouldTime){
        totalTime++;
        currentTime--;
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

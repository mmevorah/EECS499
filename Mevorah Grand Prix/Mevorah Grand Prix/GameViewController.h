//
//  GameViewController.h
//  Mevorah Grand Prix
//
//  Created by Mark Mevorah on 3/30/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <QuartzCore/QuartzCore.h>
#include "Car.h"
#include "carPool.h"

@interface GameViewController :UIViewController<GMSMapViewDelegate>{
    CLLocationCoordinate2D cameraPosition;
    float moveDistance;
    
    Car *car;
    
    bool playing;
    carPool *carPool;
    
    //Game
    int totalTime;
    int currentTime;
    bool canMove;
    //location last safe location 
    int level;
    CLLocationCoordinate2D startLocation;
    CLLocationCoordinate2D nextDestination;
    //then pass the current level to the carPool view to generate hazards when switch view
}
@property(strong, nonatomic) NSTimer *updateClock;
@property(strong, nonatomic) NSTimer *gameTimer;

@property(strong, nonatomic) carPool *game;
@property(strong, nonatomic) Car *car;

@property(strong, nonatomic) GMSCameraPosition *camera;

@property (strong, nonatomic) IBOutlet UIView *controllerView;
@property (strong, nonatomic) IBOutlet UIButton *accellerateButton;
@property (strong, nonatomic) IBOutlet UIButton *reverseButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;

@property (strong, nonatomic) IBOutlet UIView *consoleView;


//Game flow
@property (strong, nonatomic) IBOutlet UILabel *consoleLabel;
@property (strong, nonatomic) NSString *nextDestinationAddress;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
//speed label

//Utility
-(void)getLocationName:(CLLocationCoordinate2D)coordinate;
-(CLLocationCoordinate2D)setDestination;


//Game Over
- (IBAction)playAgainButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *playAgainButton;
@property (strong, nonatomic) IBOutlet UIButton *mainMenuButton;


@end

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
    //HighScore
    NSMutableArray *highScores;
    NSNumber *highScore;
    NSString *highScoreName;
    
    CLLocationCoordinate2D cameraPosition;
    float moveDistanceY;
    float moveDistanceX;
    
    Car *car;
    
    carPool *carPool;
    
    //Game
    int lives;
    int totalTime;
    int currentTime;
    bool canMove;
    bool shouldTime;
    bool justCrashed;
    //location last safe location 
    int level;
    CLLocationCoordinate2D startLocation;
    CLLocationCoordinate2D nextDestination;
    CGRect nextDestinationBounds;
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
@property (strong, nonatomic) NSString *nextDestinationAddress;
@property (strong, nonatomic) IBOutlet UILabel *consoleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *directionLabel;
@property (strong, nonatomic) IBOutlet UILabel *livesLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameInput;
- (IBAction)save:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

//speed label

//Utility
-(void)getLocationName:(CLLocationCoordinate2D)coordinate;
-(CLLocationCoordinate2D)setDestination;
-(void)generateDirection;
-(void)crashed;
-(void)highScore;


//Game Over
- (IBAction)playAgainButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *playAgainButton;


@end

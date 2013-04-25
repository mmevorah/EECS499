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

@interface GameViewController :UIViewController{        
    CLLocationCoordinate2D cameraPosition;
    float moveDistance;
    
    Car *car;
    
    bool playing;
    carPool *carPool;
    
    //Game
    //int total time (seconds)
    //bool canMove
    //location last safe location 
    //int currentLevel
    //int timer
    //coord nextDestination //checked in the update function 
    //then pass the current level to the carPool view to generate hazards when switch view
}
@property(strong, nonatomic) NSTimer *updateClock;

@property(strong, nonatomic) carPool *game;
@property(strong, nonatomic) Car *car;

@property(strong, nonatomic) GMSCameraPosition *camera;

@property (strong, nonatomic) IBOutlet UIView *controllerView;
@property (strong, nonatomic) IBOutlet UIButton *accellerateButton;
@property (strong, nonatomic) IBOutlet UIButton *reverseButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;

//Game flow
@property (strong, nonatomic) IBOutlet UILabel *consoleLabel;
//speed label
//time label

@end

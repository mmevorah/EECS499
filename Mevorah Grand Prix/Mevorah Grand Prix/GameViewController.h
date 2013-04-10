//
//  GameViewController.h
//  Mevorah Grand Prix
//
//  Created by Mark Mevorah on 3/30/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#include "Car.h"

@interface GameViewController :UIViewController{
    float checkPixelInterval;
    
    CLLocationCoordinate2D cameraPosition;
    float moveDistance;
    
    Car *car;
    
    NSArray *bounds;
}



@property(strong, nonatomic) Car *car;

@property(strong, nonatomic) NSArray *bounds;

@property(strong, nonatomic) NSTimer *clock;

@property(strong, nonatomic) GMSCameraPosition *camera;

@property (strong, nonatomic) IBOutlet UIView *controllerView;
@property (strong, nonatomic) IBOutlet UIButton *accellerateButton;
@property (strong, nonatomic) IBOutlet UIButton *reverseButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;




@end

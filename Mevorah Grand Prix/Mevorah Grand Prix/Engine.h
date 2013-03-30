//
//  Engine.h
//  Mevorah Grand Prix
//
//  Created by Mark Mevorah on 3/30/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Engine : NSObject

@property double positionX;
@property double positionY;
@property double velocityX;
@property double velocityY;
@property double drag;
@property double angle;
@property double angularVelocity;
@property double angularDrag;
@property double power;
@property double turnspeed;

-(id)initWithPosX:(double)initialLong PosY:(double)initialLat Angle:(double)initialBearing;
-(void)updateValues;
-(void)accellerate;
-(void)turnLeft;
-(void)turnRight;

@end

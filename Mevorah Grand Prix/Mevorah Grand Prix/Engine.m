//
//  Engine.m
//  Mevorah Grand Prix
//
//  Created by Mark Mevorah on 3/30/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import "Engine.h"

@implementation Engine

@synthesize positionX, positionY;
@synthesize velocityX, velocityY;
@synthesize drag, angle, angularDrag, angularVelocity;
@synthesize power, turnspeed;

-(id)initWithPosX:(double)initialLong PosY:(double)initialLat Angle:(double)initialBearing{
    if(self = [super init]){
        positionX = initialLong;
        positionY = initialLat;
        angle = initialBearing;
        
        velocityX = 0;
        velocityY = 0;
        angularVelocity = 0;
        
        power = 2;
        turnspeed = 2;
        drag = .5;
        angularDrag = .5;
    }
    return self;
}

-(void)updateValues{
    positionX += velocityX;
    positionY += velocityY;
    velocityX *= drag;
    velocityY *= drag;
    angle += angularVelocity;
    angularVelocity *= angularDrag;
}

-(void)accellerate{
    velocityX += sin(angle) * power;
    velocityY += cos(angle) * power;
}

-(void)turnLeft{
    angularVelocity -= turnspeed;
}

-(void)turnRight{
    angularVelocity += turnspeed;
}

@end

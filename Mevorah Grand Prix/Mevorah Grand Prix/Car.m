//
//  Car.m
//  Mevorah Grand Prix
//
//  Created by Mark Mevorah on 4/5/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import "Car.h"

@implementation Car
@synthesize image = image_;
@synthesize intersectionPt;
@synthesize timeItTakesToDriveAMile;
@synthesize velocityX;
@synthesize velocityY;

@synthesize front, back, left, right;

- (id)initWithFrame:(CGRect)frame withImage:(UIImage*)image
{
    self = [super initWithFrame:frame];
    if (self) {
        
        image_ = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        image_.image = image;
        
        [self addSubview:image_];
        self.layer.anchorPoint = CGPointMake(0.5, .5);   //fuck around with this
        
        locationX = frame.origin.x;
        locationY = frame.origin.y;
        
        halfHeight = (frame.size.height/2);
        halfWidth = (frame.size.width/2);
        offSet = 2;
        
        front = CGPointMake(frame.origin.x, frame.origin.y - halfHeight - offSet);
        back = CGPointMake(frame.origin.x, frame.origin.y + halfHeight + offSet);
        left = CGPointMake(frame.origin.x - halfWidth - offSet, frame.origin.y);
        right = CGPointMake(frame.origin.x + halfWidth + offSet, frame.origin.y);
        
        angle = 0;
        
        velocityX = 0;
        velocityY = 0;
        angularVelocity = 0;
        
        power = .0002;
        turnSpeed = .00025;
        drag = .9989;
        angularDrag = .99;
        
        timeItTakesToDriveAMile = 60; //time it takes to drive a mile
    }
    return self;
}

-(void)updateValues{
    
   // NSLog(@"LocX: %f, LocY: %f", locationX, locationY);
    
    velocityX *= drag;
    velocityY *= drag;
    
    locationX += velocityX;
    locationY += velocityY;
    
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:angle];
    
    angle += angularVelocity;
    angularVelocity *= angularDrag;
    rotation.toValue = [NSNumber numberWithFloat:angle];
    rotation.duration = (1/20);
    [self.layer addAnimation:rotation forKey:@"angle"];
    
    front.x = self.frame.origin.x + (halfHeight + offSet)*sin(angle);
    front.y = self.frame.origin.y - (halfHeight + offSet)*cos(angle);
  //  back.x = self.frame.origin.x - (halfHeight + offSet)*sin(angle);
  //  back.y = self.frame.origin.y + (halfHeight + offSet)*cos(angle);
    
    
    //NSLog(@"angle: %f", angle);
    //NSLog(@"front: x: %f, y: %f", front.x, front.y);
    
    
    self.frame = CGRectMake(locationX,
                            locationY,
                            self.frame.size.width,
                            self.frame.size.height);
}

-(void)reset{ //fix
    velocityX = 0;
    velocityY = 0;
    angle = 0;
    self.frame = CGRectMake(240, 150, self.frame.size.width, self.frame.size.height);
}

-(void)cameraMoved:(CGPoint)position{
    if(position.x == 1){
        NSLog(@"Top");
        locationY = 260;
    }else if(position.x == -1){
        NSLog(@"Bottom");
        locationY = 40;
    }else if(position.y == 1){
        locationX = 420;
    }else{
        locationX = 40;
    }
    self.frame = CGRectMake(locationX, locationY, self.frame.size.width, self.frame.size.height);    
}

-(void)accellerate{
    velocityX -= -sin(angle) * power;
    velocityY -= cos(angle) * power;
   // NSLog(@"VelX: %f, VelY: %f", velocityX, velocityY);
}

-(void)reverse{
    velocityX += -sin(angle) * power;
    velocityY += cos(angle) * power;
}

-(void)turnLeft{
    angularVelocity -= turnSpeed*sqrt(velocityX*velocityX + velocityY*velocityY);
}

-(void)turnRight{
    angularVelocity += turnSpeed*sqrt(velocityX*velocityX + velocityY*velocityY);
}

@end

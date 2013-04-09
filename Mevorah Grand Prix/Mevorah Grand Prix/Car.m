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

- (id)initWithFrame:(CGRect)frame withImage:(UIImage*)image
{
    self = [super initWithFrame:frame];
    if (self) {
        image_ = [[UIImageView alloc] initWithImage:image];
        [self addSubview:image_];
        self.layer.anchorPoint = CGPointMake(.5, 1);   //fuck around with this
        
        locationX = frame.origin.x;
        locationY = frame.origin.y;
        angle = 0;
        
        velocityX = 0;
        velocityY = 0;
        angularVelocity = 0;
        
        power = .00005;
        turnSpeed = .00035;
        drag = .999;
        angularDrag = .995;
        
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
    
        
    self.frame = CGRectMake(locationX,
                            locationY,
                            self.frame.size.width,
                            self.frame.size.height);
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





/*
frontWheelX = carLocationX + wheelBase/2 * cos(carHeading);
frontWheelY = carLocationY + wheelBase/2 * sin(carHeading);

backWheelX = carLocationX - wheelBase/2 * cos(carHeading);
backWheelY = carLocationY - wheelBase/2 * sin(carHeading);

backWheelX += carSpeed * dt * cos(carHeading);
backWheelY += carSpeed * dt * sin(carHeading);

frontWheelX += carSpeed * dt * cos(carHeading+steerAngle);
frontWheelY += carSpeed * dt * sin(carHeading+steerAngle);

carLocationX = (frontWheelX + backWheelX) / 2;
carLocationY = (frontWheelY + backWheelY) / 2;

carHeading = atan2( frontWheelY - backWheelY , frontWheelX - backWheelX );
*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

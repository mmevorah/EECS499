//
//  Car.h
//  Mevorah Grand Prix
//
//  Created by Mark Mevorah on 4/5/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface Car : UIView{
   
    
    CGFloat locationX;
    CGFloat locationY;
    
    CGFloat frontWheelX;
    CGFloat frontWheelY;
    CGFloat backWheelX;
    CGFloat backWheelY;
    
    
    CGFloat velocityX;
    CGFloat velocityY;
    CGFloat drag;
    CGFloat angle;
    CGFloat angularVelocity;
    CGFloat angularDrag;
    CGFloat power;
    CGFloat turnSpeed;
    CGFloat turningRadius;
    
    

     CGFloat heading; //car's rotation
     CGFloat speed;
     CGFloat steerAngle;
 
}
- (id)initWithFrame:(CGRect)frame withImage:(UIImage*)image;

@property(strong, nonatomic) UIImageView* image;

-(void)updateValues;

-(void)cameraMoved:(CGPoint)position;


-(BOOL)crashedAtPoint:(CGRect)point;

-(void)accellerate;
-(void)reverse;
-(void)turnLeft;
-(void)turnRight;

@end
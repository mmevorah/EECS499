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
    
    CGFloat halfHeight;
    CGFloat halfWidth;
    int offSet;
    CGPoint front;
    CGPoint back;
    CGPoint left;
    CGPoint right;
    
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

@property CGFloat velocityX;
@property CGFloat velocityY;

@property(readonly) NSInteger timeItTakesToDriveAMile;

- (id)initWithFrame:(CGRect)frame withImage:(UIImage*)image;

@property(strong, nonatomic) UIImageView* image;
@property(strong, nonatomic) UIView* intersectionPt;

@property CGPoint front;
@property CGPoint back;
@property CGPoint left;
@property CGPoint right;

-(void)updateValues;
-(void)reset;

-(void)cameraMoved:(CGPoint)position;

-(void)accellerate;
-(void)reverse;
-(void)turnLeft;
-(void)turnRight;

@end
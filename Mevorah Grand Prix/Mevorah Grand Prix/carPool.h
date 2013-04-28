//
//  carPool.h
//  Mevorah Grand Prix
//
//  Created by Mark Mevorah on 4/24/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface carPool : UIView
{
    NSArray *hazards; //Contains cgrects of the locations and sizes of the boxes
    UIImageView *obj1;
    UIImageView *obj2;
    UIImageView *obj3;
    UIImageView *obj4;
    UIImageView *obj5;
    UIImageView *obj6;
    UIImageView *obj7;
    UIImageView *obj8;
    UIImageView *obj9;
    UIImageView *obj10;
}

@property (strong, nonatomic) NSArray *hazards;

-(void)switchedView:(int) level;

@end

//
//  carPool.m
//  Mevorah Grand Prix
//
//  Created by Mark Mevorah on 4/24/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import "carPool.h"

@implementation carPool

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    UIImageView *obj1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    UIImageView *obj2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    UIImageView *obj3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    UIImageView *obj4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    UIImageView *obj5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    UIImageView *obj6 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    UIImageView *obj7 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    UIImageView *obj8 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    UIImageView *obj9 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    UIImageView *obj10 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];

    UFOArray = [[NSArray alloc] initWithObjects:obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10, nil];

    for(int i = 0; i < [UFOArray count]; i++){
        UIImageView *foo = [UFOArray objectAtIndex:i];
       // foo.image =
    }
    
    return self;
}

-(void)switchedView:(int) level{
    
    //add a subview for each
    //uiview blah, self add subview, set corresponding rect in array
    //create accessor for each coordinate
    
    if(level == 0){
        //0-8
    }else if(level == 1){
        //0-15
    }else if(level == 2){
        //0-20
    }else{
        //0-25
    }
}


@end

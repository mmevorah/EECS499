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
    
    NSLog(@"init");
    
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

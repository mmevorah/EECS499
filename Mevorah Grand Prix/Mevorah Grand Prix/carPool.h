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
    NSArray *hazardBox; //Contains cgrects of the locations and sizes of the boxes
}

-(void)switchedView:(int) level;

@end

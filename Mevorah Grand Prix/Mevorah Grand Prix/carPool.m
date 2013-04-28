//
//  carPool.m
//  Mevorah Grand Prix
//
//  Created by Mark Mevorah on 4/24/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import "carPool.h"

@implementation carPool

@synthesize hazards;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    obj1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    obj2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    obj3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    obj4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    obj5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    obj6 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    obj7 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    obj8 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];

    hazards = [[NSArray alloc] initWithObjects:obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10, nil];

    for(int i = 0; i < [hazards count]; i++){
        UIImageView *foo = [hazards objectAtIndex:i];
        foo.image = [UIImage imageNamed:@"ufo-01.png"];
    }
        
    return self;
}

-(void)switchedView:(int) level{
    for(int i = 0; i < [hazards count]; i++){
        [[hazards objectAtIndex:i] removeFromSuperview];
    }
    
    int a = 420;
    int b = 80;
    int c = 290;
    int d = 80;
    int e = 35;
    int f = 40;
    
    if(level == 0){
        NSLog(@"called");
        obj1.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj1];
        obj2.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj2];
        obj3.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj3];
    }else if(level == 1){
        obj1.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj1];
        obj2.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj2];
        obj3.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj3];
        obj4.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj4];
    }else if(level == 2){
        obj1.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj1];
        obj2.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj2];
        obj3.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj3];
        obj4.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj4];
        obj5.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj5];
    }else if(level == 3){
        obj1.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj1];
        obj2.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj2];
        obj3.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj3];
        obj4.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj4];
        obj5.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj5];
        obj6.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj6];
    }else if(level == 4){
        obj1.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj1];
        obj2.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj2];
        obj3.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj3];
        obj4.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj4];
        obj5.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj5];
        obj6.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj6];
        obj7.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj7];
    }else{
        obj1.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj1];
        obj2.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj2];
        obj3.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj3];
        obj4.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj4];
        obj5.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj5];
        obj6.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj6];
        obj7.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj7];
        obj8.frame = CGRectMake(arc4random_uniform(a) + b, arc4random_uniform(c) + d, e, f);
        [self addSubview:obj7];
    }
}


@end

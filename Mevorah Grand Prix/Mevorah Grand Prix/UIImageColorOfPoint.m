//
//  UIImageColorOfPoint.m
//  Mevorah Grand Prix
//
//  Created by Mark Mevorah on 4/19/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import "UIImageColorOfPoint.h"

@implementation UIImage (Picker)

- (UIColor *)colorAtPosition:(CGPoint)position {
    
    CGRect sourceRect = CGRectMake(position.x, position.y, 1.f, 1.f);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, sourceRect);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *buffer = malloc(4);
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big;
    CGContextRef context = CGBitmapContextCreate(buffer, 1, 1, 8, 4, colorSpace, bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0.f, 0.f, 1.f, 1.f), imageRef);
    CGImageRelease(imageRef);
    CGContextRelease(context);
    
    CGFloat r = buffer[0] / 255.f;
    CGFloat g = buffer[1] / 255.f;
    CGFloat b = buffer[2] / 255.f;
    CGFloat a = buffer[3] / 255.f;
    
    free(buffer);
    
    NSLog(@"rgba: %f, %f, %f, %f", r, g, b, a);
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

@end
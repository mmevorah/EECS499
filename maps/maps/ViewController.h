//
//  ViewController.h
//  maps
//
//  Created by Mark Mevorah on 3/22/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController : UIViewController{
    double latitude;
    double longitude;
    double bearing;
    
}
- (IBAction)rightButton:(UIButton *)sender;
- (IBAction)upButton:(UIButton *)sender;
- (IBAction)leftButton:(UIButton *)sender;
- (IBAction)downButton:(UIButton *)sender;


@property (strong, nonatomic) IBOutlet UIView *mapView;

@end

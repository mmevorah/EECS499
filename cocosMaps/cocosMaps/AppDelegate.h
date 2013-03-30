//
//  AppDelegate.h
//  cocosMaps
//
//  Created by Mark Mevorah on 3/26/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import <GoogleMaps/GoogleMaps.h>
#import "ViewController.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	CCDirectorIOS	*director_;							// weak ref
    ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (readonly) CCDirectorIOS *director;
@property (nonatomic, retain) ViewController *viewController;

@end

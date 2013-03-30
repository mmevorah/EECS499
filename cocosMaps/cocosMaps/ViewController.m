//
//  ViewController.m
//  cocosMaps
//
//  Created by Mark Mevorah on 3/27/13.
//
//

#import "cocos2d.h"
#import "GameConfig.h" 

#import "ViewController.h"
#import "HelloWorldLayer.h"
#import "IntroLayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)setupCocos2D {
	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
	CCGLView *glView = [CCGLView viewWithFrame:self.view.bounds
								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];
    glView.backgroundColor = [UIColor clearColor];
    
    glView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:glView atIndex:1];
    
    // attach the openglView to the director
	[[CCDirector sharedDirector] setView:glView];
    
    CCScene *scene = [HelloWorldLayer scene];
    
    [[CCDirector sharedDirector] runWithScene:scene];
}

-(void)setupMapView{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"Hello");
    int latitude = 40.419345;
    int longitude = -74.411001;
    int bearing = 0;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude                                                              zoom:30
                                                              bearing:bearing
                                                         viewingAngle:45];
    
    
    mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, 320, 548) camera:camera];
    mapView.myLocationEnabled = YES;
    [self.view addSubview:mapView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapView];
    [self setupCocos2D];


}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {

    [[CCDirector sharedDirector] end];
}


- (void)dealloc {

    [super dealloc];
}



@end

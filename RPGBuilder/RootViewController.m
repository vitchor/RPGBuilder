//
//  RootViewController.m
//  RPGBuilder
//
//  Created by Marcia  Rozenfeld on 2/25/12.
//  Copyright Ufscar 2012. All rights reserved.
//

//
// RootViewController + iAd
// If you want to support iAd, use this class as the controller of your iAd
//

#import "cocos2d.h"
#import "PongScene.h"
#import "RootViewController.h"

@implementation RootViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
	// Custom initialization
	}
	return self;
 }
 */


 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
     CCDirector *director = [CCDirector sharedDirector];
     
     // Turn on display FPS
     [director setDisplayStats:kCCDirectorStatsFPS];
     
     // Set multiple touches on
     EAGLView *glView = [director openGLView];
     [glView setMultipleTouchEnabled:YES];	
     
     // Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
     if( ! [director enableRetinaDisplay:YES] )
         CCLOG(@"Retina Display Not supported");
     
     //	[[CCTouchDispatcher sharedDispatcher] link];
     [director runWithScene:[PongScene node]];

 }
 


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
     CCDirector *director = [CCDirector sharedDirector];
     
     // Turn on display FPS
     [director setDisplayStats:kCCDirectorStatsFPS];
     
     // Set multiple touches on
     EAGLView *glView = [director openGLView];
     [glView setMultipleTouchEnabled:YES];	
     
     // Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
     if( ! [director enableRetinaDisplay:YES] )
         CCLOG(@"Retina Display Not supported");
     
     //	[[CCTouchDispatcher sharedDispatcher] link];
     [director runWithScene:[PongScene node]]; 
	[super viewDidLoad];
 }
 


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
		
	//
	//
	// return YES for the supported orientations

	// Only landscape ?
//	return ( UIInterfaceOrientationIsLandscape( interfaceOrientation ) );

	// Only portrait ?
//	return ( ! UIInterfaceOrientationIsLandscape( interfaceOrientation ) );

	// All orientations ?
	return YES;
}


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

	//
	// XXX: Is this code needed ???
	//
	
#if 0
	CGRect screenRect = [[UIScreen mainScreen] bounds];
	CGRect rect = CGRectZero;

	
	if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)		
		rect = screenRect;
	
	else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
		rect.size = CGSizeMake( screenRect.size.height, screenRect.size.width );
	
	CCDirector *director = [CCDirector sharedDirector];
	EAGLView *glView = [director openGLView];
	float contentScaleFactor = [director contentScaleFactor];
	
	if( contentScaleFactor != 1 ) {
		rect.size.width *= contentScaleFactor;
		rect.size.height *= contentScaleFactor;
	}
	glView.frame = rect;
#endif
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

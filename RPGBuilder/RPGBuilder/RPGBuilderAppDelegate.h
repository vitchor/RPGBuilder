//
//  AppDelegate.h
//  RPGBuilder
//
//  Created by Marcia  Rozenfeld on 2/25/12.
//  Copyright Ufscar 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window_;
	RootViewController	*viewController_;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) RootViewController *viewController;

@end

//
//  BoomP2AppDelegate.h
//  BoomP2
//
//  Created by CS Admin on 7/19/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface BoomP2AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*startscreen;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end

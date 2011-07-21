//
//  RootViewController.h
//  BoomP2
//
//  Created by CS Admin on 7/19/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "startscreen.h"

@interface RootViewController : UIViewController {
	startscreen *startscreen;
}
@property(nonatomic, retain) startscreen *startscreen;

@end

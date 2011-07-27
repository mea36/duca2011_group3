//
//  hiscorescreen.h
//  BoomP2
//
//  Created by CS Admin on 7/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "startscreen.h"
#import "CCLabelTTF.h"
#import "HelloWorldLayer.h"
#import "cocos2d.h"
#import "CCLayer.h"
#import "Helpscreen.h"
#import "OptionScreen.h"
#import "SimpleAudioEngine.h"


@interface hiscorescreen : CCLayer {
	CCSprite *bg;
	CCSprite *Player;	
}
+(id) scene;

@end

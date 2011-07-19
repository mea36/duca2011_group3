//
//  HelloWorldLayer.h
//  BoomP2
//
//  Created by CS Admin on 7/19/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayerColor //change to CCLayer when using backgrond pic
{
	CCSprite *_player;
	float _playerPointsPerSecY;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

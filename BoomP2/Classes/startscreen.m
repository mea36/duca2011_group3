//
//  startscreen.m
//  BoomP2
//
//  Created by CS Admin on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "startscreen.h"
#import "CCLabelTTF.h"
#import "HelloWorldLayer.h"
#import "cocos2d.h"
#import "CCLayer.h"
#import "Helpscreen.h"
#import "OptionScreen.h"
#import "SimpleAudioEngine.h"

// startscreen implementation
@implementation startscreen
+(id) scene
{
	CCScene *scene = [CCScene node];
	startscreen *layer =[startscreen node];
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init])){
		CCLabelTTF *title = [CCLabelTTF labelWithString:@"BOOM Part 2" fontName:@"Times New Roman" fontSize:29];
		title.position =  ccp(150, 440);
		[self addChild: title];
		
		CGSize winSize = [CCDirector sharedDirector].winSize;
		
		bg = [[CCSprite spriteWithFile:@"bg.png"] retain];
		bg.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:bg z:-1];
		
		CCLayer *menuLayer = [[CCLayer alloc] init];
		[self addChild:menuLayer];
		
		CCMenuItemImage *startButton = [CCMenuItemImage itemFromNormalImage:@"Startbtn.png" selectedImage:@"Startbtnselected.png" target:self selector:@selector(startGame:)];
		startButton.position = ccp(0, -10);
		
		CCMenu *start = [CCMenu menuWithItems: startButton, nil];
		[menuLayer addChild: start];
		
		CCMenuItemImage *optionButton = [CCMenuItemImage itemFromNormalImage:@"Optionbtn.png" selectedImage:@"Optionbtnselected.png" target:self selector:@selector(startOption:)];
		optionButton.position = ccp(0, -70);
		
		CCMenu *option = [CCMenu menuWithItems: optionButton, nil];
		[menuLayer addChild: option];
		
		
		CCMenuItemImage *helpButton = [CCMenuItemImage itemFromNormalImage:@"Help.png" selectedImage:@"Helpselected.png" target:self selector:@selector(startHelp:)];
		helpButton.position = ccp(0, -130);
		
		CCMenu *helpscreen = [CCMenu menuWithItems: helpButton, nil];
		[menuLayer addChild: helpscreen];
		
		CCMenuItemImage *hiscoreButton = [CCMenuItemImage itemFromNormalImage:@"Hiscore.png" selectedImage:@"Hiscoreselected.png" target:self selector:@selector(startHiscore:)];
		hiscoreButton.position = ccp(0, -180);
		
		CCMenu *hiscorescreen = [CCMenu menuWithItems: hiscoreButton, nil];
		[menuLayer addChild: hiscorescreen];
		
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];			
	}
	return self;
}
- (void) startGame: (id) sender
{
	[[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
}
-(void) startOption: (id) sender
{
	[[CCDirector sharedDirector] replaceScene:[OptionScreen scene]];
}
-(void) startHelp: (id) sender
{
	[[CCDirector sharedDirector] replaceScene:[Helpscreen scene]];
}
-(void) startHiscore: (id) sender
{
	[[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
}

-(void) dealloc
{
	[super dealloc];	
}


@end

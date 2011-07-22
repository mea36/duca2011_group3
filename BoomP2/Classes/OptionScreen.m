//
//  OptionScreen.m
//  BoomP2
//
//  Created by CS Admin on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OptionScreen.h"
#import "HelloWorldLayer.h"
#import "cocos2d.h"
#import "CCLabelTTF.h"
#import "CCLayer.h"
#import "CDAudioManager.h"
#import "SimpleAudioEngine.h"
#import "startscreen.h"


@implementation OptionScreen 

+(id) scene
{
	CCScene *scene = [CCScene node];
	OptionScreen *layer = [OptionScreen node];
	[scene addChild: layer];
	
	
	
	
	
	
	return scene;
}

-(id) init
{
	
	if( (self=[super init] )) { //buttons titles,labels go here
		
		
		
		
		
		
 		//gfggh
		CCLabelTTF *title = [CCLabelTTF labelWithString:@"Option Screen" fontName:@"Courier" fontSize:16];
		title.position = ccp(150, 450);
		[self addChild: title];		
		
		CCLayer *menuLayer = [[CCLayer alloc] init];
		[self addChild:menuLayer];
		
		CCMenuItemImage *startButton = [CCMenuItemImage
										itemFromNormalImage:@"back.png" selectedImage:@"backselected.png"
										target:self
										
										selector:@selector(startGame:)];
		startButton.position = ccp(-120, 180);
		CCMenu *menu = [CCMenu menuWithItems: startButton, nil];
		[menuLayer addChild: menu];
		
		
		
		
		
		
		
		// Sound on/off toggle
		CCMenuItem *soundOnItem = [CCMenuItemImage itemFromNormalImage:@"soundOn.png"
														 selectedImage:@"soundOn.png"
																target:nil
															  selector:nil];
		
		CCMenuItem *soundOffItem = [CCMenuItemImage itemFromNormalImage:@"soundOff.png"
														  selectedImage:@"soundOff.png"
																 target:nil
															   selector:nil];
		
		CCMenuItemToggle *soundToggleItem = [CCMenuItemToggle itemWithTarget:self
																	selector:@selector(soundButtonTapped:)
																	   items:soundOnItem, soundOffItem, nil];		
		
		
		
		CCMenu *bottomMenu = [CCMenu menuWithItems:soundToggleItem, nil];
		soundToggleItem.position = ccp( -90,-120);
		[self addChild: bottomMenu z: 10];		
		//preload music at some point 
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];		
		
		
	}
	return self;
}

-(void) soundButtonTapped: (id) sender
{
	
	
	if([CDAudioManager sharedManager].mute == TRUE){
		[CDAudioManager sharedManager].mute = FALSE;
	}
	else {
		[CDAudioManager sharedManager].mute = TRUE;
	}	
	
}








-(void) startGame: (id)sender
{
	[[CCDirector sharedDirector] replaceScene:[startscreen scene]];
}


-(void) dealloc
{
	
	[super dealloc];
}
@end
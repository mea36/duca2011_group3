//
//  Helpscreen.m
//  BoomP2
//
//  Created by CS Admin on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "startscreen.h"
#import "CCLabelTTF.h"
#import "HelloWorldLayer.h"
#import "cocos2d.h"
#import "CCLayer.h"
#import "Helpscreen.h"


@implementation Helpscreen
+(id) scene
{
	CCScene *scene = [CCScene node];
	Helpscreen *CCLabelTTF = [Helpscreen node];
	[scene addChild: CCLabelTTF];
	
	return scene;
}
-(id) init
{
	if( (self=[super init])){
		
		CCLabelTTF *title = [CCLabelTTF labelWithString:@"HELP" fontName:@"Times New Roman" fontSize:75];
		title.position =  ccp(150, 440);
		[self addChild: title];
		
		CCLayer *menuLayer = [[CCLayer alloc] init];
		[self addChild:menuLayer];
		
		CCMenuItemImage *backButton = [CCMenuItemImage itemFromNormalImage:@"back.png" selectedImage:@"backselected.png" target:self selector:@selector(back:)];
		backButton.position = ccp(0, -10);
		
		CCMenu *back = [CCMenu menuWithItems: backButton, nil];
		[menuLayer addChild: back];
		
		
		
	
	}
	return self;
}
- (void) back: (id) sender
{
	[[CCDirector sharedDirector] replaceScene:[startscreen scene]];
}
-(void) dealloc
{
	[super dealloc];	
}

@end

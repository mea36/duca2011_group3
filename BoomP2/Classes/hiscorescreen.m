//
//  hiscorescreen.m
//  BoomP2
//
//  Created by CS Admin on 7/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "hiscorescreen.h"


@implementation hiscorescreen
+(id) scene
{
	CCScene *scene = [CCScene node];
	hiscorescreen *layer =[hiscorescreen node];
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init])){
		CCLabelTTF *title = [CCLabelTTF labelWithString:@"Hi-Scores" fontName:@"Times New Roman" fontSize:29];
		title.position =  ccp(150, 440);
		[self addChild: title];
		
		CCLabelTTF *hiname = [CCLabelTTF labelWithString:@"Jake" fontName:@"Times New Roman" fontSize:29];
		hiname.position =  ccp(80, 320);
		[self addChild: hiname];
		
		CCLabelTTF *hiname2 = [CCLabelTTF labelWithString:@"Will" fontName:@"Times New Roman" fontSize:29];
		hiname2.position =  ccp(80, 220);
		[self addChild: hiname2];
		
		CCLabelTTF *hiname3 = [CCLabelTTF labelWithString:@"Geordan" fontName:@"Times New Roman" fontSize:29];
		hiname3.position =  ccp(80, 120);
		[self addChild: hiname3];
		
		CCLabelTTF *hiscore = [CCLabelTTF labelWithString:@"890" fontName:@"Times New Roman" fontSize:29];
		hiscore.position =  ccp(180, 320);
		[self addChild: hiscore];
		
		CCLabelTTF *hiscore2 = [CCLabelTTF labelWithString:@"762" fontName:@"Times New Roman" fontSize:29];
		hiscore2.position =  ccp(180, 220);
		[self addChild: hiscore2];
	
		CCLabelTTF *hiscore3 = [CCLabelTTF labelWithString:@"697" fontName:@"Times New Roman" fontSize:29];
		hiscore3.position =  ccp(180, 120);
		[self addChild: hiscore3];
		
		CGSize winSize = [CCDirector sharedDirector].winSize;
		
		bg = [[CCSprite spriteWithFile:@"bg.png"] retain];
		bg.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:bg z:-1];
		
		CCLayer *menuLayer = [[CCLayer alloc] init];
		[self addChild:menuLayer];
		
		CCMenuItemImage *startButton = [CCMenuItemImage
										itemFromNormalImage:@"back.png" selectedImage:@"backselected.png"
										target:self
										
										selector:@selector(back:)];
		
		startButton.position = ccp(-120, 170);
		CCMenu *menu = [CCMenu menuWithItems: startButton, nil];
		[menuLayer addChild: menu];
		
				
				
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

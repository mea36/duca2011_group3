//
//  startscreen.m
//  BoomP2
//
//  Created by CS Admin on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCLabelTTF.h"
#import "cocos2d.h"
#import "CCLayer.h"
#import "GameOverScreen.h"
#import "startscreen.h"

// startscreen implementation
@implementation GameOverScreen
+(id) scene
{
    CCScene *scene = [CCScene node];
    GameOverScreen *layer =[GameOverScreen node];
    [scene addChild: layer];
    
    return scene;
}

-(id) init
{
    if( (self=[super init])){
		
		CCLabelTTF *over = [CCLabelTTF labelWithString:@"GAME OVER :[" fontName:@"Times New Roman" fontSize:29];
		over.position =  ccp(150, 220);
		[self addChild: over];
		
		CGSize winSize = [CCDirector sharedDirector].winSize;
		
		bg = [[CCSprite spriteWithFile:@"bggameover.png"] retain];
		bg.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:bg z:-1];
		
		CCLayer *menuLayer = [[CCLayer alloc] init];
		[self addChild:menuLayer];
		
		CCMenuItemImage *startButton = [CCMenuItemImage itemFromNormalImage:@"back.png" selectedImage:@"backselected.png" target:self selector:@selector(startGame:)];
		startButton.position = ccp(0, -110);
		
		CCMenu *start = [CCMenu menuWithItems: startButton, nil];
		[menuLayer addChild: start];
    }
    return self;
}
- (void) startGame: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[startscreen scene]];
}



-(void) dealloc
{
    [super dealloc];    
}


@end
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
		
		CGSize winSize = [CCDirector sharedDirector].winSize;
		
		bg = [[CCSprite spriteWithFile:@"bg.png"] retain];
		bg.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:bg z:-1];
		
		CCLayer *menuLayer = [[CCLayer alloc] init];
		[self addChild:menuLayer];
		
		CCMenuItemImage *backButton = [CCMenuItemImage itemFromNormalImage:@"back.png" selectedImage:@"backselected.png" target:self selector:@selector(back:)];
		backButton.position = ccp(-120, 160);
		
		CCMenu *back = [CCMenu menuWithItems: backButton, nil];
		[menuLayer addChild: back];
		
		
		
		
		CCLabelTTF  *story = [CCLabelTTF labelWithString:@"Controls: Tilt Screen Left and Right to move your ship. Sound options can be found in the option screen. Story: IN A WORLD WHERE ALIENS HAVE SPONTANEOUSLY INVADED: ONE HERO FIGHTS ALONE AGAINST THE MENACING ALIEN SWARM. HIS NAME: ZIGLIOUS, THE OVERPAID WEB DESIGNER. USING HIS MASSIVE WEALTH HE WAS ABLE ESCAPE THE INITIAL ALIEN INVASION ON HIS PRIVATE ISLAND AND BEGAN TO CODE HIS OWN SPACESHIP INTO EXISTENCE. WILL HE BE ABLE TO FIGHT OFF THESE EVIL ALIENS?  " dimensions:CGSizeMake(300, 300) alignment:UITextAlignmentLeft fontName:@"Times New Roman" fontSize:16];
		[story setPosition: CGPointMake(160,220)];
		[self addChild: story];   	 
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

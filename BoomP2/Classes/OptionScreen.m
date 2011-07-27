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

		CGSize winSize = [CCDirector sharedDirector].winSize;
		
		bg = [[CCSprite spriteWithFile:@"bg.png"] retain];
		bg.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:bg z:-1];

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

		CCLabelTTF *title2 = [CCLabelTTF labelWithString:@"Background Music: " fontName:@"Courier" fontSize:16];
		title2.position = ccp(100, 250);
		[self addChild: title2];   	 
		
		
		CCMenu *bottomMenu = [CCMenu menuWithItems:soundToggleItem, nil];
		soundToggleItem.position = ccp(40, 10);
		[self addChild: bottomMenu z: 10];   	 
		//preload music at some point
		
		UIAlertView* dialog = [[UIAlertView alloc] init];
		[dialog setDelegate:self];
		[dialog setTitle:@"Enter Name"];
		[dialog setMessage:@" "];
		[dialog addButtonWithTitle:@"Cancel"];
		[dialog addButtonWithTitle:@"OK"];
		
		UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 45.0, 245.0, 25.0)];
		[nameField setBackgroundColor:[UIColor whiteColor]];
		[dialog addSubview:nameField];
		[dialog show];
		[dialog release];
		[nameField release];   	 

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
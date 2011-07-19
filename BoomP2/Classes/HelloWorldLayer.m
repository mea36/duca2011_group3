//
//  HelloWorldLayer.m
//  BoomP2
//
//  Created by CS Admin on 7/19/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)spriteMoveFinished:(id)sender {
	
	CCSprite *sprite = (CCSprite *)sender;
	[self removeChild:sprite cleanup:YES];
}

-(void)addEnemy {
	
	CCSprite *enemy = [CCSprite spriteWithFile:@"enemy.png"];
	
	//spawn location
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	int minX = enemy.contentSize.width/2;
	int maxX = winSize.width - enemy.contentSize.width/2;
	int rangeX = maxX - minX;
	int actualX = (arc4random() % rangeX) + minX;
	
	//create enemy
	enemy.position = ccp(actualX, winSize.height + (enemy.contentSize.height/2));
	[self addChild:enemy];
	
	//speed of enemy (TESTING PURPOSES)
	int minDuration = 2.0;
	int maxDuration = 4.0;
	int rangeDuration = maxDuration - minDuration;
	int actualDuration = (arc4random() % rangeDuration) + minDuration;
	
	//and........ ACTION!
	id actionMove = [CCMoveTo actionWithDuration:actualDuration 
										position:ccp(actualX, enemy.contentSize.height/2)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self 
											 selector:@selector(spriteMoveFinished:)];
	[enemy runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	
}
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
//	if( (self = [super init])) { //uncomment at start and delete line below for background pic
	if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
		_player = [[CCSprite spriteWithFile:@"Player.gif"] retain];
		CGSize winSize = [CCDirector sharedDirector].winSize;
		_player.position = ccp(winSize.width * 0.5, winSize.height * 0.1);
		
		[self addChild:_player];
	}
	
	self.isTouchEnabled = YES;
	self.isAccelerometerEnabled = YES;
	[self scheduleUpdate];
	[self schedule:@selector(gameLogic:) interval:1.0];
	return self;
}

-(void)gameLogic:(ccTime)dt {[self addEnemy];}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	
#define kFilteringFactor 0.1
#define kRestAccelX -0.6
#define kShipMaxPointsPerSec (winSize.height*0.5)        
#define kMaxDiffX 0.2
	
    UIAccelerationValue rollingX, rollingY, rollingZ;
	
    rollingX = (acceleration.x * kFilteringFactor) + (rollingX * (1.0 - kFilteringFactor));    
    rollingY = (acceleration.y * kFilteringFactor) + (rollingY * (1.0 - kFilteringFactor));    
    rollingZ = (acceleration.z * kFilteringFactor) + (rollingZ * (1.0 - kFilteringFactor));
	
    float accelX = acceleration.x - rollingX;
    float accelY = acceleration.y - rollingY;
    float accelZ = acceleration.z - rollingZ;
	
    CGSize winSize = [CCDirector sharedDirector].winSize;
	
    float accelDiff = accelX - kRestAccelX;
    float accelFraction = accelDiff / kMaxDiffX;
    float pointsPerSec = kShipMaxPointsPerSec * accelFraction;
	
    _playerPointsPerSecY = pointsPerSec;
	
}

- (void)update:(ccTime)dt {
	
	CGSize winSize = [CCDirector sharedDirector].winSize;
	float maxY = winSize.height - _player.contentSize.height/2;
	float minY = _player.contentSize.height/2;
	
	float newY = _player.position.y + (_playerPointsPerSecY * dt);
	newY = MIN(MAX(newY, minY), maxY);
	_player.position = ccp(_player.position.x, newY);
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end

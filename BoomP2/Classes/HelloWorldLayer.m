//
//  HelloWorldLayer.m
//  BoomP2
//
//  Created by CS Admin on 7/19/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "Enemy.h"
#import "HelloWorldLayer.h"
//#import "SimpleAudioEngine.h"        //MUSIC

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
	
	if (sprite.tag == 1) { // target
		[_enemy removeObject:sprite];
	} else if (sprite.tag == 2) { // projectile
		[_projectile removeObject:sprite];
	}
	
	[self removeChild:sprite cleanup:YES];
}

-(void)addEnemy {
	
	Enemy *enemy = nil;
	if ((arc4random() % 2) == 0) {enemy = [redEnemy enemy];}
	else if ((arc4random() % 3) == 0) {enemy = [greenEnemy enemy];}
	else if ((arc4random() % 5) == 0) {enemy = [yellowEnemy enemy];}
	else {enemy = [blueEnemy enemy];}
	
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
	int minDuration = enemy.minMoveDuration;
	int maxDuration = enemy.maxMoveDuration; 
	int rangeDuration = maxDuration - minDuration;
	int actualDuration = (arc4random() % rangeDuration) + minDuration;
	
	//and........ ACTION!
	id actionMove = [CCMoveTo actionWithDuration:actualDuration 
										position:ccp(actualX, enemy.contentSize.height/2)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self 
											 selector:@selector(spriteMoveFinished:)];
	[enemy runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	
	enemy.tag = 1;
	[_enemy addObject:enemy];
	
}
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self = [super init])) {
		_player = [[CCSprite spriteWithFile:@"Player.gif"] retain];
		CGSize winSize = [CCDirector sharedDirector].winSize;
		_player.position = ccp(winSize.width * 0.5, winSize.height * 0.1);
		bg = [[CCSprite spriteWithFile:@"bg.png"] retain];
		bg.position = ccp(winSize.width * 0.5,winSize.height * 0.5);
		[self addChild:bg z:-1];
		[self addChild:_player];
	}

	
	_enemy = [[NSMutableArray alloc] init];
	_projectile = [[NSMutableArray alloc] init];
	
	self.isTouchEnabled = YES;
	self.isAccelerometerEnabled = YES;
	[self scheduleUpdate];
	[self schedule:@selector(gameLogic:) interval:1.0];
	[self schedule:@selector(update:)];
	
	//	[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];   //BACKGROUND MUSIC
	return self;
}

//Remove all enemies on the screen (use a nuke!)
//- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//... 

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
	
    _playerPointsPerSecX = pointsPerSec;
	
}

- (void)update:(ccTime)dt {
	
	_playerPointsPerSecX++;
	
		CGSize winSize = [CCDirector sharedDirector].winSize;
	
		float maxX = winSize.width - _player.contentSize.width/2;
		float minX = _player.contentSize.width/2;
	
		float newX = _player.position.x + (_playerPointsPerSecX * dt);
		newX = MIN(MAX(newX, minX), maxX);
		_player.position = ccp(newX, winSize.height * 0.1);
		NSLog(@"The player position is (%d,%d)", newX, winSize.height * 0.1);

	
	currTime ++;
	if (currTime%35 == 0) {
		
		//shoot bullets
		CCSprite *projectile = [CCSprite spriteWithFile:@"bullet.gif"];
		projectile.position = ccp(_player.position.x, (winSize.height * 0.1) + (_player.contentSize.height/2));
		
		[self addChild:projectile];
		
		CGPoint realDest = ccp(_player.position.x, winSize.height);
		
		float length = winSize.height - 10;
		float velocity = 480/1;
		float realMoveDuration = length/velocity;
		
		[projectile runAction:[CCSequence actions:
							   [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
							   [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
							   nil]];
		
		projectile.tag = 2;
		[_projectile addObject:projectile];
		currTime = 0;
		
		//		[[SimpleAudioEngine sharedEngine] playEffect:@"pew-pew-lei.caf"];  //SHOOTING
	}
	
	NSMutableArray *projectileToDelete = [[NSMutableArray alloc] init];
	for (CCSprite *projectile in _projectile) {
		CGRect projectileRect = CGRectMake(
										   projectile.position.x - (projectile.contentSize.width/2), 
										   projectile.position.y - (projectile.contentSize.height/2), 
										   projectile.contentSize.width, 
										   projectile.contentSize.height);
		
		NSMutableArray *enemyToDelete = [[NSMutableArray alloc] init];
		for (CCSprite *enemy in _enemy) {
			CGRect enemyRect = CGRectMake(
										  enemy.position.x - (enemy.contentSize.width/2), 
										  enemy.position.y - (enemy.contentSize.height/2), 
										  enemy.contentSize.width, 
										  enemy.contentSize.height);
			
			if (CGRectIntersectsRect(projectileRect, enemyRect)) {
				[enemyToDelete addObject:enemy];				
			}						
		}
		
		for (CCSprite *enemy in enemyToDelete) {
			[_enemy removeObject:enemy];
			[self removeChild:enemy cleanup:YES];									
		}
		
		if (enemyToDelete.count > 0) {
			[projectileToDelete addObject:projectile];
		}
		[enemyToDelete release];
	}
	
	for (CCSprite *projectile in projectileToDelete) {
		[_projectile removeObject:projectile];
		[self removeChild:projectile cleanup:YES];
	}
	
	[projectileToDelete release];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[_enemy release];
	_enemy = nil;
	[_projectile release];
	_projectile = nil;
	[super dealloc];
}
@end

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
#import "GameOverScreen.h"
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
		worldHP--;
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
		_player = [[CCSprite spriteWithFile:@"player.png"] retain];
		CGSize winSize = [CCDirector sharedDirector].winSize;
		_player.position = ccp(winSize.width * 0.5, winSize.height * 0.1);
		bg = [[CCSprite spriteWithFile:@"bg.png"] retain];
		bg.position = ccp(winSize.width * 0.5,winSize.height * 0.5);
		[self addChild:bg z:-5];
		[self addChild:_player z:2];
		
		scoreLabel = [CCLabelTTF labelWithString:@"Score" fontName:@"Times New Roman" fontSize:30];
		scoreLabel.position = ccp(25, 467);
		[self addChild:scoreLabel];
		
		lifeLabel = [CCLabelTTF labelWithString:@"Remaining Lives" fontName:@"Times New Roman" fontSize:20];
		lifeLabel.position = ccp(285, 470);
		[self addChild:lifeLabel];
		
		healthBarEarth = [CCSprite spriteWithFile:@"healthBarEarth.gif"];
		[self addChild:healthBarEarth z:-1];
		healthBarEarth.position = ccp(winSize.width,0);
		healthBarEarth.anchorPoint = ccp(1,0);
		healthBarEarth.scaleX = 1.0f;
		
		healthBarPlayer = [CCSprite spriteWithFile:@"healthBarPlayer.gif"];
		[self addChild:healthBarPlayer z:-1];
		healthBarPlayer.position = ccp(winSize.width,10);
		healthBarPlayer.anchorPoint = ccp(1,0);
		healthBarPlayer.scaleX = 1.0f;
	}
	
	

	_enemy = [[NSMutableArray alloc] init];
	_projectile = [[NSMutableArray alloc] init];
	
	self.isTouchEnabled = YES;
	self.isAccelerometerEnabled = YES;
	[self scheduleUpdate];
	[self schedule:@selector(gameLogic:) interval:1.0];
	[self schedule:@selector(update:)];
	
	playerHP = 10;
	life = 3;
	worldHP = 30;
	score = 0;
	
	//	[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];   //BACKGROUND MUSIC
	return self;
}

-(void)gameLogic:(ccTime)dt {[self addEnemy];}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	
#define kFilteringFactor 0.1
#define kRestAccelX -0.0
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
	
	//Use accelerometer data to move the ship
	CGSize winSize = [CCDirector sharedDirector].winSize;
	float maxX = winSize.width - _player.contentSize.width/2;
	float minX = _player.contentSize.width/2;
	float newX = _player.position.x + (_playerPointsPerSecX * dt);
	newX = MIN(MAX(newX, minX), maxX);
	_player.position = ccp(newX, winSize.height * 0.1);
	
	currTime ++;
	if (laserUpgrade) {bulletSpeed = 1;}
	else {bulletSpeed = 35;}
	
	if (currTime%bulletSpeed == 0) {
		CCSprite *projectile = [CCSprite spriteWithFile:@"bullet.gif"];
	//shoot bullets
	if (laserUpgrade) {projectile = [CCSprite spriteWithFile:@"blueBullet.png"];}
	else if (gunUpgrade) {projectile = [CCSprite spriteWithFile:@"multiBullet.png"];}

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
		
		//[[SimpleAudioEngine sharedEngine] playEffect:@"pew-pew-lei.caf"];  //SHOOTING
	}
//	BOOL enemyHit = FALSE;
	
	//collision detection
	NSMutableArray *projectileToDelete = [[NSMutableArray alloc] init];
	for (CCSprite *projectile in _projectile) {
		CGRect projectileRect = CGRectMake(
										   projectile.position.x - (projectile.contentSize.width/2), 
										   projectile.position.y - (projectile.contentSize.height/2), 
										   projectile.contentSize.width, 
										   projectile.contentSize.height);
		
		NSMutableArray *enemyToDelete = [[NSMutableArray alloc] init];
		for (Enemy *enemy in _enemy) {
			CGRect enemyRect = CGRectMake(
										   enemy.position.x - (enemy.contentSize.width/2), 
										   enemy.position.y - (enemy.contentSize.height/2), 
										   enemy.contentSize.width, 
										   enemy.contentSize.height);
			if (CGRectIntersectsRect(projectileRect, enemyRect)) {
				
				[projectileToDelete addObject:projectile];
				int points = enemy.hp;
				[enemy setHp:points - 1];
				
				if (enemy.hp <= 0) {
					[enemyToDelete addObject:enemy];
				}
				break;
				
			}		
			CGRect playerRect = CGRectMake(
										   _player.position.x - (_player.contentSize.width/2), 
										   _player.position.y - (_player.contentSize.height/2), 
										   _player.contentSize.width, 
										   _player.contentSize.height);
			if (CGRectIntersectsRect(playerRect, enemyRect)) {
				[enemyToDelete addObject:enemy];
				playerHP--;
			}
		}
		for (CCSprite *enemy in enemyToDelete) {
			[_enemy removeObject:enemy];
			score++;
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
	
	if (playerHP == 0) {
		life--;
		playerHP = 15;}
	if (worldHP == 0) {
		[[CCDirector sharedDirector] replaceScene:[GameOverScreen scene]];}
	if (life == 0) {
		[[CCDirector sharedDirector] replaceScene:[GameOverScreen scene]];}

	NSLog(@"life:%d, playerHP:%d, worldHP:%d, score:%d", life, playerHP, worldHP, score);
	
	[scoreLabel setString:[NSString stringWithFormat:@"%d", score]];
	[lifeLabel setString:[NSString stringWithFormat:@"Lives:%d", life]];
	
	healthBarEarth.scaleX = worldHP/30.0;
	healthBarPlayer.scaleX = playerHP/10.0;
	
	if (score%25 == 0) {gunUpgrade = YES;}
	
	if (score%50 == 0) {gunUpgrade = NO;}
	
	if (score%100 == 0) {laserUpgrade = YES;}
	
	if (score%150 == 0) {laserUpgrade = NO;}
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

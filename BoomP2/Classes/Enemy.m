//
//  Enemy.m
//  BoomP2
//
//  Created by CS Admin on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"
#import "HelloWorldLayer.h"

@implementation Enemy
@synthesize hp = _curHp;
@synthesize minMoveDuration = _minMoveDuration;
@synthesize maxMoveDuration = _maxMoveDuration;

@end

@implementation redEnemy

+ (id)enemy {
	
    redEnemy *enemy = nil;
    if ((enemy = [[[super alloc] initWithFile:@"redEnemy.png"] autorelease])) {
        enemy.hp = 1;
        enemy.minMoveDuration = 2;
        enemy.maxMoveDuration = 4;
    }
    return enemy;
	
}

@end

@implementation blueEnemy

+ (id)enemy {
	
    blueEnemy *enemy = nil;
    if ((enemy = [[[super alloc] initWithFile:@"blueEnemy.png"] autorelease])) {
        enemy.minMoveDuration = 2;
        enemy.maxMoveDuration = 4;
		enemy.hp = 1;
	}
    
	
	return enemy;
	
}

@end

@implementation greenEnemy

+ (id)enemy {
	
    greenEnemy *enemy = nil;
    if ((enemy = [[[super alloc] initWithFile:@"greenEnemy.png"] autorelease])) {
        enemy.hp = 3;
        enemy.minMoveDuration = 3;
        enemy.maxMoveDuration = 5;
    }
    return enemy;
	
}

@end

@implementation yellowEnemy

+ (id)enemy {
	
    yellowEnemy *enemy = nil;
    if ((enemy = [[[super alloc] initWithFile:@"yellowEnemy.png"] autorelease])) {
        enemy.hp = 5;
        enemy.minMoveDuration = 4;
        enemy.maxMoveDuration = 6;
    }
    return enemy;
	
}

@end
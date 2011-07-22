//
//  Enemy.h
//  BoomP2
//
//  Created by CS Admin on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Enemy : CCSprite {
    int _currentHealth;
    int _minMoveDuration;
    int _maxMoveDuration;
}

@property (nonatomic, assign) int hp;
@property (nonatomic, assign) int minMoveDuration;
@property (nonatomic, assign) int maxMoveDuration;

@end

@interface redEnemy : Enemy {
}
+(id)enemy;
@end

@interface blueEnemy : Enemy {
}
+(id)enemy;
@end

@interface greenEnemy : Enemy {
}
+(id)enemy;
@end

@interface yellowEnemy : Enemy {
}
+(id)enemy;
@end
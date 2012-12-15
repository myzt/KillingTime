//
//  Enemy.h
//  KillingTime
//
//  Created by Yasu on 12/2/12.
//  Copyright 2012 YASUYUKI MIYAZATO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

//default size of enemy
#define ENEMY_DEFAULT_RADIUS 40

@interface Enemy : CCNode {
    CCSprite *enemy;
    BOOL isStaged;
    float radius;
    float speed;
}
@property (nonatomic, retain)CCSprite *enemy;
@property (nonatomic, readonly)BOOL isStaged;
@property (nonatomic, readonly)float radius;

- (void)moveFrom:(CGPoint)position
           scale:(float)scale
        velocity:(float)velocity
           layer:(CCLayer *)layer;
- (BOOL)hitIfCollided:(CGPoint)position;

@end

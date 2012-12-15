//
//  GameScene1.h
//  KillingTime
//
//  Created by Yasu on 12/1/12.
//  Copyright 2012 YASUYUKI MIYAZATO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "InterfaceLayer.h"
#import "EnemyController.h"

#define LAND_HEIGHT 0

@interface GameScene1 : CCScene {
    CCLayer *baseLayer;
    CCLayer *enemyLayer;
    CCLabelTTF *scoreLabel;
    NSInteger score;
    
    InterfaceLayer * interfaceLayer;
    EnemyController *enemyController;
}
@property (nonatomic, retain)CCLayer *baseLayer;
@property (nonatomic, retain)CCLayer *enemyLayer;

@property (nonatomic, retain)EnemyController *enemyController;
@property (nonatomic, retain)InterfaceLayer *interfaceLayer;

@property (nonatomic, retain)CCLabelTTF *scoreLabel;

+ (GameScene1 *)sharedInstance;

- (void)startGame;
- (void)stopGame;

- (void)pause;
- (void)resume;

- (void)gameover;

- (void)addScore:(NSInteger)reward;
- (void)resetScore;
- (NSInteger)getScore;

@end

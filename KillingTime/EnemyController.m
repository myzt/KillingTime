//
//  EnemyController.m
//  KillingTime
//
//  Created by Yasu on 12/3/12.
//  Copyright 2012 YASUYUKI MIYAZATO. All rights reserved.
//

#import "EnemyController.h"
#import "Enemy.h"
#import "GameScene1.h"


@interface EnemyController ()
- (void)stageEnemy;
@end

@implementation EnemyController
@synthesize enemies;

- (id)init{
    self = [super init];
    if (self) {
        self.enemies = [NSMutableArray arrayWithCapacity:10];
        for (int i = 0; i < 10; i++) {
            Enemy *enemy = [Enemy node];
            [self.enemies addObject:enemy];
        }
        enemyPos = 0;
        count = 70;
    }
    return self;
}

- (void)startController{
    [self schedule:@selector(stageEnemy) interval:2.0f];
}

- (void)stopController{
    [self unschedule:@selector(stageEnemy)];
    for (Enemy *e in self.enemies) {
        if (e.isStaged) {
            [e removeFromParentAndCleanup:YES];
        }
    }
}

- (void)stageEnemy{
    Enemy *e = [self.enemies objectAtIndex:enemyPos];
    if (!e.isStaged) {
        float scale = CCRANDOM_0_1()+0.5;
        float veocity = CCRANDOM_0_1()*100+50;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CGPoint position = ccp(CCRANDOM_0_1()*winSize.width, winSize.height+e.radius*scale*1.1);
        [e moveFrom:position
              scale:scale
           velocity:veocity
              layer:[GameScene1 sharedInstance].enemyLayer];
        enemyPos = (enemyPos + 1)%10;
    }
    ccTime nextTime = 0.3+(count/100);
    if (count>=30) {
        count--;
    }else{
        count = count*0.99;
    }
    [self unschedule:@selector(stageEnemy)];
    [self schedule:@selector(stageEnemy) interval:nextTime];
}

- (BOOL)checkCollision:(CGPoint)position{
    BOOL isHit = NO;
    for (Enemy *e in self.enemies) {
        if (e.isStaged) {
            isHit = [e hitIfCollided:position];
            if (isHit) {
                break;
            }
        }
    }
    return isHit;
}

- (void)dealloc{
    self.enemies = nil;
    [super dealloc];
}

@end

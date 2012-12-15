//
//  EnemyController.h
//  KillingTime
//
//  Created by Yasu on 12/3/12.
//  Copyright 2012 YASUYUKI MIYAZATO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface EnemyController : CCNode {
    NSMutableArray *enemies;
    NSInteger enemyPos;
    float count;
}
@property (nonatomic, retain)NSMutableArray *enemies;

- (void)startController;

- (void)stopController;

- (BOOL)checkCollision:(CGPoint)position;

@end

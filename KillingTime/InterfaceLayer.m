//
//  InterfaceLayer.m
//  KillingTime
//
//  Created by Yasu on 12/4/12.
//  Copyright 2012 YASUYUKI MIYAZATO. All rights reserved.
//

#import "InterfaceLayer.h"
#import "GameScene1.h"
#import "EnemyController.h"


@implementation InterfaceLayer

- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)onEnter{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (void)onExit{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

#pragma mark
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint locationInView = [touch locationInView:[touch view]];
    CGPoint location = [[CCDirector sharedDirector]convertToGL:locationInView];
    [[GameScene1 sharedInstance].enemyController checkCollision:location];
    
    return YES;
}

@end

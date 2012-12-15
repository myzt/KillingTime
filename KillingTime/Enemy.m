//
//  Enemy.m
//  KillingTime
//
//  Created by Yasu on 12/2/12.
//  Copyright 2012 YASUYUKI MIYAZATO. All rights reserved.
//

#import "Enemy.h"
#import "GameScene1.h"
#import "SimpleAudioEngine.h"

@interface Enemy ()
- (void)gotHit:(CGPoint)position;
@end

@implementation Enemy
@synthesize enemy, isStaged;
@synthesize radius;

- (id)init{
    self = [super init];
    if (self) {
        self.enemy = [CCSprite spriteWithFile:@"target.png"];
        [self addChild:self.enemy];
        radius = ENEMY_DEFAULT_RADIUS;
        isStaged = NO;
    }
    return self;
}

- (void)moveFrom:(CGPoint)position
           scale:(float)scale
        velocity:(float)velocity
           layer:(CCLayer *)layer{
    self.position = position;
    self.scale = scale;
    radius *= scale;
    
    self.enemy.color = ccc3(CCRANDOM_0_1()*100+55, CCRANDOM_0_1()*100+55, CCRANDOM_0_1()*100+55);
    
    //falling animation
    float winHeight = [[CCDirector sharedDirector] winSize].height  ;
    float duration = winHeight/velocity;
    id moveDown = [CCMoveTo actionWithDuration:duration position:ccp(position.x,-radius)];
    
    [self runAction:moveDown];
    
    [self scheduleUpdate];
    [layer addChild:self];
    isStaged = YES;
}

- (void)removeFromParentAndCleanup:(BOOL)cleanup{
    self.position = CGPointZero;
    self.scale = 1.0f;
    radius = ENEMY_DEFAULT_RADIUS;
    isStaged = NO;
    
    [super removeFromParentAndCleanup:cleanup];
}

- (BOOL)hitIfCollided:(CGPoint)position{
    BOOL isHit = ccpDistance(self.position, position) < radius;
    if (isHit) {
        [self gotHit:position];
    }
    return isHit;
}

- (void)gotHit:(CGPoint)position{
    [SimpleAudioEngine sharedEngine].effectsVolume = 1.0f;
    [[SimpleAudioEngine sharedEngine] playEffect:@"hima.mp3" pitch:2.0-self.scale pan:0.5 gain:self.scale];
    CCParticleSystem *bomb = [CCParticleSun node];
    bomb.duration = 0.3f;
    bomb.life = 0.5f;
    bomb.speed = 100;
    bomb.scale = self.scale * 2.0f;
    bomb.position = self.position;
    bomb.autoRemoveOnFinish = YES;
    [[GameScene1 sharedInstance].baseLayer addChild:bomb z:100];
    
    NSInteger score = 1;
    [[GameScene1 sharedInstance] addScore:score];
    [self removeFromParentAndCleanup:YES];
}

- (void)gameover:(CGPoint)position{
    [SimpleAudioEngine sharedEngine].effectsVolume = 0.5f;
    [[SimpleAudioEngine sharedEngine] playEffect:@"gameover.mp3"];
    CCParticleSystem *bomb = [CCParticleSun node];
    bomb.duration = 0.3f;
    bomb.life = 2.0f;
    bomb.speed = 100;
    bomb.scale = 5.0f;
    bomb.position = self.position;
    bomb.autoRemoveOnFinish = YES;
    [[GameScene1 sharedInstance].baseLayer addChild:bomb z:100];
    
    [self removeFromParentAndCleanup:YES];
    [[GameScene1 sharedInstance] gameover];
}

- (void)update:(ccTime)delta{
    CGPoint position = ccp(self.position.x, self.position.y);
    BOOL isHit = position.y < LAND_HEIGHT;
    if (isHit) {
        [self gameover:position];
    }
}

- (void)dealloc{
    self.enemy = nil;
    [super dealloc];
}

@end

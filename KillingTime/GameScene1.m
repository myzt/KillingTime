//
//  GameScene1.m
//  KillingTime
//
//  Created by Yasu on 12/1/12.
//  Copyright 2012 YASUYUKI MIYAZATO. All rights reserved.
//

#import "GameScene1.h"
#import "BackgroundLayer.h"
#import "PauseLayer.h"
#import "GameoverLayer.h"
#import "SimpleAudioEngine.h"


@interface GameScene1()
- (void)initRandom;
@end

@implementation GameScene1
@synthesize baseLayer;
@synthesize enemyLayer;
@synthesize enemyController;
@synthesize interfaceLayer;
@synthesize scoreLabel;

static GameScene1 *scene_ = nil;

+ (GameScene1 *)sharedInstance{
    if (scene_ == nil) {
        scene_ = [GameScene1 node];
    }
    return scene_;
}

- (id)init{
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        [SimpleAudioEngine sharedEngine].backgroundMusicVolume = 0.5f;
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bgm.mp3" loop:YES];
        [self initRandom];
        BackgroundLayer *background = [BackgroundLayer node];
        [self addChild:background z:-1];
        
        self.baseLayer = [CCLayer node];
        [self addChild:baseLayer z:0];
        
        self.enemyLayer = [CCLayer node];
        [self.baseLayer addChild:self.enemyLayer z:20];
        
        self.enemyController = [EnemyController node];
        [self.baseLayer addChild:self.enemyController z:-1];
        [self.enemyController startController];
        
        self.interfaceLayer = [InterfaceLayer node];
        [self.baseLayer addChild:self.interfaceLayer z:100];
        
        score = 0;
        NSString *scoreString = [NSString stringWithFormat:@"SCORE:%d", score];
        self.scoreLabel = [CCLabelTTF labelWithString:scoreString fontName:@"Helvetica" fontSize:22];
        self.scoreLabel.position = ccp(winSize.width/2, winSize.height-20);
        [self.baseLayer addChild:self.scoreLabel z:50];
        
        CCMenuItemImage *pause = [CCMenuItemImage itemWithNormalImage:@"pause.png" selectedImage:@"pause.png" target:self selector:@selector(pressPause:)];
        
        CCMenu *menu = [CCMenu menuWithItems:pause, nil];
        menu.position = ccp(winSize.width-20, winSize.height-20);
        [menu alignItemsVertically];
        [self addChild:menu];
        
    }
    return self;
}

- (void)addScore:(NSInteger)reward {
    score += reward;
    NSString *scoreString = [NSString stringWithFormat:@"SCORE:%d", score];
    [self.scoreLabel setString:scoreString];
}

- (void)resetScore {
    score = 0;
    [self addScore:0];
}

- (NSInteger)getScore{
    return score;
}

#pragma -
- (void)startGame {
    // 敵キャラクターの出現
    [self.enemyController startController];
    
    // バックグラウンドミュージックの再生開始
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"music.mp3" loop:YES];
}

- (void)stopGame {
    // 敵キャラクターを除去
    [self.enemyController stopController];
    
    // バックグラウンドミュージックの停止
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}

- (void)pause {
    // ポーズ用のレイヤーを画面の最前面に追加します。
    [self addChild:[PauseLayer node] z:100];
    
    // 動作を止めたいオブジェクトに対してスケジュール停止と
    // アクションを一時停止するメソッドを呼びます
    [self.baseLayer pauseSchedulerAndActions];
    [self.enemyController pauseSchedulerAndActions];
    CCNode *obj;
    CCARRAY_FOREACH(self.enemyLayer.children, obj) {
        [obj pauseSchedulerAndActions];
    }
    CCARRAY_FOREACH(self.baseLayer.children, obj) {
        [obj pauseSchedulerAndActions];
    }
}

- (void)resume {
    // 一時停止していたオブジェクトに対して、全てを再開します。
    [self.baseLayer resumeSchedulerAndActions];
    [self.enemyController resumeSchedulerAndActions];
    CCNode *obj;
    CCARRAY_FOREACH(self.enemyLayer.children, obj) {
        [obj resumeSchedulerAndActions];
    }
    CCARRAY_FOREACH(self.baseLayer.children, obj) {
        [obj resumeSchedulerAndActions];
    }
}

- (void)gameover {
    // ゲームオーバー用のレイヤーを画面の最前面に追加します。
    [self addChild:[GameoverLayer node] z:100];
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}

- (void)initRandom{
    struct timeval t;
    gettimeofday(&t, nil);
    unsigned int i;
    i = t.tv_usec;
    i += t.tv_usec;
    srand(i);
}

- (void) dealloc{
    self.baseLayer = nil;
    self.enemyLayer = nil;
    
    self.enemyController = nil;
    
	scene_ =nil;
	[super dealloc];
}

@end

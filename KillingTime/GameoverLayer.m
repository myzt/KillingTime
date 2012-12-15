//
//  GameoverLayer.m
//  KillingTime
//
//  Created by Yasu on 12/15/12.
//  Copyright 2012 YASUYUKI MIYAZATO. All rights reserved.
//

#import "GameoverLayer.h"
#import "GameScene1.h"

@implementation GameoverLayer

- (id)init {
    self = [super init];
    if (self) {
        // 白んだ色で画面を覆います
        CCLayerColor *shade = [CCLayerColor layerWithColor:ccc4(230, 230, 230, 200)];
        [self addChild:shade];
        
        // 画面中央にゲームオーバーのラベルを表示します
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"GAME OVER..."
                                               fontName:@"Helvetica"
                                               fontSize:32];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        label.position = ccp(winSize.width/2, winSize.height/1.5);
        [self addChild:label];
        
        // Score表示
        CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:@"潰した暇の数=100"
                                               fontName:@"Helvetica"
                                               fontSize:38];
        scoreLabel.position = ccp(winSize.width/2, winSize.height/2.5);
        [self addChild:scoreLabel];
        
        // 画面中央の下部にリプレイを促すラベルを表示します
        CCLabelTTF *replayLabel = [CCLabelTTF labelWithString:@"Tap to replay."
                                                     fontName:@"Helvetica"
                                                     fontSize:32];
        replayLabel.position = ccp(winSize.width/2, winSize.height/4);
        [self addChild:replayLabel];
    }
    return self;
}

// 本クラスがアクティブなレイヤーに登録されたタイミングで、
// タッチイベントの受信を開始します
- (void)onEnter{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (void)onExit{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    // タッチイベントを取り扱う場合はccTouchBeganを必ず実装します
    return YES;
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    // 画面がタップされたらゲームを再開します
    [self removeFromParentAndCleanup:YES];
    [[GameScene1 sharedInstance] stopGame];
    [[GameScene1 sharedInstance] resetScore];
    [[GameScene1 sharedInstance] startGame];
}
@end

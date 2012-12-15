//
//  PauseLayer.m
//  KillingTime
//
//  Created by Yasu on 12/15/12.
//  Copyright 2012 YASUYUKI MIYAZATO. All rights reserved.
//

#import "PauseLayer.h"
#import "GameScene1.h"

@implementation PauseLayer

- (id)init {
    self = [super init];
    if (self) {
        // 暗めの色で画面を覆います
        CCLayerColor *shade = [CCLayerColor layerWithColor:ccc4(30, 30, 30, 200)];
        [self addChild:shade];
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Tap to resume."
                                               fontName:@"Helvetica"
                                               fontSize:48];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        label.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:label];
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
    [[GameScene1 sharedInstance] resume];
}
@end
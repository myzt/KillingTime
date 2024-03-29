//
//  BackgroundLayer.m
//  KillingTime
//
//  Created by Yasu on 12/3/12.
//  Copyright 2012 YASUYUKI MIYAZATO. All rights reserved.
//

#import "BackgroundLayer.h"


@implementation BackgroundLayer
@synthesize space;

- (id)init {
    self = [super init];
	if (self) {
        // 雨のような表現をするCCParticleRainのパラメータを調節して、
        // 星空を実現します。
        self.space = [CCParticleRain node];
        self.space.emissionRate = 10; // パーティクルの表示数を少なく
        self.space.startSize = 2.5f; // パーティクルのサイズを小さく
        self.space.gravity = ccp(0,0); // 重力で加速しない(一定速度で移動)
        self.space.speed = 30; // スピードを遅く
        self.space.life = 10; // 消滅するまでの時間を長く
        self.space.angleVar = 0; // 移動中に揺れない
        self.space.radialAccelVar = 0;
        self.space.tangentialAccelVar = 0;
        
        [self addChild:self.space z:0];
    }
    return self;
}

- (void)dealloc {
    self.space = nil;
    [super dealloc];
}
@end

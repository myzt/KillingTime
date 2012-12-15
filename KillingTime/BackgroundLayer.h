//
//  BackgroundLayer.h
//  KillingTime
//
//  Created by Yasu on 12/3/12.
//  Copyright 2012 YASUYUKI MIYAZATO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BackgroundLayer : CCLayer {
    CCParticleSystem *space;
}
@property (nonatomic, retain)CCParticleSystem *space;

@end

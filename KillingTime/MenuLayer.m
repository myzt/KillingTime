//
//  MenuLayer.m
//  KillingTime
//
//  Created by Yasu on 11/27/12.
//  Copyright 2012 YASUYUKI MIYAZATO. All rights reserved.
//

#import "MenuLayer.h"
#import "AppDelegate.h"
#import "GameScene1.h"

@implementation MenuLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuLayer *layer = [MenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init{
    if ((self=[super init])) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCMenuItemImage *firstItem = [CCMenuItemImage itemWithNormalImage:@"button.png" selectedImage:@"button_disable.png" target:self selector:@selector(pressFirst:)];
        
        CCMenuItemImage *secondItem = [CCMenuItemImage itemWithNormalImage:@"button.png" selectedImage:@"button_disable.png" target:self selector:@selector(pressSecond:)];
        
        CCMenu *menu = [CCMenu menuWithItems:firstItem, secondItem, nil];
        menu.position = ccp(winSize.width/2, winSize.height/2);
        [menu alignItemsVertically];
        [self addChild:menu];
    }
    return self;
}

- (void)pressFirst:(id)sender{
    NSLog(@"first!!");
    [[CCDirector sharedDirector] replaceScene:[GameScene1 sharedInstance]];
}

- (void)pressSecond:(id)sender{
    NSLog(@"second!!");
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
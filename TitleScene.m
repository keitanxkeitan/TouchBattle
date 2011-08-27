//
//  TitleScene.m
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/27.
//  Copyright 2011 keitanxkeitan. All rights reserved.
//

#import "TitleScene.h"
#import "MainScene.h"

@implementation TitleScene

- (id)init {
  self = [super init];
  if (self) {
    CCLabelTTF *logo = [CCLabelTTF labelWithString:@"TouchBattle"
                                          fontName:@"Marker Felt"
                                          fontSize:48];
    logo.position = ccp(self.winSize.width/2, 240);
    
    // メニューの定義
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"start"
                                           fontName:@"Marker Felt"
                                           fontSize:32];
    CCMenuItemLabel *start = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(start)];
    CCMenu* menu = [CCMenu menuWithItems:start, nil]; // 生成した各MenuItemからメニューを作る
    [menu alignItemsHorizontally]; // メニューを横並びにする
    menu.position = ccp(self.winSize.width/2, 40); // メニューの中心位置を設定
    // レイヤーに追加
    [self addChild:logo];
    [self addChild:menu];
  }
  return self;
}

- (void)start {
  CCTransitionFade* transition = [CCTransitionPageTurn transitionWithDuration:0.5f scene:[MainScene scene]];
  [[CCDirector sharedDirector] replaceScene:transition]; 
}

@end

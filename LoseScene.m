//
//  LoseScene.m
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/27.
//  Copyright 2011 keitanxkeitan. All rights reserved.
//

#import "LoseScene.h"
#import "TitleScene.h"


@implementation LoseScene

- (id)init {
  self = [super init];
  if (self) {
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"YOU LOSE" fontName:@"Marker Felt" fontSize:48.0];
    label.position = ccp(self.winSize.width / 2, self.winSize.height / 2);
    [self addChild:label];
    
    [self runAction:[CCSequence actions:
                     [CCDelayTime actionWithDuration:3],
                     [CCCallFunc actionWithTarget:self selector:@selector(gameOverDone)],
                     nil]];
  }
  return self;
}

- (void)gameOverDone {
  CCTransitionFade* transition = [CCTransitionPageTurn transitionWithDuration:0.5f scene:[TitleScene scene]];
  [[CCDirector sharedDirector] replaceScene:transition]; 
}

@end

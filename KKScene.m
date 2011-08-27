//
//  KKScene.m
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/26.
//  Copyright 2011 keitanxkeitan. All rights reserved.
//

#import "KKScene.h"


@implementation KKScene
@synthesize winSize = winSize_;

- (id)init {
  self = [super init];
  if (self) {
    winSize_ = [[CCDirector sharedDirector] winSize];
    CCLayerColor *bg = [CCLayerColor layerWithColor:backgroundColor_
                                              width:winSize_.width
                                             height:winSize_.height];
    [self addChild:bg];
    [self schedule:@selector(update:)];
  }
  return self;
}

+ (CCScene *)scene {
  CCScene *scene = [CCScene node];
  CCLayer *layer = [[self class] node];
  [scene addChild:layer];
  return scene;
}

- (void)registerWithTouchDispatcher {
  [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self
                                                   priority:0
                                            swallowsTouches:YES];
}

- (void)update:(ccTime)dt {
}

@end

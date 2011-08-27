//
//  MainScene.m
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/26.
//  Copyright 2011 keitanxkeitan. All rights reserved.
//

#import <AudioToolbox/AudioServices.h>

#import "MainScene.h"
#import "Gauge.h"
#import "WinScene.h"
#import "LoseScene.h"
#import "GameConfig.h"
#import "SimpleAudioEngine.h"

@interface MainScene ()
- (void)shakeScreen;
@end


@implementation MainScene

- (id)init {
  self = [super init];
  if (self) {
    CCLayerColor *background = [[CCLayerColor alloc] initWithColor:ccc4(0, 0, 255, 55)];
    [self addChild:background];
    
    // 敵の設置
    NSMutableArray *blacks = [NSMutableArray array];
    for (int i = 0; i < 3; ++i) {
      Danbo *black = [[Danbo alloc] initWithPosition:ccp((self.winSize.width / 4) * (i + 1), 220.0f)
                                                type:DanboTypeBlack];
      [blacks addObject:black];
      [self addChild:black];
    }
    blacks_ = [[NSArray alloc] initWithArray:blacks];
    
    // ダンボーの設置
    NSMutableArray *danbos = [NSMutableArray array];
    for (int i = 0; i < 3; ++i) {
      Danbo *danbo = [[Danbo alloc] initWithPosition:ccp((self.winSize.width / 4) * (i + 1), 60.0f)
                                                type:i];
      [danbos addObject:danbo];
      [self addChild:danbo];
    }
    danbos_ = [[NSArray alloc] initWithArray:danbos];
    
    // ゲージの設置
    NSMutableArray *gauges = [NSMutableArray array];
    for (int i = 0; i < 3; ++i) {
      Gauge *gauge = [[Gauge alloc] initWithPosition:ccp((self.winSize.width / 4) * (i + 1), 140.0f) duration:3.0 * (i + 1)];
      [gauges addObject:gauge];
      [self addChild:gauge z:-100];
      [gauge start];
    }
    gauges_ = [[NSArray alloc] initWithArray:gauges];
    
    self.isTouchEnabled = YES;
    
    selected_ = DanboTypeNone;
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"dr_mario.mp3"];
  }
  return self;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
  CGPoint point = [self convertToWorldSpace:[self convertTouchToNodeSpace:touch]];
  for (Danbo *black in blacks_) {
    if (![black broken] && [black collideWithPoint:point]) {
      if (selected_ != DanboTypeNone) {
        KKSprite *missile = [KKSprite spriteWithFile:@"missile.png"];
        Danbo *danbo = [danbos_ objectAtIndex:selected_];
        missile.position = danbo.position;
        missile.tag = selected_ + 1;
        [self addChild:missile];
        id moveTo = [CCMoveTo actionWithDuration:1.0f position:black.position];
        id suicide = [CCCallBlockN actionWithBlock:
                      ^(CCNode *node) {
                        [node removeFromParentAndCleanup:YES];
                      }];
        id damage = [CCCallBlockN actionWithBlock:
                   ^(CCNode *node) {
                     [black damage:node.tag];
                   }];
        [missile runAction:[CCSequence actions:moveTo, suicide, damage, nil]];
        
        Gauge *gauge = [gauges_ objectAtIndex:selected_];
        [gauge start];
        selected_ = DanboTypeNone;
      }
    }
  }
  for (int i = 0; i < 3; ++i) {
    Danbo *danbo = [danbos_ objectAtIndex:i];
    if (![danbo broken] && [danbo canTouch] && [danbo collideWithPoint:point]) {
      Gauge *gauge = [gauges_ objectAtIndex:i];
      if ([gauge isFilled]) {
        [danbo jump];
        selected_ = i;
      }
    }
  }
  return YES;
}

- (void)update:(ccTime)dt {
  if (rand() % 100 == 0) {
    KKSprite *beam = [KKSprite spriteWithFile:@"beam.png"];
    Danbo *black = [blacks_ objectAtIndex:rand() % 3];
    Danbo *danbo = [danbos_ objectAtIndex:rand() % 3];
    if (![black broken] && ![danbo broken]) {
      beam.position = black.position;
      beam.tag = 2;
      [self addChild:beam];
      id moveTo = [CCMoveTo actionWithDuration:1.0f position:danbo.position];
      id suicide = [CCCallBlockN actionWithBlock:
                    ^(CCNode *node) {
                      [node removeFromParentAndCleanup:YES];
                    }];
      id damage = [CCCallBlockN actionWithBlock:
                   ^(CCNode *node) {
                     [danbo damage:node.tag];
                     [self shakeScreen];
                   }];
      [beam runAction:[CCSequence actions:moveTo, suicide, damage, nil]];
    }
  }
  
  for (int i = 0; i < 3; ++i) {
    Danbo *danbo = [danbos_ objectAtIndex:i];
    if ([danbo broken]) {
      Gauge *gauge = [gauges_ objectAtIndex:i];
      [gauge removeFromParentAndCleanup:NO];
    }
  }
  
  BOOL lose = YES;
  for (Danbo *danbo in danbos_) {
    if (![danbo broken]) {
      lose = NO;
      break;
    }
  }
  if (lose) {
    // 負け画面へ
    CCTransitionFade* transition = [CCTransitionPageTurn transitionWithDuration:0.5f scene:[LoseScene scene]];
    [[CCDirector sharedDirector] replaceScene:transition];
  }
  BOOL win = YES;
  for (Danbo *black in blacks_) {
    if (![black broken]) {
      win = NO;
      break;
    }
  }
  if (win) {
    // 勝ち画面へ
    CCTransitionFade* transition = [CCTransitionPageTurn transitionWithDuration:0.5f scene:[WinScene scene]];
    [[CCDirector sharedDirector] replaceScene:transition];
  }
}

- (void)shakeScreen{
  // 画面を揺らす処理
  AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); // 本体をバイブ
  NSMutableArray* actions = [NSMutableArray array];
  // 適当な位置に移動するイベントをFPS個分作って実行してやる
  // これで画面が揺れているように見える
  for(int i=0;i<FPS;++i){
    CCFiniteTimeAction* move = [CCMoveTo actionWithDuration:1.0/FPS 
                                                   position:ccp(5-rand()%10, 5-rand()%10)];
    [actions addObject:move];
  }
  CCFiniteTimeAction* reset = [CCMoveTo actionWithDuration:1.0/FPS position:ccp(0, 0)];
  [actions addObject:reset];
  [self runAction:[CCSequence actionsWithArray:actions]];
}

@end

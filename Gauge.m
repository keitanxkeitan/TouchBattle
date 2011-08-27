//
//  Gauge.m
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/27.
//  Copyright 2011 keitanxkeitan. All rights reserved.
//

#import "Gauge.h"
#import "SimpleAudioEngine.h"


@implementation Gauge
@synthesize isFilled = isFilled_;

- (id)initWithTexture:(CCTexture2D *)texture rect:(CGRect)rect {
  self = [super initWithTexture:texture rect:rect];
  if (self) {
    isFilled_ = NO;
  }
  return self;
}

- (id)initWithPosition:(CGPoint)point duration:(ccTime)duration {
  self = [super initWithFile:@"gauge_0.png"];
  if (self) {
    self.position = ccp(point.x, point.y);

    CCAnimation *animation = [CCAnimation animation];
    for (int i = 0; i <= 100; ++i) {
      [animation addFrameWithFilename:[NSString stringWithFormat:@"gauge_%d.png", i]];
    }
    
    CCAnimate *action = [CCAnimate actionWithDuration:duration animation:animation restoreOriginalFrame:NO];
    action_ = [[CCSequence actions:action,
                [CCCallFunc actionWithTarget:self selector:@selector(filled)],
                nil] retain];
    
    isFilled_ = NO;
  }
  return self;
}

- (void)filled {
  isFilled_ = YES;
  [self stopAction:action_];
  [[SimpleAudioEngine sharedEngine] playEffect:@"coin.wav"];   
}

- (void)start {
  isFilled_ = NO;
  [self runAction:action_];
}

@end

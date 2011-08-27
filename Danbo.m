//
//  Danbo.m
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/26.
//  Copyright 2011 keitanxkeitan. All rights reserved.
//

#import "Danbo.h"

NSString * const kDanboColors[] = {
  @"red", @"green", @"blue", @"black",
};


@implementation Danbo
@synthesize canTouch = canTouch_, broken = broken_;

- (id)initWithTexture:(CCTexture2D *)texture rect:(CGRect)rect {
  self = [super initWithTexture:texture rect:rect];
  if (self) {
    canTouch_ = YES;
    broken_ = NO;
    life_ = 5;
  }
  return self;
}

- (id)initWithPosition:(CGPoint)point type:(DanboType)type {
  NSString *filename = [NSString stringWithFormat:@"danbo_%@.png", kDanboColors[type]];
  self = [super initWithFile:filename];
  if (self) {
    self.position = ccp(point.x, point.y);
    life_ = 5;
    lifeLabel_ = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", life_]
                                    fontName:@"Marker Felt"
                                    fontSize:24];
    lifeLabel_.position = ccp(self.contentSize.width / 2, self.contentSize.height / 2);
    [self addChild:lifeLabel_ z:100];
  }
  return self;
}

- (void)jump {
  id actionBy = [CCJumpBy actionWithDuration:0.2 position:ccp(0,0) height:30 jumps:1];
  [self runAction:[CCSequence actions:actionBy,
                   [CCCallFunc actionWithTarget:self selector:@selector(jumpEnd)],
                   nil]];
  canTouch_ = NO;
}

- (void)jumpEnd {
  canTouch_ = YES;
}

- (void)damage:(int)dam {
  life_ -= dam;
  [lifeLabel_ setString:[NSString stringWithFormat:@"%d", life_]];
  if (life_ <= 0) {
    [self removeFromParentAndCleanup:NO];
    broken_ = YES;
  }
}

@end

//
//  KKSprite.m
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/26.
//  Copyright 2011 keitanxkeitan. All rights reserved.
//

#import "KKSprite.h"
#import "KKVector.h"


@implementation KKSprite
@synthesize hitArea = hitArea_;

- (id)initWithTexture:(CCTexture2D *)texture rect:(CGRect)rect {
  self = [super initWithTexture:texture rect:rect];
  if (self) {
    hitArea_ = CGRectMake(0,
                          0,
                          self.contentSize.width,
                          self.contentSize.height);
  }
  return self;
}

- (BOOL)collideWithPoint:(CGPoint)point {
  if (rotation_ == 0) {
    return CGRectContainsPoint(self.absoluteHitArea, point);
  } else {
#pragma mark TODO: 回転している場合の当たり判定
    return YES;
  }
}

- (BOOL)collideWithSprite:(KKSprite *)sprite {
  if (rotation_ == 0) {
    return CGRectContainsRect(self.absoluteHitArea, sprite.absoluteHitArea);
  } else {
#pragma mark TODO: 回転している場合の当たり判定
    return YES;
  }
}

- (BOOL)collideWithCircle:(CGPoint)center :(CGFloat)radius {
#pragma mark TODO: 円との当たり判定
  return NO;
}

- (CGFloat)distance:(KKSprite *)sprite {
  KKVector *this = [KKVector vectorWithPoint:self.anchorPoint];
  KKVector *other = [KKVector vectorWithPoint:sprite.anchorPoint];
  return [this sub:other].length;
}

- (CGRect)absoluteHitArea {
  CGPoint origin = [self convertToWorldSpaceAR:hitArea_.origin];
  return CGRectMake(origin.x - hitArea_.size.width / 2,
                    origin.y - hitArea_.size.height / 2,
                    hitArea_.size.width,
                    hitArea_.size.height);
}

- (CGPoint)center {
  return CGPointMake(position_.x + contentSize_.width / 2,
                     position_.y + contentSize_.height / 2);
}

- (double)x {
  return position_.x;
}

- (double)y {
  return position_.y;
}

- (void)setX:(double)x {
  position_.x = x;
}

- (void)setY:(double)y {
  position_.y = y;
}

@end

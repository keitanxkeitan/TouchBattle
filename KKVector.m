//
//  KKVector.m
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/26.
//  Copyright 2011 keitanxkeitan. All rights reserved.
//

#import "KKVector.h"


@implementation KKVector

@synthesize x = x_, y = y_;

+ (KKVector *)vector {
  return [[[KKVector alloc] init] autorelease];
}

+ (KKVector *)vectorWithPoint:(CGPoint)point {
  return [[[KKVector alloc] initWithPoint:point] autorelease];
}

- (id)init {
  [super init];
  x_ = 0;
  y_ = 0;
  return self;
}

- (id)initWithPoint:(CGPoint)point {
  x_ = point.x;
  y_ = point.y;
  return self;
}

- (KKVector *)set:(CGPoint)point {
  x_ = point.x;
  y_ = point.y;
  return self;
}

- (KKVector *)clone {
  return [[KKVector alloc] initWithPoint:CGPointMake(x_, y_)];
}

- (KKVector *)add:(KKVector *)v {
  x_ += v.x;
  y_ += v.y;
  return self;
}

- (KKVector *)sub:(KKVector *)v {
  x_ -= v.x;
  y_ -= v.y;
  return self;
}

- (CGFloat)scalar:(KKVector *)v {
  return x_ * v.x + y_ * v.y;
}

- (CGFloat)cross:(KKVector *)v {
  return x_ * v.y - y_ * v.x;
}

- (KKVector *)scale:(CGFloat)n {
  x_ *= n;
  y_ *= n;
  return self;
}

- (CGFloat)length {
  return hypotf(x_, y_);
}

- (KKVector *)normalize {
  if ([self length] == 0) {
    x_ = 0;
    y_ = 0;
    return self;
  } else {
    return [self scale:1 / [self length]];
  }
}

- (KKVector *)resize:(CGFloat)n {
  return [[self normalize] scale:n];
}

- (CGFloat)angle {
  return atan2(y_, x_);
}

- (KKVector *)rotate:(CGFloat)deg {
  CGFloat rad = M_PI * deg / 180;
  CGFloat tmpx = x_;
  x_ = sin(rad) * y_ + cos(rad) * x_;
  y_ = cos(rad) * y_ - sin(rad) * tmpx;
  return self;
}

- (KKVector *)reverse {
  x_ *= -1;
  y_ *= -1;
  return self;
}

- (KKVector *)zero {
  return [self set:CGPointMake(0, 0)];
}

- (KKVector *)max:(CGFloat)max {
  if ([self length] > max) {
    [self resize:max];
  }
  return self;
}

- (KKVector *)min:(CGFloat)min {
  if ([self length] < min) {
    [self resize:min];
  }
  return self;
}

- (BOOL)isEqual:(id)object {
  KKVector *v = (KKVector *)object;
  return v.x == x_ && v.y == y_;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"(%f, %f)", x_, y_];
}

@end

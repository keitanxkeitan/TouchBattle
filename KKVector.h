//
//  KKVector.h
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/26.
//  Copyright 2011 keitanxkeitan. All rights reserved.
//

#import "math.h"

@interface KKVector : NSObject {
 @private
  CGFloat x_, y_;
}
@property (assign, readwrite) CGFloat x;
@property (assign, readwrite) CGFloat y;

+ (KKVector *)vector;
+ (KKVector *)vectorWithPoint:(CGPoint)point;

- (id)init;
- (id)initWithPoint:(CGPoint)point;

- (KKVector *)set:(CGPoint)point;
- (KKVector *)clone;
- (KKVector *)add:(KKVector *)v;
- (KKVector *)sub:(KKVector *)v;
- (CGFloat)scalar:(KKVector *)v;
- (CGFloat)cross:(KKVector *)v;
- (KKVector *)scale:(CGFloat)n;
- (KKVector *)normalize;
- (KKVector *)resize:(CGFloat)n;
- (KKVector *)rotate:(CGFloat)deg;
- (KKVector *)reverse;
- (KKVector *)zero;
- (KKVector *)max:(CGFloat)max;
- (KKVector *)min:(CGFloat)min;

@property (readonly) CGFloat length;
@property (readonly) CGFloat angle;

@end

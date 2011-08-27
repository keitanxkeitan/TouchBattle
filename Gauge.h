//
//  Gauge.h
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/27.
//  Copyright 2011 keitanxkeitan. All rights reserved.
//

#import "kwing.h"

@interface Gauge : KKSprite {
 @private
  ccTime duration_;
  CCAction *action_;
  BOOL isFilled_;
}
@property (readonly) BOOL isFilled;

- (id)initWithPosition:(CGPoint)point duration:(ccTime)duration;
- (void)start;

@end

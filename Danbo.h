//
//  Danbo.h
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/26.
//  Copyright 2011 keitanxkeitan. All rights reserved.
//

#import "kwing.h"
#import "CCTouchDelegateProtocol.h"

typedef enum {
  DanboTypeRed,
  DanboTypeGreen,
  DanboTypeBlue,
  DanboTypeBlack,
  DanboTypeNone,
} DanboType;

@interface Danbo : KKSprite {
 @private
  BOOL canTouch_;
  int life_;
  BOOL broken_;
  CCLabelTTF *lifeLabel_;
}
@property (readonly) BOOL canTouch;
@property (readonly) BOOL broken;

- (id)initWithPosition:(CGPoint)point type:(DanboType)type;
- (void)jump;
- (void)damage:(int)damage;

@end

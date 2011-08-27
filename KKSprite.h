//
//  KKSprite.h
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/26.
//  Copyright 2011 keitanxkeitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCTouchDelegateProtocol.h"

@interface KKSprite : CCSprite {
 @private
  // private hitarea from 'anchor point'.
  CGRect hitArea_;
}

- (BOOL)collideWithPoint:(CGPoint)point;

@property (readwrite) CGRect hitArea;
@property (readonly) CGRect absoluteHitArea;
@property (readonly) CGPoint center;
@property (readwrite) double x;
@property (readwrite) double y;

@end

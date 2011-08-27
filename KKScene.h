//
//  KKScene.h
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/26.
//  Copyright 2011 keitanxkeitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface KKScene : CCLayer {
 @private
  ccColor4B backgroundColor_;
  CGSize winSize_;
}
@property (readonly) CGSize winSize;

// returns a CCScene that contains this layer as the only child
+ (CCScene *)scene;

- (void)update:(ccTime)dt;

@end

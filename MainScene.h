//
//  MainScene.h
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/26.
//  Copyright 2011 keitanxkeitan. All rights reserved.
//

#import "kwing.h"
#import "Danbo.h"

@interface MainScene : KKScene {
 @private
  NSArray *blacks_;  // 敵を格納しておくコンテナ
  NSArray *danbos_;   // ダンボーを格納しておくコンテナ
  NSArray *gauges_;   // ゲージを格納しておくコンテナ
  DanboType selected_;
}

@end

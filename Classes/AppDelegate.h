//
//  TouchBattleAppDelegate.h
//  TouchBattle
//
//  Created by keitanxkeitan on 11/08/26.
//  Copyright keitanxkeitan 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface TouchBattleAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end

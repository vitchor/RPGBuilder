//
//  ActionLayer.h
//  RPGBuilder
//
//  Created by Marcia  Rozenfeld on 2/25/12.
//  Copyright (c) 2012 Ufscar. All rights reserved.
//

#import "cocos2d.h"
#import "CharMovementDelegate.h"
#import "Char.h"

@class Ball;
@interface ActionLayer: CCLayer <CharMovementDelegate>{
@private
    //
    BOOL _moving;
    
	Ball *ball;
	NSArray *paddles;
	CGPoint ballStartingVelocity;
    Char *mCharacter;
    
}
- (void)movedX:(CGFloat)dx andY:(CGFloat)dy;
@end
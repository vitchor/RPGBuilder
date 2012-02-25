//
//  CharMovementDelegate.h
//  cocos2d-ios
//
//  Created by Marcia  Rozenfeld on 2/24/12.
//  Copyright (c) 2012 Ufscar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CharMovementDelegate <NSObject>
- (void)movedX:(CGFloat)dx andY:(CGFloat)dy;
@end

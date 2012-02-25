//
//  Char.h
//  cocos2d-ios
//
//  Created by Marcia  Rozenfeld on 2/24/12.
//  Copyright (c) 2012 Ufscar. All rights reserved.
//

#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Char : CCSprite <CCStandardTouchDelegate> {
@private
    
}
@property(nonatomic, readonly) CGRect rect;
@property(nonatomic, readonly) CGRect rectInPixels;

+ (id)charWithTexture:(CCTexture2D *)texture;
- (void)updatePositionWithDX:(CGFloat)dx andDY:(CGFloat)dy;
@end

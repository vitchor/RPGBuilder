//
//  Char.h
//  cocos2d-ios
//
//  Created by Marcia  Rozenfeld on 2/24/12.
//  Copyright (c) 2012 Ufscar. All rights reserved.
//

#import "cocos2d.h"
#import <Foundation/Foundation.h>
#import "CCSpriteExtended.h"

@interface Char : CCSpriteExtended <CCStandardTouchDelegate> {
    int mDx;
    int mDy; 
    Char *mainChar;
@private
    
}
@property(nonatomic, readonly) CGRect rect;
@property(nonatomic, readonly) CGRect rectInPixels;

+ (id)charWithTexture:(CCTexture2D *)texture;
+ (id)mainCharWithTexture:(CCTexture2D *)texture;

+ (Char *)mainChar;
+ (void)setMainChar:(Char *)newMainChar;

- (void)colideWithSprites:(NSMutableArray *)sprites;
- (void)updateSpeedWithDX:(CGFloat)dx andDY:(CGFloat)dy;
- (void)move;
@end

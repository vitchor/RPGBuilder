//
//  CCSpriteExtended.h
//  cocos2d-iphone
//
//  Created by Marcia  Rozenfeld on 2/25/12.
//  Copyright (c) 2012 Ufscar. All rights reserved.
//

#import "cocos2d.h"

@interface CCSpriteExtended : CCSprite 

+ (id)CCSpriteExtendedWithTexture:(CCTexture2D *)texture;

@property(nonatomic, readonly) CGRect rect;
@end

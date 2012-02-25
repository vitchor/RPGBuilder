//
//  CCSpriteExtended.m
//  cocos2d-iphone
//
//  Created by Marcia  Rozenfeld on 2/25/12.
//  Copyright (c) 2012 Ufscar. All rights reserved.
//

#import "CCSpriteExtended.h"

@implementation CCSpriteExtended

- (CGRect)rect
{
	CGSize s = [self.texture contentSize];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

+ (id)CCSpriteExtendedWithTexture:(CCTexture2D *)aTexture
{
	return [[[self alloc] initWithTexture:aTexture] autorelease];
}

@end

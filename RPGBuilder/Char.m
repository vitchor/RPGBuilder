//
//  Char.m
//  cocos2d-ios
//
//  Created by Marcia  Rozenfeld on 2/24/12.
//  Copyright (c) 2012 Ufscar. All rights reserved.
//

#import "Char.h"

@implementation Char

- (CGRect)rectInPixels
{
	CGSize s = [texture_ contentSizeInPixels];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (CGRect)rect
{
	CGSize s = [texture_ contentSize];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (void)updateSpeedWithDX:(CGFloat)dx andDY:(CGFloat)dy
{   
    mDx = dx;
    mDy = dy;
    
}

+ (id)charWithTexture:(CCTexture2D *)aTexture
{
	return [[[self alloc] initWithTexture:aTexture] autorelease];
}

- (id)initWithTexture:(CCTexture2D *)aTexture
{
	if ((self = [super initWithTexture:aTexture]) ) {
        
	}
	
	return self;
}

- (void) move
{
    CGFloat speed = 0.042;
    self.position = CGPointMake(self.position.x + mDx * speed, self.position.y + mDy *speed);
}

@end

//
//  Char.m
//  cocos2d-ios
//
//  Created by Marcia  Rozenfeld on 2/24/12.
//  Copyright (c) 2012 Ufscar. All rights reserved.
//

#import "Char.h"
#import "CCSprite.h"
#import "CCSpriteExtended.h"

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

static Char *mainChar;
+ (Char *)mainChar { return mainChar; }
+ (void)setMainChar:(Char *)newMainChar { mainChar = newMainChar; }

+ (id)charWithTexture:(CCTexture2D *)aTexture
{
	return [[[self alloc] initWithTexture:aTexture] autorelease];
}

+ (id)mainCharWithTexture:(CCTexture2D *)aTexture
{
    Char *character = [[[self alloc] initWithTexture:aTexture] autorelease];
    [self setMainChar:character];
	return character;
}

- (id)initWithTexture:(CCTexture2D *)aTexture
{
	if ((self = [super initWithTexture:aTexture]) ) {
        
	}
	
	return self;
}

- (void) move
{


}

- (void)colideWithSprites:(NSMutableArray *)sprites
{
    CGFloat speed = 0.042;
    CGPoint newPosition = CGPointMake(self.position.x + mDx * speed, self.position.y + mDy *speed);
    
    bool hit = NO;
    
    for(CCSpriteExtended *sprite in sprites){
        CGRect spriteRect = [sprite rect];
        spriteRect.origin.x += sprite.position.x;
        spriteRect.origin.y += sprite.position.y;
        
        float lowY = CGRectGetMinY(spriteRect);
        float midY = CGRectGetMidY(spriteRect);
        float highY = CGRectGetMaxY(spriteRect);
        
        float leftX = CGRectGetMinX(spriteRect);
        float rightX = CGRectGetMaxX(spriteRect);
        
        if (self.position.x > leftX && self.position.x < rightX) {
            
            float angleOffset = 0.0f; 
            
            if (self.position.y > midY && self.position.y <= highY + 60) {
                self.position = CGPointMake(self.position.x, highY + 60);
                hit = YES;
                angleOffset = (float)M_PI / 2;
            }
            
            else if (self.position.y < midY && self.position.y >= lowY - 60) {
                self.position = CGPointMake(self.position.x, lowY - 60);
                hit = YES;
                angleOffset = -(float)M_PI / 2;
            }
            
        }	        
    }
    if(!hit){
        self.position = newPosition;
    }

}

@end

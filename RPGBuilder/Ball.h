/* TouchesTest (c) Valentin Milea 2009
 */
#import "cocos2d.h"
#import "CCSpriteExtended.h"

@class Paddle;

@interface Ball : CCSpriteExtended {
@private
	CGPoint velocity;
}

@property(nonatomic) CGPoint velocity;
@property(nonatomic, readonly) float radius;

+ (id)ballWithTexture:(CCTexture2D *)texture;

- (void)move:(ccTime)delta;
- (void)collideWithPaddle:(Paddle *)paddle;
@end

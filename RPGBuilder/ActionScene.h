/* TouchesTest (c) Valentin Milea 2009
 */
#import "cocos2d.h"
#import "CharMovementDelegate.h"
#import "Char.h"

@interface ActionScene : CCScene {
@private
}
@end

@class Ball;

@interface ActionLayer: CCLayer <CharMovementDelegate>{
@private
	Ball *ball;
	NSArray *paddles;
	CGPoint ballStartingVelocity;
    Char *mCharacter;
}
- (void)movedX:(CGFloat)dx andY:(CGFloat)dy;
@end

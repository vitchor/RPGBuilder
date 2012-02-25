/* TouchesTest (c) Valentin Milea 2009
 */
#import "cocos2d.h"
#import "CharMovementDelegate.h"
#import "Char.h"

@interface ActionScene : CCScene {
@private

    CCSprite *chest1;
    CCSprite *chest2;    
    CCAction *_walkAction;
    CCAction *_moveAction;
}
@property (nonatomic, retain) CCSprite *chest1;
@property (nonatomic, retain) CCSprite *chest2;
@property (nonatomic, retain) CCAction *walkAction;
@property (nonatomic, retain) CCAction *moveAction;
@end


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

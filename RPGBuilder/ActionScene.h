/* TouchesTest (c) Valentin Milea 2009
 */
#import "cocos2d.h"
#import "CharMovementDelegate.h"
#import "Char.h"

@interface ActionScene : CCScene {
@private
 
    CCAction *_walkAction;
    CCAction *_moveAction;
    NSMutableArray *landSprites;
}
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

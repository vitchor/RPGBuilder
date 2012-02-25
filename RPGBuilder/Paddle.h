/* TouchesTest (c) Valentin Milea 2009
 */
#import "cocos2d.h"
#import "CharMovementDelegate.h"

typedef enum tagPaddleState {
	kPaddleStateGrabbed,
	kPaddleStateUngrabbed
} PaddleState;

@interface Paddle : CCSprite <CCStandardTouchDelegate> {
@private
	PaddleState state;
    CGPoint mLastTouchPoint;
    CGPoint mTouchInitialPoint;    
    NSObject<CharMovementDelegate> *movementListener;
    bool hasBeenTouched;
    
}

@property(nonatomic, readonly) CGRect rect;
@property(nonatomic, retain) NSObject<CharMovementDelegate> *movementListener;

+ (id)paddleWithTexture:(CCTexture2D *)texture;
@end

/* TouchesTest (c) Valentin Milea 2009
 */
#import "cocos2d.h"

typedef enum tagPaddleState {
	kPaddleStateGrabbed,
	kPaddleStateUngrabbed
} PaddleState;

@interface Paddle : CCSprite <CCStandardTouchDelegate> {
@private
	PaddleState state;
    CGPoint mLastTouchPoint;
    CGPoint mTouchInitialPoint;    
    bool hasBeenTouched;
    
}

@property(nonatomic, readonly) CGRect rect;
@property(nonatomic, readonly) CGRect rectInPixels;

+ (id)paddleWithTexture:(CCTexture2D *)texture;
@end

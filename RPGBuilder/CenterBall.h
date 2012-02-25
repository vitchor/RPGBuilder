#import "cocos2d.h"
#import "CharMovementDelegate.h"

@interface CenterBall : CCSprite <CCStandardTouchDelegate> {
@private
    CGPoint mLastTouchPoint;
    CGPoint mTouchInitialPoint;    
    bool hasBeenTouched;
    NSObject<CharMovementDelegate> *mMovementListener;
    
}

@property(nonatomic, readonly) CGRect rect;
@property(nonatomic, readonly) CGRect rectInPixels;
@property(nonatomic, retain) NSObject<CharMovementDelegate> *movementListener;

+ (id)centerBallWithTexture:(CCTexture2D *)texture;
@end

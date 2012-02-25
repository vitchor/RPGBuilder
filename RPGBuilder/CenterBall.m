/* TouchesTest (c) Valentin Milea 2009
 */
#import "CenterBall.h"
#import "cocos2d.h"
#import "CharMovementDelegate.h"

@implementation CenterBall

@synthesize movementListener = movementListener;

- (id)init
{
    hasBeenTouched = NO;
	[super init];
	return self;
}

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

+ (id)centerBallWithTexture:(CCTexture2D *)aTexture
{
	return [[[self alloc] initWithTexture:aTexture] autorelease];
}

- (id)initWithTexture:(CCTexture2D *)aTexture
{
	if ((self = [super initWithTexture:aTexture]) ) {
        
	}
	
	return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{  
    UITouch *t =  [[touches allObjects] objectAtIndex:0];
    CGPoint tPoint = [t locationInView:[t view]]; 
    tPoint = [[CCDirector sharedDirector] convertToGL:tPoint];    
    self.position = CGPointMake(tPoint.x, tPoint.y);
    mTouchInitialPoint = self.position;
    
    self.visible=YES; 
}
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{       
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    CGPoint touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    CGFloat dx = mTouchInitialPoint.x - touchPoint.x;
    CGFloat dy = mTouchInitialPoint.y - touchPoint.y;
    
    CGFloat r = 30;
    if (hasBeenTouched) {
        if (sqrt(dx*dx + dy*dy) < r) {
            self.position = CGPointMake(touchPoint.x, touchPoint.y);
            [movementListener movedX:-dx andY:-dy];
        } else {
            self.position = CGPointMake(mTouchInitialPoint.x  - (dx*r)/sqrt(pow(dy,2) + pow(dx,2)),mTouchInitialPoint.y  - (dy*r)/sqrt(pow(dy,2) + pow(dx,2)));
            [movementListener movedX:-(dx*r)/sqrt(pow(dy,2) + pow(dx,2)) andY:- (dy*r)/sqrt(pow(dy,2) + pow(dx,2))];
        }
        
    } else {
        hasBeenTouched = YES;
    }
;
    
    mLastTouchPoint.x = touchPoint.x;
    mLastTouchPoint.y = touchPoint.y;    
    
}
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    hasBeenTouched = NO;
    self.visible=NO; 
    [movementListener movedX:0 andY:0];
    
}
- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addStandardDelegate:self priority:0];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}	

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	// If it weren't for the TouchDispatcher, you would need to keep a reference
	// to the touch from touchBegan and check that the current touch is the same
	// as that one.
	// Actually, it would be even more complicated since in the Cocos dispatcher
	// you get NSSets instead of 1 UITouch, so you'd need to loop through the set
	// in each touchXXX method.
	
	
    
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    hasBeenTouched = NO;
    self.visible=NO;
}
@end

/* TouchesTest (c) Valentin Milea 2009
 */
#import "Paddle.h"
#import "cocos2d.h"

@implementation Paddle

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

+ (id)paddleWithTexture:(CCTexture2D *)aTexture
{
	return [[[self alloc] initWithTexture:aTexture] autorelease];
}

- (id)initWithTexture:(CCTexture2D *)aTexture
{
	if ((self = [super initWithTexture:aTexture]) ) {
	
		state = kPaddleStateUngrabbed;
	}
	
	return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{  
    self.visible=YES; 
    UITouch *t =  [[touches allObjects] objectAtIndex:0];
    CGPoint tPoint = [t locationInView:[t view]]; 
    tPoint = [[CCDirector sharedDirector] convertToGL:tPoint];    
    self.position = CGPointMake(tPoint.x, tPoint.y);
    mTouchInitialPoint = self.position;
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    hasBeenTouched = NO;
    self.visible=NO; 
    
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
	
	NSAssert(state == kPaddleStateGrabbed, @"Paddle - Unexpected state!");	
	

}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSAssert(state == kPaddleStateGrabbed, @"Paddle - Unexpected state!");	
    hasBeenTouched = NO;
	state = kPaddleStateUngrabbed;
    self.visible=NO;
}
@end

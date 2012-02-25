/* TouchesTest (c) Valentin Milea 2009
 */
#import "ActionScene.h"
#import "Paddle.h"
#import "Ball.h"
#import "CenterBall.h"
#import "Char.h"

enum tagPlayer {
	kHighPlayer,
	kLowPlayer
} Player;	

#define kStatusBarHeight 20.0f
#define k1UpperLimit (480.0f - kStatusBarHeight)

enum {
	kSpriteTag
};

@interface ActionLayer ()
@end

@implementation ActionScene

- (id)init
{
	if ((self = [super init]) == nil) return nil;
	
	ActionLayer *actionLayer = [ActionLayer node];
	[self addChild:actionLayer];
	
	return self;
}

- (void)onExit
{
	[super onExit];
}

@end

@implementation ActionLayer

- (id)init
{
	if ((self = [super init]) == nil) return nil;
	
	ballStartingVelocity = CGPointMake(20.0f, -100.0f);
	
	
	CCTexture2D *centerBallTexture = [[CCTextureCache sharedTextureCache] addImage:@"ball.png"];
	CCTexture2D *paddleTexture = [[CCTextureCache sharedTextureCache] addImage:@"outsideBall.png"];    
	CCTexture2D *charTexture = [[CCTextureCache sharedTextureCache] addImage:@"char.png"];        
	
	NSMutableArray *paddlesM = [NSMutableArray arrayWithCapacity:4];
	
    //ball = [Ball ballWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"ball.png"]];
	//ball.position = CGPointMake(160.0f, 240.0f);
	//ball.velocity = ballStartingVelocity;
	//[self addChild:ball];

    CCSprite *background = [CCSprite spriteWithFile:@"back.png"];
	background.position = CGPointMake(160, 240);
	[paddlesM addObject:background];
    
    mCharacter = [Char charWithTexture:charTexture]; //92
	mCharacter.position = CGPointMake(160, 240);
	[paddlesM addObject:mCharacter];
    
    Paddle *outsidePaddle = [Paddle paddleWithTexture:paddleTexture]; // 155
	outsidePaddle.position = CGPointMake(200, 400);
    outsidePaddle.visible = NO;
	[paddlesM addObject:outsidePaddle];
    
    CenterBall *centerBall = [CenterBall centerBallWithTexture:centerBallTexture]; //92
	centerBall.position = CGPointMake(200, 400);//480 - kStatusBarHeight - 100);
    centerBall.visible = NO;
    centerBall.movementListener = self;
	[paddlesM addObject:centerBall];
	
	paddles = [paddlesM copy];
	
	for (Paddle *paddle in paddles)
		[self addChild:paddle];
	
	[self schedule:@selector(doStep:)];
	
	return self;
}

- (void)movedX:(CGFloat)dx andY:(CGFloat)dy 
{
    [mCharacter updatePositionWithDX:dx andDY:dy];
}

- (void)dealloc
{
	[ball release];
	[paddles release];
	[super dealloc];
}

- (void)resetAndScoreBallForPlayer:(int)player
{
	ballStartingVelocity = ccpMult(ballStartingVelocity, -1.1f);
	ball.velocity = ballStartingVelocity;
	ball.position = CGPointMake(160.0f, 240.0f);
	
	// TODO -- scoring
}

- (void)doStep:(ccTime)delta
{
	[ball move:delta];
	
	for (Paddle *paddle in paddles)
		[ball collideWithPaddle:paddle];
	
	if (ball.position.y > 480 - kStatusBarHeight + ball.radius)
		[self resetAndScoreBallForPlayer:kLowPlayer];
	else if (ball.position.y < -ball.radius)
		[self resetAndScoreBallForPlayer:kHighPlayer];
}

@end

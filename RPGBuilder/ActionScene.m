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
@synthesize chest1 = chest1;
@synthesize chest2 = chest2;
@synthesize moveAction = _moveAction;
@synthesize walkAction = _walkAction;

- (id)init
{
	if ((self = [super init]) == nil) return nil;
	
	ActionLayer *actionLayer = [ActionLayer node];
	[self addChild:actionLayer];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"chest_bubble.plist"];
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode 
                                      batchNodeWithFile:@"chest_bubble.png"];
    [self addChild:spriteSheet];
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for(int i = 1; i <= 3; ++i) {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"BubbleChest%d.png", i]]];
    }
	
    CCAnimation *walkAnim = [CCAnimation 
                             animationWithFrames:walkAnimFrames delay:0.1f];
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    self.chest1 = [CCSprite spriteWithSpriteFrameName:@"BubbleChest1.png"];        
    chest1.position = ccp(winSize.width/2 - 30, winSize.height/2 + 30);
    self.walkAction = [CCRepeatForever actionWithAction:
                       [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
    [chest1 runAction:_walkAction];
    [spriteSheet addChild:chest1];
    
    self.chest2 = [CCSprite spriteWithSpriteFrameName:@"BubbleChest1.png"];        
    chest2.position = ccp(winSize.width/2 + 30 , winSize.height/2 + 30);
    self.walkAction = [CCRepeatForever actionWithAction:
                       [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
    [chest2 runAction:_walkAction];
    chest2.flipX = YES;
    [spriteSheet addChild:chest2];
    
    CCSprite *chest3 = [CCSprite spriteWithSpriteFrameName:@"BubbleChest1.png"];        
    chest3.position = ccp(winSize.width/2 - 30, winSize.height/2 - 30);
    self.walkAction = [CCRepeatForever actionWithAction:
                       [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
    [chest3 runAction:_walkAction];
    chest3.flipY = YES;
    [spriteSheet addChild:chest3];
    
    CCSprite *chest4 = [CCSprite spriteWithSpriteFrameName:@"BubbleChest1.png"];        
    chest4.position = ccp(winSize.width/2 + 30 , winSize.height/2 - 30);
    self.walkAction = [CCRepeatForever actionWithAction:
                       [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
    [chest4 runAction:_walkAction];
    chest4.flipX = YES;
    chest4.flipY = YES;    
    [spriteSheet addChild:chest4];
    
    
    
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
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"AnimBear.plist"];
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode 
                                      batchNodeWithFile:@"chest_bubble.png"];
    [self addChild:spriteSheet];
    
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
    [mCharacter updateSpeedWithDX:dx andDY:dy];
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
	[mCharacter move];
	
	for (Paddle *paddle in paddles)
		[ball collideWithPaddle:paddle];
	
	if (ball.position.y > 480 - kStatusBarHeight + ball.radius)
		[self resetAndScoreBallForPlayer:kLowPlayer];
	else if (ball.position.y < -ball.radius)
		[self resetAndScoreBallForPlayer:kHighPlayer];
}

@end

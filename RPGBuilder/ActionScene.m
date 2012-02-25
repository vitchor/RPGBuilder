/* TouchesTest (c) Valentin Milea 2009
 */
#import "ActionScene.h"
#import "Paddle.h"
#import "Ball.h"
#import "CenterBall.h"
#import "Char.h"
#import "CCSpriteExtended.h"

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
@synthesize moveAction = _moveAction;
@synthesize walkAction = _walkAction;

- (id)init
{
	if ((self = [super init]) == nil) return nil;
	
    //Background
    CCSprite *background = [CCSprite spriteWithFile:@"back.png"];
	background.position = CGPointMake(160, 240);
    [self addChild:background];
    
    //Touching Actions Layer
	ActionLayer *actionLayer = [ActionLayer node];
	[self addChild:actionLayer];
    
    //Animation spriteSheet
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"chest_bubble.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode 
                                      batchNodeWithFile:@"chest_bubble.png"];
    [self addChild:spriteSheet];
    
    //Creating Animations
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for(int i = 1; i <= 3; ++i) {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"BubbleChest%d.png", i]]];
    }
	
    CCAnimation *anim = [CCAnimation 
                             animationWithFrames:walkAnimFrames delay:0.1f];
    
    
    NSMutableArray *landSpritesC = [NSMutableArray arrayWithCapacity:4];
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCSpriteExtended *chest1 = [CCSpriteExtended spriteWithSpriteFrameName:@"BubbleChest1.png"];        
    chest1.position = ccp(winSize.width/2 - 60, winSize.height/2 + 60);
    self.walkAction = [CCRepeatForever actionWithAction:
                       [CCAnimate actionWithAnimation:anim restoreOriginalFrame:NO]];
    [chest1 runAction:_walkAction];
    [landSpritesC addObject:chest1];
    
    
    CCSpriteExtended *chest2 = [CCSpriteExtended spriteWithSpriteFrameName:@"BubbleChest1.png"];        
    chest2.position = ccp(winSize.width/2 + 60 , winSize.height/2 + 60);
    self.walkAction = [CCRepeatForever actionWithAction:
                       [CCAnimate actionWithAnimation:anim restoreOriginalFrame:NO]];
    [chest2 runAction:_walkAction];
    chest2.flipX = YES;
    [landSpritesC addObject:chest2];
    
    CCSpriteExtended *chest3 = [CCSpriteExtended spriteWithSpriteFrameName:@"BubbleChest1.png"];        
    chest3.position = ccp(winSize.width/2 - 60, winSize.height/2 - 60);
    self.walkAction = [CCRepeatForever actionWithAction:
                       [CCAnimate actionWithAnimation:anim restoreOriginalFrame:NO]];
    [chest3 runAction:_walkAction];
    chest3.flipY = YES;
    [landSpritesC addObject:chest3];
    
    CCSpriteExtended *chest4 = [CCSpriteExtended spriteWithSpriteFrameName:@"BubbleChest1.png"];        
    chest4.position = ccp(winSize.width/2 + 60 , winSize.height/2 - 60);
    self.walkAction = [CCRepeatForever actionWithAction:
                       [CCAnimate actionWithAnimation:anim restoreOriginalFrame:NO]];
    [chest4 runAction:_walkAction];
    chest4.flipX = YES;
    chest4.flipY = YES;    
    [landSpritesC addObject:chest4];
    
    landSprites = [landSpritesC copy];
	
	for (CCSpriteExtended *sprite in landSprites)
		[self addChild:sprite];
    
    [self schedule:@selector(doStep:)];

    
    
	return self;
}

- (void)doStep:(ccTime)delta
{
    
	//NSMutableArray *landSpritesC = [landSprites copy];
	bool hit = false;
	for (CCSpriteExtended *sprite in landSprites) {
		hit = hit || [[Char mainChar] colideWithSprite:sprite];
    }
    if(!hit) {
        [[Char mainChar] move];
    }
    
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


    Char *character = [Char mainCharWithTexture:charTexture]; //92
    character.position = CGPointMake(160, 240);
    [paddlesM addObject:character];


    
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
	
	//[self schedule:@selector(doStep:)];
	
	return self;
}

- (void)movedX:(CGFloat)dx andY:(CGFloat)dy 
{
    [[Char mainChar] updateSpeedWithDX:dx andDY:dy];
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

@end

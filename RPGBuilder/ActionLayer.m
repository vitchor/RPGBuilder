//
//  ActionLayer.m
//  RPGBuilder
//
//  Created by Marcia  Rozenfeld on 2/25/12.
//  Copyright (c) 2012 Ufscar. All rights reserved.
//

#import "ActionLayer.h"
#import "ActionScene.h"
#import "Paddle.h"
#import "Ball.h"
#import "CenterBall.h"
#import "Char.h"
#import "CCSpriteExtended.h"

@interface ActionLayer ()
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

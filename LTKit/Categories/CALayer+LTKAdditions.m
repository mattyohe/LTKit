//
//	CALayer+LTKAdditions.m
//	LTKit
//
//	Copyright (c) 2012 Michael Potter
//	http://lucas.tiz.ma
//	lucas@tiz.ma
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//	FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <LTKit/LTKit.h>

#import "CALayer+LTKAdditions.h"

#pragma mark External Definitions

NSTimeInterval const LTKDefaultTransitionDuration = 0.25;

#pragma mark - LTKAnimationDelegate Internal Class

@interface LTKAnimationDelegate : NSObject

@property (readwrite, nonatomic, copy) void (^startBlock)();
@property (readwrite, nonatomic, copy) void (^stopBlock)(BOOL finished);

@end

@implementation LTKAnimationDelegate

@synthesize startBlock;
@synthesize stopBlock;

#pragma mark - Protocol Implementations

#pragma mark - CAAnimation Methods (Informal)

- (void)animationDidStart:(CAAnimation *)animation
{
	if (self.startBlock != nil)
	{
		self.startBlock();
	}
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)finished
{
	if (self.stopBlock != nil)
	{
		self.stopBlock(finished);
	}
}

@end

#pragma mark -

@implementation CALayer (LTKAdditions)

#pragma mark - Property Accessors

- (CGPoint)frameOrigin
{
	return self.frame.origin;
}

- (void)setFrameOrigin:(CGPoint)frameOrigin
{
	CGRect frame = self.frame;
	frame.origin = frameOrigin;

	self.frame = frame;
}

- (CGSize)frameSize
{
	return self.frame.size;
}

- (void)setFrameSize:(CGSize)frameSize
{
	CGRect frame = self.frame;
	frame.size = frameSize;

	self.frame = frame;
}

- (CGFloat)frameX
{
	return self.frame.origin.x;
}

- (void)setFrameX:(CGFloat)frameX
{
	CGRect frame = self.frame;
	frame.origin.x = frameX;

	self.frame = frame;
}

- (CGFloat)frameY
{
	return self.frame.origin.y;
}

- (void)setFrameY:(CGFloat)frameY
{
	CGRect frame = self.frame;
	frame.origin.y = frameY;

	self.frame = frame;
}

- (CGFloat)frameWidth
{
	return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)frameWidth
{
	CGRect frame = self.frame;
	frame.size.width = frameWidth;

	self.frame = frame;
}

- (CGFloat)frameHeight
{
	return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)frameHeight
{
	CGRect frame = self.frame;
	frame.size.height = frameHeight;

	self.frame = frame;
}

- (CGFloat)frameMinX
{
	return CGRectGetMinX(self.frame);
}

- (void)setFrameMinX:(CGFloat)frameMinX
{
	self.frameX = frameMinX;
}

- (CGFloat)frameMidX
{
	return CGRectGetMidX(self.frame);
}

- (void)setFrameMidX:(CGFloat)frameMidX
{
	self.frameX = (frameMidX - (self.frameWidth / 2.0f));
}

- (CGFloat)frameMaxX
{
	return CGRectGetMaxX(self.frame);
}

- (void)setFrameMaxX:(CGFloat)frameMaxX
{
	self.frameX = (frameMaxX - self.frameWidth);
}

- (CGFloat)frameMinY
{
	return CGRectGetMinY(self.frame);
}

- (void)setFrameMinY:(CGFloat)frameMinY
{
	self.frameY = frameMinY;
}

- (CGFloat)frameMidY
{
	return CGRectGetMidY(self.frame);
}

- (void)setFrameMidY:(CGFloat)frameMidY
{
	self.frameY = (frameMidY - (self.frameHeight / 2.0f));
}

- (CGFloat)frameMaxY
{
	return CGRectGetMaxY(self.frame);
}

- (void)setFrameMaxY:(CGFloat)frameMaxY
{
	self.frameY = (frameMaxY - self.frameHeight);
}

- (CGPoint)frameTopLeftPoint
{
	return CGPointMake(self.frameMinX, self.frameMinY);
}

- (void)setFrameTopLeftPoint:(CGPoint)frameTopLeftPoint
{
	self.frameMinX = frameTopLeftPoint.x;
	self.frameMinY = frameTopLeftPoint.y;
}

- (CGPoint)frameTopMiddlePoint
{
	return CGPointMake(self.frameMidX, self.frameMinY);
}

- (void)setFrameTopMiddlePoint:(CGPoint)frameTopMiddlePoint
{
	self.frameMidX = frameTopMiddlePoint.x;
	self.frameMinY = frameTopMiddlePoint.y;
}

- (CGPoint)frameTopRightPoint
{
	return CGPointMake(self.frameMaxX, self.frameMinY);
}

- (void)setFrameTopRightPoint:(CGPoint)frameTopRightPoint
{
	self.frameMaxX = frameTopRightPoint.x;
	self.frameMinY = frameTopRightPoint.y;
}

- (CGPoint)frameMiddleRightPoint
{
	return CGPointMake(self.frameMaxX, self.frameMidY);
}

- (void)setFrameMiddleRightPoint:(CGPoint)frameMiddleRightPoint
{
	self.frameMaxX = frameMiddleRightPoint.x;
	self.frameMidY = frameMiddleRightPoint.y;
}

- (CGPoint)frameBottomRightPoint
{
	return CGPointMake(self.frameMaxX, self.frameMaxY);
}

- (void)setFrameBottomRightPoint:(CGPoint)frameBottomRightPoint
{
	self.frameMaxX = frameBottomRightPoint.x;
	self.frameMaxY = frameBottomRightPoint.y;
}

- (CGPoint)frameBottomMiddlePoint
{
	return CGPointMake(self.frameMidX, self.frameMaxY);
}

- (void)setFrameBottomMiddlePoint:(CGPoint)frameBottomMiddlePoint
{
	self.frameMidX = frameBottomMiddlePoint.x;
	self.frameMaxY = frameBottomMiddlePoint.y;
}

- (CGPoint)frameBottomLeftPoint
{
	return CGPointMake(self.frameMinX, self.frameMaxY);
}

- (void)setFrameBottomLeftPoint:(CGPoint)frameBottomLeftPoint
{
	self.frameMinX = frameBottomLeftPoint.x;
	self.frameMaxY = frameBottomLeftPoint.y;
}

- (CGPoint)frameMiddleLeftPoint
{
	return CGPointMake(self.frameMinX, self.frameMidY);
}

- (void)setFrameMiddleLeftPoint:(CGPoint)frameMiddleLeftPoint
{
	self.frameMinX = frameMiddleLeftPoint.x;
	self.frameMidY = frameMiddleLeftPoint.y;
}

- (CGPoint)boundsOrigin
{
	return self.bounds.origin;
}

- (void)setBoundsOrigin:(CGPoint)boundsOrigin
{
	CGRect bounds = self.bounds;
	bounds.origin = boundsOrigin;

	self.bounds = bounds;
}

- (CGSize)boundsSize
{
	return self.bounds.size;
}

- (void)setBoundsSize:(CGSize)boundsSize
{
	CGRect bounds = self.bounds;
	bounds.size = boundsSize;

	self.bounds = bounds;
}

- (CGFloat)boundsX
{
	return self.bounds.origin.x;
}

- (void)setBoundsX:(CGFloat)boundsX
{
	CGRect bounds = self.bounds;
	bounds.origin.x = boundsX;

	self.bounds = bounds;
}

- (CGFloat)boundsY
{
	return self.bounds.origin.y;
}

- (void)setBoundsY:(CGFloat)boundsY
{
	CGRect bounds = self.bounds;
	bounds.origin.y = boundsY;

	self.bounds = bounds;
}

- (CGFloat)boundsWidth
{
	return self.bounds.size.width;
}

- (void)setBoundsWidth:(CGFloat)boundsWidth
{
	CGRect bounds = self.bounds;
	bounds.size.width = boundsWidth;

	self.bounds = bounds;
}

- (CGFloat)boundsHeight
{
	return self.bounds.size.height;
}

- (void)setBoundsHeight:(CGFloat)boundsHeight
{
	CGRect bounds = self.bounds;
	bounds.size.height = boundsHeight;

	self.bounds = bounds;
}

- (CGFloat)boundsMinX
{
	return CGRectGetMinX(self.bounds);
}

- (void)setBoundsMinX:(CGFloat)boundsMinX
{
	self.boundsX = boundsMinX;
}

- (CGFloat)boundsMidX
{
	return CGRectGetMidX(self.bounds);
}

- (void)setBoundsMidX:(CGFloat)boundsMidX
{
	self.boundsX = (boundsMidX - (self.boundsWidth / 2.0f));
}

- (CGFloat)boundsMaxX
{
	return CGRectGetMaxX(self.bounds);
}

- (void)setBoundsMaxX:(CGFloat)boundsMaxX
{
	self.boundsX = (boundsMaxX - self.boundsWidth);
}

- (CGFloat)boundsMinY
{
	return CGRectGetMinY(self.bounds);
}

- (void)setBoundsMinY:(CGFloat)boundsMinY
{
	self.boundsY = boundsMinY;
}

- (CGFloat)boundsMidY
{
	return CGRectGetMidY(self.bounds);
}

- (void)setBoundsMidY:(CGFloat)boundsMidY
{
	self.boundsY = (boundsMidY - (self.boundsHeight / 2.0f));
}

- (CGFloat)boundsMaxY
{
	return CGRectGetMaxY(self.bounds);
}

- (void)setBoundsMaxY:(CGFloat)boundsMaxY
{
	self.boundsY = (boundsMaxY - self.boundsHeight);
}

- (CGPoint)boundsTopLeftPoint
{
	return CGPointMake(self.boundsMinX, self.boundsMinY);
}

- (void)setBoundsTopLeftPoint:(CGPoint)boundsTopLeftPoint
{
	self.boundsMinX = boundsTopLeftPoint.x;
	self.boundsMinY = boundsTopLeftPoint.y;
}

- (CGPoint)boundsTopMiddlePoint
{
	return CGPointMake(self.boundsMidX, self.boundsMinY);
}

- (void)setBoundsTopMiddlePoint:(CGPoint)boundsTopMiddlePoint
{
	self.boundsMidX = boundsTopMiddlePoint.x;
	self.boundsMinY = boundsTopMiddlePoint.y;
}

- (CGPoint)boundsTopRightPoint
{
	return CGPointMake(self.boundsMaxX, self.boundsMinY);
}

- (void)setBoundsTopRightPoint:(CGPoint)boundsTopRightPoint
{
	self.boundsMaxX = boundsTopRightPoint.x;
	self.boundsMinY = boundsTopRightPoint.y;
}

- (CGPoint)boundsMiddleRightPoint
{
	return CGPointMake(self.boundsMaxX, self.boundsMidY);
}

- (void)setBoundsMiddleRightPoint:(CGPoint)boundsMiddleRightPoint
{
	self.boundsMaxX = boundsMiddleRightPoint.x;
	self.boundsMidY = boundsMiddleRightPoint.y;
}

- (CGPoint)boundsBottomRightPoint
{
	return CGPointMake(self.boundsMaxX, self.boundsMaxY);
}

- (void)setBoundsBottomRightPoint:(CGPoint)boundsBottomRightPoint
{
	self.boundsMaxX = boundsBottomRightPoint.x;
	self.boundsMaxY = boundsBottomRightPoint.y;
}

- (CGPoint)boundsBottomMiddlePoint
{
	return CGPointMake(self.boundsMidX, self.boundsMaxY);
}

- (void)setBoundsBottomMiddlePoint:(CGPoint)boundsBottomMiddlePoint
{
	self.boundsMidX = boundsBottomMiddlePoint.x;
	self.boundsMaxY = boundsBottomMiddlePoint.y;
}

- (CGPoint)boundsBottomLeftPoint
{
	return CGPointMake(self.boundsMinX, self.boundsMaxY);
}

- (void)setBoundsBottomLeftPoint:(CGPoint)boundsBottomLeftPoint
{
	self.boundsMinX = boundsBottomLeftPoint.x;
	self.boundsMaxY = boundsBottomLeftPoint.y;
}

- (CGPoint)boundsMiddleLeftPoint
{
	return CGPointMake(self.boundsMinX, self.boundsMidY);
}

- (void)setBoundsMiddleLeftPoint:(CGPoint)boundsMiddleLeftPoint
{
	self.boundsMinX = boundsMiddleLeftPoint.x;
	self.boundsMidY = boundsMiddleLeftPoint.y;
}

- (CGFloat)positionX
{
	return self.position.x;
}

- (void)setPositionX:(CGFloat)positionX
{
	self.position = CGPointMake(positionX, self.positionY);
}

- (CGFloat)positionY
{
	return self.position.y;
}

- (void)setPositionY:(CGFloat)positionY
{
	self.position = CGPointMake(self.positionX, positionY);
}

#pragma mark - CALayer (LTKAdditions) Methods

+ (id)layerWithFrame:(CGRect)frame
{
	return [[self alloc] initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)newFrame
{
	self = [self init];

	if (self != nil)
	{
		self.frame = newFrame;
	}

	return self;
}

- (void)setAnchorPointAndPreserveCurrentPosition:(CGPoint)anchorPoint
{
	CGPoint newPoint = CGPointMake((self.boundsWidth * anchorPoint.x), (self.boundsHeight * anchorPoint.y));
	CGPoint oldPoint = CGPointMake((self.boundsWidth * self.anchorPoint.x), (self.boundsHeight * self.anchorPoint.y));

	newPoint = CGPointApplyAffineTransform(newPoint, self.affineTransform);
	oldPoint = CGPointApplyAffineTransform(oldPoint, self.affineTransform);

	CGPoint position = self.position;

	position.x -= oldPoint.x;
	position.x += newPoint.x;

	position.y -= oldPoint.y;
	position.y += newPoint.y;

	self.position = position;
	self.anchorPoint = anchorPoint;
}

+ (CGFloat)smallestWidthInLayers:(NSArray *)layers
{
	CGFloat smallestWidth = 0.0f;

	for (CALayer *layer in layers)
	{
		if (layer.frameWidth < smallestWidth)
		{
			smallestWidth = layer.frameWidth;
		}
	}

	return smallestWidth;
}

+ (CGFloat)smallestHeightInLayers:(NSArray *)layers
{
	CGFloat smallestHeight = 0.0f;

	for (CALayer *layer in layers)
	{
		if (layer.frameHeight < smallestHeight)
		{
			smallestHeight = layer.frameHeight;
		}
	}

	return smallestHeight;
}

+ (CGFloat)largestWidthInLayers:(NSArray *)layers
{
	CGFloat largestWidth = 0.0f;

	for (CALayer *layer in layers)
	{
		if (layer.frameWidth > largestWidth)
		{
			largestWidth = layer.frameWidth;
		}
	}

	return largestWidth;
}

+ (CGFloat)largestHeightInLayers:(NSArray *)layers
{
	CGFloat largestHeight = 0.0f;

	for (CALayer *layer in layers)
	{
		if (layer.frameHeight > largestHeight)
		{
			largestHeight = layer.frameHeight;
		}
	}

	return largestHeight;
}

- (CALayer *)presentationCALayer
{
	return (CALayer *)[self presentationLayer];
}

- (CALayer *)modelCALayer
{
	return (CALayer *)[self modelLayer];
}

- (void)addDefaultFadeTransition
{
	[self addFadeTransitionWithDuration:LTKDefaultTransitionDuration];
}

- (void)addDefaultMoveInTransitionWithSubtype:(NSString *)subtype
{
	[self addMoveInTransitionWithSubtype:subtype duration:LTKDefaultTransitionDuration];
}

- (void)addDefaultPushTransitionWithSubtype:(NSString *)subtype
{
	[self addPushTransitionWithSubtype:subtype duration:LTKDefaultTransitionDuration];
}

- (void)addDefaultRevealTransitionWithSubtype:(NSString *)subtype
{
	[self addRevealTransitionWithSubtype:subtype duration:LTKDefaultTransitionDuration];
}

- (void)addFadeTransitionWithDuration:(NSTimeInterval)duration
{
	CATransition *transition = [CATransition animation];		// kCATransitionFade is the default type
	transition.duration = duration;

	[self addAnimation:transition forKey:kCATransition];
}

- (void)addMoveInTransitionWithSubtype:(NSString *)subtype duration:(NSTimeInterval)duration
{
	CATransition *transition = [CATransition animation];
	transition.type = kCATransitionMoveIn;
	transition.subtype = subtype;
	transition.duration = duration;

	[self addAnimation:transition forKey:kCATransition];
}

- (void)addPushTransitionWithSubtype:(NSString *)subtype duration:(NSTimeInterval)duration
{
	CATransition *transition = [CATransition animation];
	transition.type = kCATransitionPush;
	transition.subtype = subtype;
	transition.duration = duration;

	[self addAnimation:transition forKey:kCATransition];
}

- (void)addRevealTransitionWithSubtype:(NSString *)subtype duration:(NSTimeInterval)duration
{
	CATransition *transition = [CATransition animation];
	transition.type = kCATransitionReveal;
	transition.subtype = subtype;
	transition.duration = duration;

	[self addAnimation:transition forKey:kCATransition];
}

- (void)addAnimation:(CAAnimation *)animation
{
	[self addAnimation:animation forKey:nil];
}

- (void)addAnimation:(CAAnimation *)animation forKey:(NSString *)key withStopBlock:(void (^)(BOOL finished))stopBlock
{
	[self addAnimation:animation forKey:key withStartBlock:nil stopBlock:stopBlock];
}

- (void)addAnimation:(CAAnimation *)animation forKey:(NSString *)key withStartBlock:(void (^)(void))startBlock stopBlock:(void (^)(BOOL finished))stopBlock
{
	LTKAnimationDelegate *animationDelegate = [LTKAnimationDelegate new];
	animationDelegate.startBlock = startBlock;
	animationDelegate.stopBlock = stopBlock;

	animation.delegate = animationDelegate;

	[self addAnimation:animation forKey:key];
}

- (void)replaceAnimationForKey:(NSString *)key withAnimation:(CAAnimation *)animation
{
	[self removeAnimationForKey:key];
	[self addAnimation:animation forKey:key];
}

- (UIImage *)renderToImage
{
	return [self renderToImageWithContextSize:CGSizeZero contextTransform:CGAffineTransformIdentity];
}

- (UIImage *)renderToImageWithContextSize:(CGSize)contextSize
{
	return [self renderToImageWithContextSize:contextSize contextTransform:CGAffineTransformIdentity];
}

- (UIImage *)renderToImageWithContextSize:(CGSize)contextSize contextTransform:(CGAffineTransform)contextTransform
{
	contextSize = (CGSizeEqualToSize(contextSize, CGSizeZero) ? self.frameSize : contextSize);

	UIGraphicsBeginImageContextWithOptions(contextSize, NO, 0.0f);

	CGContextRef graphicsContextRef = UIGraphicsGetCurrentContext();

	CGContextConcatCTM(graphicsContextRef, contextTransform);

	[self renderInContext:graphicsContextRef];
	UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();

	UIGraphicsEndImageContext();

	return renderedImage;
}

- (void)enableDebugBordersRecursively:(BOOL)recursively
{
	self.borderWidth = 1.0f;
	self.borderColor = [[UIColor randomColor] CGColor];

	if (recursively)
	{
		for (CALayer *sublayer in self.sublayers)
		{
			[sublayer enableDebugBordersRecursively:YES];
		}
	}
}

@end
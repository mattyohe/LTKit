//
//	UIImageView+LTKAdditions.m
//	LTKit
//
//	Copyright (c) 2011 Michael Potter
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

#import "UIImageView+LTKAdditions.h"

@implementation UIImageView (LTKAdditions)

#pragma mark - UIImageView (LTKAdditions) Methods

+ (id)imageViewWithImage:(UIImage *)image
{
	return [[self alloc] initWithImage:image];															// Autoreleased in a non-ARC environment
}

+ (id)imageViewWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
	return [[self alloc] initWithImage:image highlightedImage:highlightedImage];						// Autoreleased in a non-ARC environment
}

+ (id)imageViewWithImageNamed:(NSString *)imageName
{
	return [[self alloc] initWithImageNamed:imageName];													// Autoreleased in a non-ARC environment
}

+ (id)imageViewWithImageNamed:(NSString *)imageName highlightedImageNamed:(NSString *)highlightedImageNamed
{
	return [[self alloc] initWithImageNamed:imageName highlightedImageNamed:highlightedImageNamed];		// Autoreleased in a non-ARC environment
}

- (id)initWithImageNamed:(NSString *)imageName
{
	return [self initWithImage:[UIImage imageNamed:imageName]];
}

- (id)initWithImageNamed:(NSString *)imageName highlightedImageNamed:(NSString *)highlightedImageNamed
{
	return [self initWithImage:[UIImage imageNamed:imageName] highlightedImage:[UIImage imageNamed:highlightedImageNamed]];
}

@end
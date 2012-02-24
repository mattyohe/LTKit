//
//	UINavigationBar+LTKAdditions.m
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

#import "UINavigationBar+LTKAdditions.h"

@implementation UINavigationBar (LTKAdditions)

#pragma mark - Property Accessors

- (UIFont *)titleTextFont
{
	return [self.titleTextAttributes valueForKey:UITextAttributeFont];
}

- (void)setTitleTextFont:(UIFont *)titleTextFont
{
	NSMutableDictionary *mutableTitleTextAttributes = [self.titleTextAttributes mutableCopy];
	[mutableTitleTextAttributes setValue:titleTextFont forKey:UITextAttributeFont];
	
	self.titleTextAttributes = mutableTitleTextAttributes;
}

- (UIColor *)titleTextColor
{
	return [self.titleTextAttributes valueForKey:UITextAttributeTextColor];
}

- (void)setTitleTextColor:(UIColor *)titleTextColor
{
	NSMutableDictionary *mutableTitleTextAttributes = [self.titleTextAttributes mutableCopy];
	[mutableTitleTextAttributes setValue:titleTextColor forKey:UITextAttributeTextColor];
	
	self.titleTextAttributes = mutableTitleTextAttributes;
}

- (UIColor *)titleTextShadowColor
{
	return [self.titleTextAttributes valueForKey:UITextAttributeTextShadowColor];
}

- (void)setTitleTextShadowColor:(UIColor *)titleTextShadowColor
{
	NSMutableDictionary *mutableTitleTextAttributes = [self.titleTextAttributes mutableCopy];
	[mutableTitleTextAttributes setValue:titleTextShadowColor forKey:UITextAttributeTextShadowColor];
	
	self.titleTextAttributes = mutableTitleTextAttributes;
}

- (UIOffset)titleTextShadowOffset
{
	return [[self.titleTextAttributes valueForKey:UITextAttributeTextShadowOffset] UIOffsetValue];
}

- (void)setTitleTextShadowOffset:(UIOffset)titleTextShadowOffset
{
	NSMutableDictionary *mutableTitleTextAttributes = [self.titleTextAttributes mutableCopy];
	[mutableTitleTextAttributes setValue:[NSValue valueWithUIOffset:titleTextShadowOffset] forKey:UITextAttributeTextShadowOffset];
	
	self.titleTextAttributes = mutableTitleTextAttributes;
}

@end
//
//	UIImage+LTKAdditions.m
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

#import "UIImage+LTKAdditions.h"

@implementation UIImage (LTKAdditions)

#pragma mark - UIImage (LTKAdditions) Methods

- (UIImage *)croppedImageWithRect:(CGRect)rect
{
	CGRect drawingRect = CGRectMake((rect.origin.x * self.scale), (rect.origin.y * self.scale), (rect.size.width * self.scale),
		(rect.size.height * self.scale));

	CGImageRef croppedImageRef = CGImageCreateWithImageInRect(self.CGImage, drawingRect);
	UIImage *croppedImage = [UIImage imageWithCGImage:croppedImageRef scale:self.scale orientation:self.imageOrientation];

	CGImageRelease(croppedImageRef);

	return croppedImage;
}

- (UIImage *)imageByApplyingHighSpeedConvolution:(LTKHighSpeedConvolutionType)convolutionType kernelSize:(CGSize)kernelSize
{
	return [self imageByApplyingHighSpeedConvolution:convolutionType kernelSize:kernelSize flags:kvImageNoFlags];
}

- (UIImage *)imageByApplyingHighSpeedConvolution:(LTKHighSpeedConvolutionType)convolutionType kernelSize:(CGSize)kernelSize flags:(vImage_Flags)flags
{
	UIImage *convolvedImage = nil;

	// Kernel sizes must be odd

	uint32_t kernelWidth = (uint32_t)(LTK_VALUE_IS_ODD((NSInteger)kernelSize.width) ? kernelSize.width : (kernelSize.width + 1));
	uint32_t kernelHeight = (uint32_t)(LTK_VALUE_IS_ODD((NSInteger)kernelSize.height) ? kernelSize.height : (kernelSize.height + 1));

	// General algorithm taken from NYXImagesKit (https://github.com/Nyx0uf/NYXImagesKit)

	const size_t imageWidth = (size_t)self.size.width;
	const size_t imageHeight = (size_t)self.size.height;
	const size_t bytesPerRow = imageWidth * 4;

	CGColorSpaceRef RBGColorSpaceRef = CGColorSpaceCreateDeviceRGB();

	CGContextRef bitmapContextRef = CGBitmapContextCreate(NULL, imageWidth, imageHeight, 8, bytesPerRow, RBGColorSpaceRef,
		kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);

	CGColorSpaceRelease(RBGColorSpaceRef);

	if (bitmapContextRef != NULL)
	{
		CGContextDrawImage(bitmapContextRef, CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), self.CGImage);

		UInt8 *imageData = (UInt8 *)CGBitmapContextGetData(bitmapContextRef);

		if (imageData != NULL)
		{
			const size_t numberOfOutputBufferBytes = (sizeof(UInt8) * imageWidth * imageHeight * 4);
			void* outputBufferBytes = malloc(numberOfOutputBufferBytes);

			vImage_Buffer sourceImageBuffer = {imageData, imageHeight, imageWidth, bytesPerRow};
			vImage_Buffer destinationImageBuffer = {outputBufferBytes, imageHeight, imageWidth, bytesPerRow};

			if (convolutionType == LTKHighSpeedConvolutionTypeBox)
			{
				vImageBoxConvolve_ARGB8888(&sourceImageBuffer, &destinationImageBuffer, NULL, 0, 0, kernelHeight, kernelWidth, 0, flags);
			}
			else if (convolutionType == LTKHighSpeedConvolutionTypeTent)
			{
				vImageTentConvolve_ARGB8888(&sourceImageBuffer, &destinationImageBuffer, NULL, 0, 0, kernelHeight, kernelWidth, 0, flags);
			}

			memcpy(imageData, outputBufferBytes, numberOfOutputBufferBytes);
			free(outputBufferBytes);

			CGImageRef convolvedImageRef = CGBitmapContextCreateImage(bitmapContextRef);
			convolvedImage = [UIImage imageWithCGImage:convolvedImageRef];

			CGImageRelease(convolvedImageRef);
		}
	}

	CGContextRelease(bitmapContextRef);

	return convolvedImage;
}

- (BOOL)createFileAtPath:(NSString *)filePath
{
	return [self createFileAtPath:filePath withAttributes:nil];
}

- (BOOL)createFileAtPath:(NSString *)filePath withAttributes:(NSDictionary *)fileAttributes
{
	NSFileManager *fileManager = [NSFileManager new];
	BOOL fileCreationStatus = [fileManager createFileAtPath:filePath contents:UIImagePNGRepresentation(self) attributes:fileAttributes];

	return fileCreationStatus;
}

@end
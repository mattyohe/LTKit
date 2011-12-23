//
//	LTKMath.h
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

#import <Foundation/Foundation.h>

#define LTK_CLAMP(VALUE, MIN, MAX)	({																							\
										__typeof__(VALUE) LTK__value = (VALUE);													\
										__typeof__(MIN) LTK__min = (MIN);														\
										__typeof__(MAX) LTK__max = (MAX); 														\
										NSCAssert((LTK__min < LTK__max), @"LTK_CLAMP: MIN must be less than MAX.");				\
										(LTK__min > LTK__value ? LTK__min : (LTK__value < LTK__max ? LTK__value : LTK__max));	\
									})																							\
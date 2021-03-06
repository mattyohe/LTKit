//
//	NSObject+LTKAdditions.h
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

#import <Foundation/Foundation.h>

typedef enum LTKObjectAssociationPolicy
{
	LTKObjectAssociationPolicyRetain,
	LTKObjectAssociationPolicyAssign,
	LTKObjectAssociationPolicyCopy
}
LTKObjectAssociationPolicy;

@interface NSObject (LTKAdditions)

+ (void)performBlockAfterDelay:(NSTimeInterval)delay block:(void (^)(void))block;
+ (void)performBlockAfterDelay:(NSTimeInterval)delay inQueue:(dispatch_queue_t)queue block:(void (^)(void))block;

- (id)associatedObjectForKey:(NSString *)key;
- (void)setAssociatedObject:(id)object forKey:(NSString *)key;
- (void)setAssociatedObject:(id)object forKey:(NSString *)key associationPolicy:(LTKObjectAssociationPolicy)associationPolicy;
- (void)setAssociatedObject:(id)object forKey:(NSString *)key associationPolicy:(LTKObjectAssociationPolicy)associationPolicy atomic:(BOOL)atomic;
- (void)removeAssociatedObjectForKey:(NSString *)key;
- (void)removeAssociatedObjects;

@end
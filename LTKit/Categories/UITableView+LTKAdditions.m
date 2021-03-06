//
//	UITableView+LTKAdditions.m
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

#import "UITableView+LTKAdditions.h"

#pragma mark - Internal Definitions

static NSString *const LTKVisibleSectionRectsAssociatedObjectKey = @"LTKVisibleSectionRectsAssociatedObjectKey";
static NSString *const LTKVisibleSectionHeaderRectsAssociatedObjectKey = @"LTKVisibleSectionHeaderRectsAssociatedObjectKey";
static NSString *const LTKVisibleSectionFooterRectsAssociatedObjectKey = @"LTKVisibleSectionFooterRectsAssociatedObjectKey";
static NSString *const LTKVisibleCellRectsAssociatedObjectKey = @"LTKVisibleCellRectsAssociatedObjectKey";
static NSString *const LTKVisibleSectionDefinitionsAssociatedObjectKey = @"LTKVisibleSectionDefinitionsAssociatedObjectKey";

#pragma mark - UITableView Internal Category

@interface UITableView (LTKAdditionsInternal)

- (void)calculateVisibleRects;

@end

@implementation UITableView (LTKAdditionsInternal)

- (void)calculateVisibleRects
{
	[self removeAssociatedObjectForKey:LTKVisibleSectionRectsAssociatedObjectKey];
	[self removeAssociatedObjectForKey:LTKVisibleSectionHeaderRectsAssociatedObjectKey];
	[self removeAssociatedObjectForKey:LTKVisibleSectionFooterRectsAssociatedObjectKey];
	[self removeAssociatedObjectForKey:LTKVisibleCellRectsAssociatedObjectKey];
	[self removeAssociatedObjectForKey:LTKVisibleSectionDefinitionsAssociatedObjectKey];

	NSMutableArray *visibleSectionRects = [NSMutableArray array];
	NSMutableArray *visibleSectionHeaderRects = [NSMutableArray array];
	NSMutableArray *visibleSectionFooterRects = [NSMutableArray array];
	NSMutableArray *visibleCellRects = [NSMutableArray array];
	NSMutableArray *visibleSectionDefinitions = [NSMutableArray array];

	[self setAssociatedObject:visibleSectionRects forKey:LTKVisibleSectionRectsAssociatedObjectKey];
	[self setAssociatedObject:visibleSectionHeaderRects forKey:LTKVisibleSectionHeaderRectsAssociatedObjectKey];
	[self setAssociatedObject:visibleSectionFooterRects forKey:LTKVisibleSectionFooterRectsAssociatedObjectKey];
	[self setAssociatedObject:visibleCellRects forKey:LTKVisibleCellRectsAssociatedObjectKey];
	[self setAssociatedObject:visibleSectionDefinitions forKey:LTKVisibleSectionDefinitionsAssociatedObjectKey];

	NSArray *sectionObjects = [[self visibleSections] sortedArray];
	NSIndexPath *lastTableViewCellIndexPath = [[self indexPathsForVisibleRows] lastObject];

	CGFloat tableViewContentYOffset = self.contentOffset.y;

	if ([sectionObjects isNotEmpty])
	{
		NSInteger topSection = [[sectionObjects firstObject] integerValue];

		for (NSNumber *sectionObject in sectionObjects)
		{
			LTKTableViewSectionDefinition *visibleSectionDefinition = [LTKTableViewSectionDefinition new];

			NSInteger section = [sectionObject integerValue];

			// -rectForSection: returns the rect for a section relative to the table view's bounds, so in order for it to be made relative to the table view's
			// frame, its y coordinate is shifted by the table view's content y offset.

			CGRect sectionRect = CGRectIntersection([self rectForSection:section], self.bounds);
			sectionRect.origin.y -= tableViewContentYOffset;

			[visibleSectionRects addObject:[NSValue valueWithCGRect:sectionRect]];
			visibleSectionDefinition.visibleRect = sectionRect;

			// The section header rect is a little bit more work. -rectForHeaderInSection: does not take into consideration that the top-most section header is
			// fixed to the top of the table view. It's y coordinate is offset just as the section rect is, except that the top-most section header's y position
			// is never less than 0.0f because it is fixed. Its height is smaller than normal only when another section header is taking its place as the new
			// top-most section header by pushing it up.

			CGRect sectionHeaderRect = [self rectForHeaderInSection:section];

			if (section == topSection)
			{
				sectionHeaderRect.origin.y = MAX(0.0f, -tableViewContentYOffset);
				sectionHeaderRect.size.height = MIN(sectionHeaderRect.size.height, sectionRect.size.height);
			}
			else
			{
				sectionHeaderRect.origin.y -= tableViewContentYOffset;
			}

			// The section header rect is clipped to the table view's frame to only include the visible portion of the rect.

			sectionHeaderRect = CGRectIntersection(sectionHeaderRect, self.frame);
			NSValue *sectionHeaderRectValue = [NSValue valueWithCGRect:sectionHeaderRect];

			[visibleSectionHeaderRects addObject:sectionHeaderRectValue];
			visibleSectionDefinition.visibleHeaderRect = sectionHeaderRect;

			// We now enumerate the visible cells for the current section and determine which portion of their rects are visible.

			NSArray *visibleSectionCellIndexPaths = [self indexPathsForVisibleCellsInSection:section];
			NSMutableArray *mutableVisibleSectionCellRects = [NSMutableArray arrayWithCapacity:[visibleSectionCellIndexPaths count]];

			for (NSIndexPath *visibleSectionCellIndexPath in visibleSectionCellIndexPaths)
			{
				UITableViewCell *tableViewCell = [self cellForRowAtIndexPath:visibleSectionCellIndexPath];

				// Just like before, the table view cell's y coordinate is shifted by the table view's content y offset.

				CGRect tableViewCellRect = tableViewCell.frame;
				tableViewCellRect.origin.y -= tableViewContentYOffset;

				CGRect sectionHeaderAndTableViewCellIntersection = CGRectIntersection(sectionHeaderRect, tableViewCellRect);

				if (CGRectIsEmpty(sectionHeaderAndTableViewCellIntersection))
				{
					// If the table view cell's frame doesn't intersect with the section header's frame (indicated by CGRectIsNull or a rect with 0.0f height),
					// then the only other condition we need to check for is if this table view cell is the last one visible, in which case it is likely that
					// only a portion of it will be visible. We clip the rect to the table view's frame if necessary.

					if ([visibleSectionCellIndexPath isEqual:lastTableViewCellIndexPath])
					{
						CGRect tableViewCellAndFrameIntersection = CGRectIntersection(tableViewCellRect, self.frame);
						tableViewCellRect.size.height = tableViewCellAndFrameIntersection.size.height;
					}

					NSValue *visibleCellRectValue = [NSValue valueWithCGRect:tableViewCellRect];

					[visibleCellRects addObject:visibleCellRectValue];
					[mutableVisibleSectionCellRects addObject:visibleCellRectValue];
				}
				else
				{
					// If the table view cell's frame does intersect with the section header's frame, then we adjust the frame to only include the portion that
					// isn't obscured by the section header.

					CGRect sectionRectTableViewCellPartialFrame = tableViewCellRect;
					sectionRectTableViewCellPartialFrame.origin.y = CGRectGetMaxY(sectionHeaderRect);
					sectionRectTableViewCellPartialFrame.size.height = (CGRectGetMaxY(tableViewCellRect) - CGRectGetMaxY(sectionHeaderRect));

					// Only in the case where the table view cell is not completely covered by a section header is it included as a visible rect.

					if (sectionRectTableViewCellPartialFrame.size.height > 0.0f)
					{
						NSValue *partialVisibleCellRectValue = [NSValue valueWithCGRect:sectionRectTableViewCellPartialFrame];

						[visibleCellRects addObject:partialVisibleCellRectValue];
						[mutableVisibleSectionCellRects addObject:partialVisibleCellRectValue];
					}
				}
			}

			visibleSectionDefinition.visibleCells = mutableVisibleSectionCellRects;

			[visibleSectionDefinitions addObject:visibleSectionDefinition];
		}
	}
}

@end

@implementation UITableView (LTKAdditions)

#pragma mark - UITableView (LTKAdditions)

- (NSArray *)visibleSections
{
	return [[self indexPathsForVisibleRows] valueForKeyPath:@"@distinctUnionOfObjects.section"];
}

- (NSArray *)indexPathsForVisibleCellsInSection:(NSInteger)section
{
	NSPredicate *visibleSectionRowsPredicate = [NSPredicate predicateWithFormat:@"section == %ld", (long)section];

	return [[self indexPathsForVisibleRows] filteredArrayUsingPredicate:visibleSectionRowsPredicate];
}

- (NSArray *)visibleSectionRects
{
	[self calculateVisibleRects];

	return [[self associatedObjectForKey:LTKVisibleSectionRectsAssociatedObjectKey] copy];
}

- (NSArray *)visibleSectionHeaderRects
{
	[self calculateVisibleRects];

	return [[self associatedObjectForKey:LTKVisibleSectionHeaderRectsAssociatedObjectKey] copy];
}

- (NSArray *)visibleCellRects
{
	[self calculateVisibleRects];

	return [[self associatedObjectForKey:LTKVisibleCellRectsAssociatedObjectKey] copy];
}

- (NSArray *)visibleSectionDefinitions
{
	[self calculateVisibleRects];

	return [[self associatedObjectForKey:LTKVisibleSectionDefinitionsAssociatedObjectKey] copy];
}

@end
//
//  DGControllerTests.m
//  DGFrameworkTests
//
//  Created by chapbr on 5/9/09.
//  Copyright 2009 Brian Chapados. All rights reserved.
//

#import "DGControllerTests.h"

static NSString *emptyPrefix = @"Simple";
static NSString *dgraphExt = @"dgraph";
static NSString *emptyDgraphFile = @"Simple.dgraph";

@implementation DGControllerTests

- (void) testCreateEmpty
{
    DGController *dgc = [DGController createEmpty];
    GHAssertNotNil(dgc, @"DGController should not be nil");
}

- (void) testControllerWithContentsOfFile
{
    DGController *dgc = [DGController controllerWithContentsOfFile:
                         [TEST_RESOURCES stringByAppendingPathComponent:
                          emptyDgraphFile]];
    GHAssertNotNil(dgc, @"DGController should not be nil");
}

- (void) testControllerWithFileInBundle
{
    DGController *dgc = [DGController controllerWithFileInBundle:emptyDgraphFile];
    GHAssertNotNil(dgc, @"DGController should not be nil");
}

- (void) testResolveScriptNameInBundle
{
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:emptyPrefix ofType:dgraphExt];
    GHAssertEqualObjects(path,
                         [DGController resolveScriptNameInBundle:emptyPrefix], nil);
}

- (void) testScriptName
{
    DGController *dgcInBundle = [DGController
                                 controllerWithFileInBundle:emptyDgraphFile];
    DGController *dgcFromFile = [DGController controllerWithContentsOfFile:
                                 [TEST_RESOURCES stringByAppendingPathComponent:
                                  emptyDgraphFile]];
    GHAssertEqualObjects(emptyDgraphFile, [dgcInBundle scriptName], nil);
    GHAssertEqualObjects(emptyDgraphFile, [dgcFromFile scriptName], nil);
}

#pragma mark -
#pragma mark Data Columns

- (DGController *) defaultController
{
    return [DGController
            controllerWithFileInBundle:emptyDgraphFile];
}

- (void) testNumberOfColumns
{
    DGController *dgc = [self defaultController];
    GHAssertEquals([dgc numberOfDataColumns], 4, nil);
}

- (void) testDataColumns
{
    DGController *dgc = [self defaultController];
    NSArray *columns = [dgc dataColumns];
    // BRC: #numberOfDataColumns returns int.
    // should return NSUInteger to match the standard return type of Foundation collections
    GHAssertEquals((NSUInteger)[columns count],
                   (NSUInteger)[dgc numberOfDataColumns], nil);
    for ( DGDataColumn *c in columns ) {
        GHAssertTrue([c isKindOfClass:[DGDataColumn class]],
                     @"column should be a DGDataColumn");
    }
}

- (void) testDataColumnAtIndex
{
    DGController *dgc = [self defaultController];
    NSUInteger columnCount = [dgc numberOfDataColumns];
    NSUInteger i;
    for ( i = 0; i < columnCount; i++ ) {
        DGDataColumn *c = [dgc dataColumnAtIndex:i];
        GHAssertNotNil(c, @"column should not be nil");
    }
}

- (void) testDataColumnWithName
{
    DGController *dgc = [self defaultController];
    
    DGDataColumn *y1 = [dgc dataColumnAtIndex:2];
    DGDataColumn *colY = [dgc columnWithName:@"y"];
    // BRC: should be identical pointers ( == )? or just objects ( -isEqual )? 
    GHAssertEquals(colY, y1, nil); // pointers
}

@end

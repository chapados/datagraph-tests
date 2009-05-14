//
//  DGControllerTests.m
//  DGFrameworkTests
//
//  Created by chapbr on 5/9/09.
//  Copyright 2009 Brian Chapados. All rights reserved.
//

#import "DGControllerTests.h"

static NSString *simplePrefix = @"Simple";
static NSString *dgraphExt = @"dgraph";
static NSString *simpleDgraphFile = @"Simple.dgraph";

@implementation DGControllerTests
@synthesize dgc;

- (DGController *) defaultController
{
    return [DGController
            controllerWithFileInBundle:simpleDgraphFile];
}

- (void) setUp
{
    [self setDgc:[self defaultController]];
}

- (void) tearDown
{
    [dgc release], dgc = nil;
}

- (void) testCreateEmpty
{
    DGController *emptyController = [DGController createEmpty];
    GHAssertNotNil(emptyController, @"DGController should not be nil");
}

- (void) testControllerWithContentsOfFile
{
    DGController *controller = [DGController controllerWithContentsOfFile:
                         [TEST_RESOURCES stringByAppendingPathComponent:
                          simpleDgraphFile]];
    GHAssertNotNil(controller, @"DGController should not be nil");
}

- (void) testControllerWithFileInBundle
{
    DGController *controller = [DGController controllerWithFileInBundle:simpleDgraphFile];
    GHAssertNotNil(controller, @"DGController should not be nil");
}

- (void) testResolveScriptNameInBundle
{
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:simplePrefix ofType:dgraphExt];
    GHAssertEqualObjects(path,
                         [DGController resolveScriptNameInBundle:simplePrefix], nil);
}

- (void) testScriptName
{
    DGController *dgcInBundle = [DGController
                                 controllerWithFileInBundle:simpleDgraphFile];
    DGController *dgcFromFile = [DGController controllerWithContentsOfFile:
                                 [TEST_RESOURCES stringByAppendingPathComponent:
                                  simpleDgraphFile]];
    GHAssertEqualObjects([dgcInBundle scriptName], simpleDgraphFile, nil);
    GHAssertEqualObjects([dgcFromFile scriptName], simpleDgraphFile, nil);
}

#pragma mark -
#pragma mark Data Columns

- (void) testNumberOfColumns
{
    GHAssertEquals([[self dgc] numberOfDataColumns], 6, nil);
}

- (void) testDataColumns
{
    NSArray *columns = [[self dgc] dataColumns];
    // BRC: #numberOfDataColumns returns int.
    // should return NSUInteger to match the standard return type of Foundation collections
    GHAssertEquals((NSUInteger)[columns count],
                   (NSUInteger)[[self dgc] numberOfDataColumns], nil);
    for ( DGDataColumn *c in columns ) {
        GHAssertTrue([c isKindOfClass:[DGDataColumn class]],
                     @"column should be a DGDataColumn");
    }
}

- (void) testDataColumnAtIndex
{
    NSUInteger columnCount = [[self dgc] numberOfDataColumns];
    NSArray *dataColumns = [[self dgc] dataColumns];

    NSUInteger i;
    for ( i = 0; i < columnCount; i++ ) {
        DGDataColumn *c = [[self dgc] dataColumnAtIndex:i];
        GHAssertNotNil(c, @"column should not be nil");
        GHAssertEquals(c, [dataColumns objectAtIndex:i], nil);
    }
}

- (void) testColumnWithName
{    
    DGDataColumn *y1 = [[self dgc] dataColumnAtIndex:2];
    DGDataColumn *colY = [[self dgc] columnWithName:@"y"];
    GHAssertEquals(colY, y1, nil); // pointer equality
}

- (void) getColumnWithName:(NSString *)aName
{
    tempColumn = [[[self dgc] columnWithName:aName] retain];
}

- (void) testColumnWithNameOnMainThread
{
    DGDataColumn *y1 = [[self dgc] dataColumnAtIndex:2];
    [self performSelectorOnMainThread:@selector(getColumnWithName:) withObject:@"y" waitUntilDone:YES];
    DGDataColumn *colY = tempColumn;
    GHAssertEquals(colY, y1, nil); // pointers
    [colY release];
    colY = nil, tempColumn = nil;
}

- (void) testBinaryColumnWithName
{    
    DGDataColumn *binCol1 = [[self dgc] dataColumnAtIndex:4];
    GHAssertEqualObjects([binCol1 name], @"binCol", nil);
    DGDataColumn *binCol = [[self dgc] binaryColumnWithName:@"binCol"];
    GHAssertEquals(binCol, binCol1, nil);
}

- (void) testAddColumnWithName
{
    NSUInteger columnCount = [[self dgc] numberOfDataColumns];
    DGDataColumn *newCol = [[self dgc] addDataColumnWithName:@"newCol" type:@"Ascii"];
    GHAssertNotNil(newCol, nil);
    GHAssertEquals((NSUInteger)[[self dgc] numberOfDataColumns], columnCount+1, nil);
}


@end

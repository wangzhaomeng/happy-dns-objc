//
//  QNNetworkTest.m
//  HappyDNS
//
//  Created by bailong on 15/7/15.
//  Copyright (c) 2015年 Qiniu Cloud Storage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QNNetworkInfo.h"

@interface QNNetworkTest : XCTestCase

@end

@implementation QNNetworkTest

- (void)setUp {
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}

- (void)testNetworkChange {
	BOOL changed = [QNNetworkInfo isNetworkChanged];
	XCTAssertTrue(changed, @"PASS");
	changed =[QNNetworkInfo isNetworkChanged];
	XCTAssertTrue(!changed, @"PASS");
}

@end

//
//  PersonUniversityTests.m
//  PersonUniversityTests
//
//  Created by 何亚运 on 16/11/8.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AnmationTestViewController.h"


@interface PersonUniversityTests : XCTestCase
@property (nonatomic, strong) AnmationTestViewController *VC;
@end

@implementation PersonUniversityTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.VC = [[AnmationTestViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.VC = nil;
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSInteger number = [self.VC getNumber:100];
    XCTAssertEqual(number, 100);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    // 性能测试
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        for (int i = 0; i<100; i++) {
            for (int j = 0; j<10; j++) {
                NSLog(@"%d",j);
            }
            NSLog(@"%d",i);
        }
    }];
}

@end

//
//  ClientAppTests.m
//  ClientAppTests
//
//  Created by Melek Ramki on 2022-11-04.
//

#import <XCTest/XCTest.h>
#import "Client+Employees.h"
#import "Client.h"
#import "MockClient.h"

@interface ClientTests : XCTestCase

@property Client *sut;
@property MockClient *sutMock;
@property XCTestExpectation *success;
@property XCTestExpectation *failure;

@end

@implementation ClientTests

- (void)setUp {
    self.sut = [Client defaultClient];
    self.sutMock = [MockClient defaultClient];
}

- (void)tearDown {
    self.sut = nil;
    self.sutMock = nil;
    self.success = nil;
    self.failure = nil;
    [super tearDown];
}

- (void)testMockedClient {
    self.success = [self expectationWithDescription:@"success"];

    [self.sutMock attemptMock:GET toEndPoint:@"/success/" withParams:nil selector:[Selector perform:@selector(onResponse:) by:self] successHanlder:^(id _Nullable responseObject, ResponseObject *__autoreleasing _Nullable *_Nullable selectorObject) {
        *selectorObject = responseObject;
    } andFailureHandler:nil];

    [self waitForExpectationsWithTimeout: 3 handler:^(NSError *error) {
        if (error != nil) {
            XCTFail(@"timeout");
        }
    }];
}

- (void)testUnsupportedUrl{
    self.failure = [self expectationWithDescription:@"failure"];

    [self.sut attempt:GET toEndPoint:@"/fail/" withParams:nil selector:[Selector perform:@selector(onResponse:) by:self] successHanlder:^(id _Nullable responseObject, ResponseObject *__autoreleasing _Nullable *_Nullable selectorObject) {
        *selectorObject = responseObject;
    } andFailureHandler:nil];

    [self waitForExpectationsWithTimeout: 3 handler:^(NSError *error) {
        if (error != nil) {
            XCTFail(@"timeout");
        }
    }];
}

- (void)onResponse:(Response *)response {
    switch ([response responseCode]) {
        case ResponseCodeSuccessful: {
            [self.success  fulfill];
        } break;
        case ResponseCodeNoConnection:
        case ResponseCodeError:
        case ResponseCodeFailed: {
            [self.failure  fulfill];
        } break;
    }
}

@end

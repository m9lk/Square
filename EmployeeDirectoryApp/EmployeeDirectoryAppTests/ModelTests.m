//
//  EmployeeDirectoryAppTests.m
//  EmployeeDirectoryAppTests
//
//  Created by Melek Ramki on 2022-11-01.
//

#import <XCTest/XCTest.h>
#import "Employee.h"
#import "Employees.h"

@interface ModelTests : XCTestCase

@property Employee *employee;
@property Employee *controlEmployee;
@property Employees *employees;

@end

@implementation ModelTests

- (void)setUp {
    //Mock Employee Json Response
    NSString *employeeJsonFilePath = [[NSBundle mainBundle] pathForResource:@"EmployeeJson" ofType:@"json"];
    NSData *employeeJsonData = [[NSData alloc] initWithContentsOfFile:employeeJsonFilePath];
    NSDictionary *employeeJsonDict = [NSJSONSerialization JSONObjectWithData:employeeJsonData options:0 error:nil];
    self.employee  = [[Employee alloc] initWithDictionary:employeeJsonDict];
    
    //Mock Employees Json Response
    NSString *employeesJsonFilePath = [[NSBundle mainBundle] pathForResource:@"EmployeesJson" ofType:@"json"];
    NSData *employeesJsonData = [[NSData alloc] initWithContentsOfFile:employeesJsonFilePath];
    NSDictionary *employeesJsonDict = [NSJSONSerialization JSONObjectWithData:employeesJsonData options:0 error:nil];
    self.employees  = [[Employees alloc] initWithDictionary:employeesJsonDict];
    
    self.controlEmployee = [self.employees objectAtIndex:1];
}

- (void)tearDown {
    self.employees = nil;
    self.employee = nil;
    self.controlEmployee = nil;
    [super tearDown];
}

- (void)testEmployeeModel {
    XCTAssert([self.employee.uuid isEqual:@"0d8fcc12-4d0c-425c-8355-390b312b909c"]);
    XCTAssert([self.employee.fullname isEqual:@"Justine Mason"]);
    XCTAssert([self.employee.phone isEqual:@"5553280123"]);
    XCTAssert([self.employee.email isEqual:@"jmason.demo@squareup.com"]);
    XCTAssert(self.employee.type == FULL_TIME);
}

- (void)testEmployeesUnwrapping {
    XCTAssert([self.employees count] == 2);
    XCTAssertEqualObjects(self.controlEmployee, self.employee);
}

@end

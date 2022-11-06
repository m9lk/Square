//
//  Client (Employees).m
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-02.
//

#import "Client+Employees.h"

#define CLIENT_ENDPOINT_EMPLOYEES @"https://s3.amazonaws.com/sq-mobile-interview/employees.json"

#define CLIENT_ENDPOINT_EMPLOYEES_EMPTY @"https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"

#define CLIENT_ENDPOINT_EMPLOYEES_MALFORMED @"https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"

@implementation Client (Employees)

- (void)getEmployeesWithSelector:(Selector *)selector {
    
    NSString *encodedEndpoint = [CLIENT_ENDPOINT_EMPLOYEES stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    [self attempt:GET toEndPoint:encodedEndpoint withParams:nil selector:selector successHanlder:^(id _Nullable responseObject, ResponseObject *__autoreleasing _Nullable *_Nullable selectorObject) {
        *selectorObject = responseObject;
    } andFailureHandler:nil];
}

@end

//
//  ResponseError.h
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-02.
//

#import <Foundation/Foundation.h>

#define CLIENT_RESPONSE_ERROR_CODE @"errorCode"
#define CLIENT_RESPONSE_ERROR_DESCRIPTION @"errorDescription"

@interface ResponseError : NSDictionary

#pragma mark - Public Methods

- (NSInteger)errorCode;

- (NSString *)errorDescription;

@end

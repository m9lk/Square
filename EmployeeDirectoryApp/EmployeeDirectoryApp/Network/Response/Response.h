//
//  Response.h
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-02.
//

#import <Foundation/Foundation.h>
#import "ResponseError.h"

#define CLIENT_RESPONSE_CODE @"responseCode"
#define CLIENT_RESPONSE_OBJECT @"responseObject"
#define CLIENT_RESPONSE_ERROR @"errorObject"

typedef NS_ENUM(NSInteger) {
    ResponseCodeSuccessful = 0,
    ResponseCodeNoConnection = 1,
    ResponseCodeError = 2,
    ResponseCodeFailed = 3
} ResponseCode;

typedef NSDictionary Response;

typedef NSDictionary ResponseObject;

@interface NSDictionary (Response)

#pragma mark - Public Methods

- (ResponseCode)responseCode;

- (ResponseObject *)responseObject;

- (ResponseError *)responseError;

#pragma mark - Class Methods

+ (Response *)responseWithCode:(ResponseCode)responseCode;

+ (Response *)responseWithCode:(ResponseCode)responseCode dataTask:(NSURLSessionDataTask *)dataTask error:(NSError *)error;

+ (Response *)responseWithObject:(ResponseObject *)responseObject;

@end


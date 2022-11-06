//
//  Response.m
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-02.
//

#import "Response.h"

@implementation NSDictionary (Response)

#pragma mark - Public Methods Implementation

- (ResponseCode)responseCode {
    
    return [[self objectForKey:CLIENT_RESPONSE_CODE] integerValue];
}

- (ResponseObject *)responseObject {
    
    return [self objectForKey:CLIENT_RESPONSE_OBJECT];
}

- (ResponseError *)responseError {
    
    return [self objectForKey:CLIENT_RESPONSE_ERROR];
}

#pragma mark - Class Methods Implementation

+ (Response *)responseWithCode:(ResponseCode)responseCode {
    
    return [self responseWithCode:responseCode dataTask:nil error:nil];
}

+ (Response *)responseWithCode:(ResponseCode)responseCode dataTask:(NSURLSessionDataTask *)dataTask error:(NSError *)error {
    
    ResponseError *responseError = [self parseDataTask:dataTask error:error];
    if (responseError) {
        return @{CLIENT_RESPONSE_CODE:[NSNumber numberWithInteger:responseCode],
                 CLIENT_RESPONSE_ERROR:responseError};
    }
    return @{CLIENT_RESPONSE_CODE:[NSNumber numberWithInteger:responseCode]};
}

+ (Response *)responseWithObject:(ResponseObject *)responseObject {
    
    return @{CLIENT_RESPONSE_CODE:[NSNumber numberWithInteger:ResponseCodeSuccessful],
             CLIENT_RESPONSE_OBJECT:responseObject};
}

+ (ResponseError *)parseDataTask:(NSURLSessionDataTask *)dataTask error:(NSError *)error {
    
    if (dataTask) {
        NSHTTPURLResponse *errorResponse = (NSHTTPURLResponse *)dataTask.response;
        if (error) {
            return [[ResponseError alloc] initWithDictionary:
                    @{CLIENT_RESPONSE_ERROR_CODE:[NSNumber  numberWithInteger:errorResponse.statusCode],
                      CLIENT_RESPONSE_ERROR_DESCRIPTION:error.localizedDescription}];
        } else {
            return [[ResponseError alloc] initWithDictionary:
                    @{CLIENT_RESPONSE_ERROR_CODE:[NSNumber numberWithInteger:errorResponse.statusCode]}];
        }
    }
    return nil;
}

@end

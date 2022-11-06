//
//  Request.h
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-02.
//

#import <Foundation/Foundation.h>
#import "Selector.h"

typedef NS_ENUM(NSInteger) {
    POST = 0,
    GET = 1,
    PUT = 2,
    DELETE = 3,
    PATCH = 4
    
} RequestType;

@interface Request : NSObject

#pragma mark - Public Properties

@property RequestType type;
@property NSString *_Nonnull URL;
@property NSString *_Nonnull endPoint;
@property Selector *_Nullable selector;

@property void (^ _Nullable successHandler)(id _Nullable responseObject, ResponseObject *_Nullable*_Nullable notificationObject);

@property void (^ _Nullable failureHandler)(NSError * _Nonnull error);

@end

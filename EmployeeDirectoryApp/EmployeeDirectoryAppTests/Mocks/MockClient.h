//
//  MockClient.h
//  EmployeeDirectoryAppTests
//
//  Created by Melek Ramki on 2022-11-05.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "Response.h"
#import "Selector.h"

NS_ASSUME_NONNULL_BEGIN

@interface MockClient : NSObject

#pragma mark - Instance

+ (instancetype _Nonnull)defaultClient;

- (void)attemptMock:(RequestType)requestType
     toEndPoint:(NSString *_Nonnull)endPoint
     withParams:(NSDictionary *_Nullable)parameters
       selector:(Selector *_Nullable)selector
 successHanlder:(void (^_Nullable)(id _Nullable responseObject, ResponseObject *_Nullable*_Nullable selectorObject))successHandler
andFailureHandler:(void (^_Nullable)(NSError * _Nonnull error))failureHandler;

@end

NS_ASSUME_NONNULL_END

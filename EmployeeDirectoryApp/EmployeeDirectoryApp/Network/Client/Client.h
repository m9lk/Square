//
//  Client.h
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-02.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "Response.h"
#import "Selector.h"

NS_ASSUME_NONNULL_BEGIN

@interface Client : NSObject

#pragma mark - Instance

/**
 Client default instance
 
 @return The current instance of the client.
 */
+ (instancetype _Nonnull)defaultClient;

#pragma mark - Make Request

/**
 Attempts a request of a specified type
 
 @param requestType The type of request (POST, PUT or GET).
 @param endPoint The endpoint to which the request will be made.
 @param parameters The body of the request.
 @param selector The selector that handles the response after it has been parsed by the success or failure handler.
 @param successHandler _Nullable completion handler for a succesful request.
 @param failureHandler _Nullable completion handler for a failed request.
 */
- (void)attempt:(RequestType)requestType
     toEndPoint:(NSString *_Nonnull)endPoint
     withParams:(NSDictionary *_Nullable)parameters
       selector:(Selector *_Nullable)selector
 successHanlder:(void (^_Nullable)(id _Nullable responseObject, ResponseObject *_Nullable*_Nullable selectorObject))successHandler
andFailureHandler:(void (^_Nullable)(NSError * _Nonnull error))failureHandler;

@end

NS_ASSUME_NONNULL_END

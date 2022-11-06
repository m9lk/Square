//
//  Client.m
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-02.
//

#import "Client.h"
#import <AFNetworking/AFNetworking.h>

@interface Client()

@property AFHTTPSessionManager *manager;

@end

@implementation Client

#pragma mark - Constants

static NSString * const kCode = @"code";
static NSString * const kMessage = @"message";
static NSString * const kError = @"error";

#pragma mark - Instance

- (id)init {
    self = [super init];
    
    if (self) {
        // Init AFNetworking
        self.manager = [AFHTTPSessionManager manager];
        // Set Cache Policy
        [self.manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    }
    
    return self;
}

+ (instancetype)defaultClient {
    static Client *sharedInstance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Request

- (void)attempt:(RequestType)requestType
     toEndPoint:(NSString *)endPoint
     withParams:(NSDictionary *)parameters
       selector:(Selector *)selector
 successHanlder:(void (^_Nullable)(id _Nullable responseObject, ResponseObject **_Nullable selectorObject))successHandler
andFailureHandler:(void (^_Nullable)(NSError * _Nonnull error))failureHandler {
    
    // Prepare Request object
    Request *request = [[Request alloc] init];
    request.type = requestType;
    request.endPoint = endPoint;
    request.selector = selector;
    request.successHandler = successHandler;
    request.failureHandler = failureHandler;
    
    [self attempt:request];
}

- (void)attempt:(Request *)request {
    
    // success handler
    void (^dataTaskSuccessHandler)(id _Nullable responseObject, ResponseObject **_Nullable selectorObject) = ^(id _Nullable responseObject, ResponseObject **_Nullable selectorObject) {
        if (request.successHandler && ![responseObject objectForKey:kError]) {
            request.successHandler(responseObject, selectorObject);
        }
    };
    
    // failure handler
    void (^dataTaskFailureHandler)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) =
    ^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        if (request.failureHandler) {
            request.failureHandler(error);
        }
    };
    
    switch (request.type) {
        case GET:
            [self attemptGet:request.endPoint withParams:nil selector:request.selector successHanlder:dataTaskSuccessHandler andFailureHandler:dataTaskFailureHandler];
            break;
    }
}

- (void)attemptGet:(NSString *)url
        withParams:(NSDictionary *)parameters
          selector:(Selector *)selector
    successHanlder:(void (^_Nullable)(id _Nullable responseObject, ResponseObject **_Nullable selectorObject))successHandler
 andFailureHandler:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failureHandler {
    
    [self.manager GET:url parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self determineOutcomeWithObject:responseObject handler:successHandler selector:selector];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self handleFailureWithTask:task error:error handler:failureHandler selector:selector];
    }];
}

#pragma mark - Response Handling

- (void)determineOutcomeWithObject:(id _Nullable )responseObject
                           handler:(void (^_Nullable)(id _Nullable responseObject, ResponseObject **_Nullable selectorObject))successHandler
                          selector:(Selector *_Nullable)selector {
    
    if ([responseObject objectForKey:kError]) {
        [self handleErrorWithObject:[responseObject objectForKey:kError] selector:selector];
    } else {
        [self handleSuccessWithObject:responseObject handler:successHandler selector:selector];
    }
}

- (void)handleErrorWithObject:(id _Nullable )responseObject
                     selector:(Selector *_Nullable)selector {
    // notify selector with Error response
    if (selector) {
        ResponseError *responseError = [self parseErrorDictionary:responseObject];
        Response *response = @{CLIENT_RESPONSE_CODE:[NSNumber numberWithInteger:ResponseCodeError],
                               CLIENT_RESPONSE_ERROR:responseError};
        [selector performWithResponse:response];
    }
}

- (void)handleSuccessWithObject:(id _Nullable )responseObject
                        handler:(void (^_Nullable)(id _Nullable responseObject, ResponseObject **_Nullable selectorObject))successHandler
                       selector:(Selector *_Nullable)selector  {
    // notify successHandler
    ResponseObject *selectorObject;
    if (successHandler) {
        successHandler(responseObject, &selectorObject);
    }
    // notify selector
    if (selector) {
        if (selectorObject) {
            [selector performWithResponse:[Response responseWithObject:selectorObject]];
        } else {
            [selector performWithResponseCode:ResponseCodeSuccessful];
        }
    }
}

- (ResponseError *)parseErrorDictionary:(NSDictionary *)errorDictionary {
    
    long errorCode = [[errorDictionary objectForKey:kCode] integerValue];
    NSString *message = [errorDictionary objectForKey:kMessage];
    
    return [[ResponseError alloc] initWithDictionary:@{CLIENT_RESPONSE_ERROR_CODE:[NSNumber numberWithLong:errorCode],
                                                       CLIENT_RESPONSE_ERROR_DESCRIPTION:message}];
}

- (void)handleFailureWithTask:(NSURLSessionDataTask * _Nullable)task
                        error:(NSError * _Nonnull)error
                      handler:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failureHandler
                     selector:(Selector *_Nullable)selector {
    
    ResponseCode responseCode = ResponseCodeFailed;
    // offline
    if ([self isOffline:task]) {
        responseCode = ResponseCodeNoConnection;
    }
    // failure
    if (failureHandler) {
        failureHandler(task, error);
    }
    if (selector) {
        [selector performWithResponse:[Response responseWithCode:responseCode dataTask:task error:error]];
    }
}

- (BOOL)isOffline:(NSURLSessionDataTask *)task {
    
    NSInteger errorCode =  task.error.code;
    return errorCode == kCFURLErrorNotConnectedToInternet;
}

@end

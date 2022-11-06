//
//  MockClient.m
//  EmployeeDirectoryAppTests
//
//  Created by Melek Ramki on 2022-11-05.
//

#import "MockClient.h"

@implementation MockClient

- (id)init {
    self = [super init];
    
    return self;
}

+ (instancetype)defaultClient {
    static MockClient *sharedInstance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)attemptMock:(RequestType)requestType toEndPoint:(NSString *)endPoint withParams:(NSDictionary *)parameters selector:(Selector *)selector successHanlder:(void (^)(id _Nullable, ResponseObject * _Nullable __autoreleasing * _Nullable))successHandler andFailureHandler:(void (^)(NSError * _Nonnull))failureHandler {
    
    Request *request = [[Request alloc] init];
    request.type = requestType;
    request.endPoint = endPoint;
    request.selector = selector;
    request.successHandler = successHandler;
    request.failureHandler = failureHandler;

    [self attemptMock:request];
}

- (void)attemptMock:(Request *)request {
    //Mock Employees Json Response
    NSString *responseJsonFilePath = [[NSBundle mainBundle] pathForResource:@"EmployeesJson" ofType:@"json"];
    NSData *responseJsonData = [[NSData alloc] initWithContentsOfFile:responseJsonFilePath];
    NSError *jsonError = nil;
    NSDictionary *responseJsonDict = [NSJSONSerialization JSONObjectWithData:responseJsonData options:0 error:&jsonError];
    
    // success handler
    void (^dataTaskSuccessHandler)(id _Nullable responseObject, ResponseObject **_Nullable selectorObject) = ^(id _Nullable responseObject, ResponseObject **_Nullable selectorObject) {
        if (request.successHandler && ![responseObject objectForKey:@"error"]) {
            request.successHandler(responseObject, selectorObject);
        }
    };
    
    ResponseObject *selectorObject;
    if (dataTaskSuccessHandler) {
        dataTaskSuccessHandler(responseJsonDict, &selectorObject);
    }
    
    if (request.selector) {
        if (selectorObject) {
            [request.selector performWithResponse:[Response responseWithObject:selectorObject]];
        } else {
            [request.selector performWithResponseCode:ResponseCodeSuccessful];
        }
    }
}

@end

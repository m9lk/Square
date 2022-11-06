//
//  ResponseError.m
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-02.
//

#import "ResponseError.h"

@interface ResponseError()

@property NSDictionary *underlyingDict;

@end

@implementation ResponseError

#pragma mark - Super

- (instancetype)initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt {
    
    self = [super init];
    if (self) {
        self.underlyingDict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys count:cnt];
    }
    return self;
}

- (id)objectForKey:(id)aKey {
    
    return [self.underlyingDict objectForKey:aKey];
}

- (NSUInteger)count {
    
    return [self.underlyingDict count];
}

- (NSEnumerator *)keyEnumerator {
    
    return [self.underlyingDict keyEnumerator];
}

#pragma mark - Public Methods Implementation

- (NSInteger)errorCode {
    
    if ([self.underlyingDict objectForKey:CLIENT_RESPONSE_ERROR_CODE]) {
        return [[self.underlyingDict objectForKey:CLIENT_RESPONSE_ERROR_CODE] integerValue];
    }
    return -1;
}

- (NSString *)errorDescription {
    
    return [self.underlyingDict objectForKey:CLIENT_RESPONSE_ERROR_DESCRIPTION];
}

@end

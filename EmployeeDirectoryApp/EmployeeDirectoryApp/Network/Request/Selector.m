//
//  Selector.m
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-02.
//

#import "Selector.h"
#import "Client.h"

@interface Selector()

@property id observer;

@property (nonatomic, assign) SEL _Nullable selector;

@end

@implementation Selector

#pragma mark - Init

- (id)initWithSelector:(SEL)selector andObserver:(id)observer {
    self = [super init];
    if (self) {
        self.observer = observer;
        self.selector = selector;
    }
    return self;
}

#pragma mark - Class Methods Implementation

+ (Selector *)perform:(SEL)selector by:(id)observer {
    
    return [[Selector alloc] initWithSelector:selector andObserver:observer];
}

#pragma mark - Public Methods Implementation

- (void)performWithResponseCode:(ResponseCode)responseCode {
    
    [self performWithResponse:[Response responseWithCode:responseCode]];
}

- (void)performWithResponse:(Response *)response {
    
    [self.observer performSelector:self.selector withObject:response afterDelay:0];
}

@end

//
//  Selector.h
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-02.
//

#import <Foundation/Foundation.h>
#import "Response.h"

NS_ASSUME_NONNULL_BEGIN

@interface Selector : NSObject

#pragma mark - Class Methods

+ (Selector *_Nonnull)perform:(SEL _Nonnull)selector by:(id _Nonnull)observer;

#pragma mark - Public Methods

- (void)performWithResponseCode:(ResponseCode)responseCode;

- (void)performWithResponse:(Response *_Nullable)response;

@end

NS_ASSUME_NONNULL_END

//
//  Client (Employees).h
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-02.
//

#import <Foundation/Foundation.h>
#import "Client.h"

NS_ASSUME_NONNULL_BEGIN

@interface Client (Employees)

#pragma mark - Public Methods

- (void)getEmployeesWithSelector:(Selector *)selector;

@end

NS_ASSUME_NONNULL_END

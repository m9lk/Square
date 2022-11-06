//
//  Employees.h
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-04.
//

#import <Foundation/Foundation.h>
#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface Employees : NSMutableArray<Employee *>

#pragma mark - Instance

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

//
//  EmployeeCell.h
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-03.
//

#import <UIKit/UIKit.h>
#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeCell : UITableViewCell

#pragma mark - Public Methods

- (void)setEmployee:(Employee *)employee;

@end

NS_ASSUME_NONNULL_END

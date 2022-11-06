//
//  RefreshableTableView.h
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-01.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RefreshableTableView : UITableView

@property (nonatomic, assign) SEL refreshTarget;

@end

NS_ASSUME_NONNULL_END

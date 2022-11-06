//
//  Employees.m
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-04.
//

#import "Employees.h"

@implementation Employees

#pragma mark - Constants

static NSString *const kEmployees= @"employees";
static NSString *const kFullname= @"fullname";

#pragma mark - Init

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = (Employees*)[[NSMutableArray alloc] init];
    
    if (self) {
        @try {
            for (NSDictionary *dict in [dictionary objectForKey:kEmployees]) {
                Employee *employee = [[Employee alloc] initWithDictionary:dict];
                [self addObject:employee];
            }
            // Sort in Alphabetical Order
            NSSortDescriptor *alphaOrder = [NSSortDescriptor sortDescriptorWithKey:kFullname ascending:YES];
            NSArray *sortDescriptors = @[ alphaOrder ];
            [self sortUsingDescriptors:sortDescriptors];
            
        } @catch (NSException *exception) {
            NSLog(@"%@: Failed to set properties from dictionary: \n%@", self.class, exception.description);
        }
    }
    
    return self;
}

@end

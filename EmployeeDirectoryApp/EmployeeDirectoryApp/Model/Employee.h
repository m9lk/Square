//
//  Employee.h
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-02.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger) {
    FULL_TIME = 0,
    PART_TIME = 1,
    CONTRACTOR = 2

} Type;

@interface Employee : NSObject

#pragma mark - Instance

- (id)initWithDictionary:(NSDictionary *)dictionary;

#pragma mark - Public Properties

@property (readonly) NSString *uuid;
@property (readonly) NSString *fullname;
@property (readonly) NSString *phone;
@property (readonly) NSString *email;
@property (readonly) NSString *biography;
@property (readonly) NSString *smallPhotoUrl;
@property (readonly) NSString *largePhotoUrl;
@property (readonly) NSString *team;
@property (readonly) Type type;

@end

NS_ASSUME_NONNULL_END

//
//  Employee.m
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-02.
//

#import "Employee.h"

@interface Employee ()

@property NSString *uuid;
@property NSString *fullname;
@property NSString *phone;
@property NSString *email;
@property NSString *biography;
@property NSString *smallPhotoUrl;
@property NSString *largePhotoUrl;
@property NSString *team;
@property Type type;

@end

@implementation Employee

#pragma mark - Constants

static NSString *const kUuid= @"uuid";
static NSString *const kFullname = @"full_name";
static NSString *const kPhoneNumber = @"phone_number";
static NSString *const kEmail = @"email_address";
static NSString *const kBiography= @"biography";
static NSString *const kSmallPhoto= @"photo_url_small";
static NSString *const kLargePhoto= @"photo_url_large";
static NSString *const kTeam = @"team";
static NSString *const kType = @"employee_type";

static NSString *const kFulltime= @"FULL_TIME";
static NSString *const kParttime = @"PART_TIME";
static NSString *const kContractor = @"CONTRACTOR";

#pragma mark - Init

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        @try {
            self.uuid = [dictionary objectForKey:kUuid];
            self.fullname = [dictionary objectForKey:kFullname];
            self.phone = [dictionary objectForKey:kPhoneNumber];
            self.email = [dictionary objectForKey:kEmail];
            self.biography = [dictionary objectForKey:kBiography];
            self.smallPhotoUrl = [dictionary objectForKey:kSmallPhoto];
            self.largePhotoUrl = [dictionary objectForKey:kLargePhoto];
            self.team = [dictionary objectForKey:kTeam];
            self.uuid = [dictionary objectForKey:kUuid];
            self.type = [Employee typeFromString:[dictionary objectForKey:kType]];
        } @catch (NSException *exception) {
            NSLog(@"%@: Failed to set properties from dictionary: \n%@", self.class, exception.description);
        }
    }
    return self;
}

#pragma mark - Class Methods Implementation

+ (Type)typeFromString:(NSString *_Nonnull)type {
    Type employeeType;
    if ([type isEqualToString:kFulltime]) {
        employeeType = FULL_TIME;
    } else if ([type isEqualToString:kParttime]) {
        employeeType = PART_TIME;
    } else {
        employeeType = CONTRACTOR;
    }
    return employeeType;
}

- (BOOL)isEqual:(id)object {
    BOOL result = NO;
    if ([object isKindOfClass:[self class]]) {
        Employee *other = object;
        result = [self.uuid isEqual:other.uuid];
    }
    return result;
}

@end

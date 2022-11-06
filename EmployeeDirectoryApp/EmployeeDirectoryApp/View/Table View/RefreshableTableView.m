//
//  RefreshableTableView.m
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-01.
//

#import "RefreshableTableView.h"

@implementation RefreshableTableView

#pragma mark - Init

- (id)init {
    self = [super init];
    if (self) {
        [self setupRoutine];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupRoutine];
    }
    
    return self;
}

#pragma mark - Setup

- (void)setupRoutine {
    self.backgroundColor = [UIColor grayColor];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[[[self.refreshControl subviews] firstObject] subviews] lastObject];
    if (titleLabel) {
        titleLabel.numberOfLines = 1;
    }
    
    [self.refreshControl addTarget:self action:@selector(updateRefreshControl) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Refresh

- (void)updateRefreshControl {
    // End the refreshing
    if (self.refreshControl) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *lastUpdate = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[NSDate date]]];
        NSString *title = [NSString stringWithFormat:@"%@", lastUpdate];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attributes];
        
        self.refreshControl.attributedTitle = attributedTitle;
    }
    // Refresh target
    if (self.refreshTarget && self.delegate) {
        IMP implementation = [(UIViewController *)self.delegate methodForSelector:self.refreshTarget];
        void (*func)(id, SEL) = (void *)implementation;
        func(self.delegate, self.refreshTarget);
    }
}

@end

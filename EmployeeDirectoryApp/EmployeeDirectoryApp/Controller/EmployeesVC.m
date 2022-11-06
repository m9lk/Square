//
//  ViewController.m
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-01.
//

#import "EmployeesVC.h"
#import "Client.h"
#import "Client+Employees.h"
#import "Employee.h"
#import "RefreshableTableView.h"
#import "EmployeeCell.h"
#import "Employees.h"

@interface EmployeesVC () <UITableViewDataSource, UITableViewDelegate>

#pragma mark - IBOutlets

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet RefreshableTableView *tableView;

#pragma mark - Private Properties

@property NSMutableArray<Employee *> *employees;

@end

@implementation EmployeesVC

#pragma mark - Constants

static NSString *const kEmployeeCell = @"EmployeeCell";
static NSString *const kUITableViewCell = @"UITableViewCell";

#pragma mark - Super

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRoutine];
}

- (void)viewDidAppear:(BOOL)animated {
    [self refreshControlWithCompletion:^{
        [self refreshDataSource];
    }];
}

#pragma mark - Setup

- (void)setupRoutine {
    [self setupNavigationBar];
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.refreshTarget = @selector(refreshDataSource);
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kUITableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:kEmployeeCell bundle:nil] forCellReuseIdentifier:kEmployeeCell];
}

- (void)setupNavigationBar {
    self.navigationBar.topItem.title = NSLocalizedString(@"employees_screen_navigation_bar_title", nil);
}

#pragma mark - Table View Data Source

- (void)refreshDataSource {
    [[Client defaultClient] getEmployeesWithSelector:[Selector perform:@selector(onResponse:) by:self]];
}

- (void)onResponse:(Response *)response {
    [self.tableView.refreshControl endRefreshing];
    self.employees = [[NSMutableArray alloc] init];
    switch ([response responseCode]) {
        case ResponseCodeSuccessful: {
            self.employees = [[Employees alloc] initWithDictionary:[response responseObject]];
        } break;
        case ResponseCodeNoConnection: {
            [self presentAlert:NSLocalizedString(@"employees_screen_no_internet", nil) message:NSLocalizedString(@"employees_screen_no_internet_message", nil)];
        } break;
        case ResponseCodeError:
        case ResponseCodeFailed: {
            [self presentAlert:NSLocalizedString(@"employees_screen_error", nil) message:response.responseError.description];
        } break;
    }
    [self.tableView reloadData];
}

#pragma mark - Table View Delegate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (self.employees.count > 0) {
        EmployeeCell *cell = [tableView dequeueReusableCellWithIdentifier:kEmployeeCell];
        [cell setEmployee:self.employees[indexPath.row]];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUITableViewCell];
        [cell.textLabel setText: NSLocalizedString(@"employees_screen_empty_message", nil)];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.employees.count > 0 ? self.employees.count : 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - Presentation

- (void)presentAlert:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {}];
    [alert addAction:action];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (void)refreshControlWithCompletion:(void (^)(void))completionHandler {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^(void) {
            self.tableView.contentOffset = CGPointMake(0, -self.tableView.refreshControl.frame.size.height);
        }
                         completion:^(BOOL finished) {
            [self.tableView.refreshControl beginRefreshing];
            
            if (completionHandler) {
                completionHandler();
            }
        }];
    });
};

@end

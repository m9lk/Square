//
//  EmployeeCell.m
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-03.
//

#import "EmployeeCell.h"
#import <SDWebImage/SDWebImage.h>
#import "UIImage+Helper.h"

@interface EmployeeCell ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation EmployeeCell

#pragma mark - Constants

static CGFloat const kAspectRatio = 250.0f;

#pragma mark - Super

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorNamed:@"DynamicBlack"];
}

#pragma mark - Public Methods

- (void)setEmployee:(Employee *)employee {
    [self.nameLabel setText:employee.fullname];
    [self.teamLabel setText:employee.team];
    [self.emailLabel setText:employee.email];
    [self.phoneLabel setText:employee.phone];
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:employee.smallPhotoUrl] completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil) {
            [self.photoView setImage:(image.size.width != kAspectRatio || image.size.height != kAspectRatio) ? [image resizeImage:CGSizeMake(kAspectRatio, kAspectRatio)] : image];
        }
    }];
}

@end

//
//  UIImage+Helper.h
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-05.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

- (UIImage *)resizeImage:(CGSize)newSize;

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)imageSize;

@end

NS_ASSUME_NONNULL_END

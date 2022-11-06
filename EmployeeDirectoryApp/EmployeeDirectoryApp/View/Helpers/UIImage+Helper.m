//
//  UIImage+Helper.m
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-05.
//

#import "UIImage+Helper.h"

@implementation UIImage (Extension)

- (UIImage *)resizeImage:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)imageSize {
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    [color setFill];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

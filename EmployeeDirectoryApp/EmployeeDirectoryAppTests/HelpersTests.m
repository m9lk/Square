//
//  HelpersTests.m
//  EmployeeDirectoryApp
//
//  Created by Melek Ramki on 2022-11-05.
//

#import <XCTest/XCTest.h>
#import "UIImage+Helper.h"

@interface HelpersTests : XCTestCase

@property UIImage *image;

@end

@implementation HelpersTests

- (void)setUp {
    UIImage *colorImage = [UIImage imageWithColor:[UIColor redColor] andSize:CGSizeMake(350, 150)];
    self.image = [colorImage resizeImage:CGSizeMake(250, 250)];
}

- (void)tearDown {
    self.image = nil ;
}

- (void)testImageResize {
    XCTAssertEqual(self.image.size.width, 250);
    XCTAssertEqual(self.image.size.height, 250);
}

@end

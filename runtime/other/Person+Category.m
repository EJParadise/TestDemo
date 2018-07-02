//
//  Person+Category.m
//  runtime
//
//  Created by long108 on 2018/6/29.
//  Copyright © 2018年 long108. All rights reserved.
//

#import "Person+Category.h"
#import <objc/runtime.h>
#import "NSObject+Association.h"

static char category_Name;
@implementation Person (Category)

- (void)setCategoryName:(NSString *)categoryName{
    [self setAssociatedObject:categoryName forKey:@"category_Name"];
//    objc_setAssociatedObject(self, "category_Name", categoryName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)categoryName{
    return [self associatedObjectForKey:@"category_Name"];
//    return objc_getAssociatedObject(self, "category_Name");
}
@end

//
//  Student.m
//  runtime
//
//  Created by long108 on 2018/7/1.
//  Copyright © 2018年 long108. All rights reserved.
//

#import "Student.h"
#import <objc/runtime.h>

@implementation Student
+ (instancetype)personWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)longOperation:(id)obj {
    NSLog(@"%@ - %@ - %@", [NSThread currentThread], self.name, obj);
}


- (void)study{
    NSLog(@"动态添加了一个学习方法");
}


+ (BOOL)resolveInstanceMethod:(SEL)sel{
    SEL studySel = @selector(study);
    Method studyMethod = class_getInstanceMethod(self, studySel);
    IMP studyImp = method_getImplementation(studyMethod);
    const char *types = method_getTypeEncoding(studyMethod);
    
    if (sel == NSSelectorFromString(@"study")) {
        class_addMethod(self, sel, studyImp , types);
    }
    return YES;
}

@end

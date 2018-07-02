//
//  NSObject+Association.m
//  runtime
//
//  Created by long108 on 2018/6/29.
//  Copyright © 2018年 long108. All rights reserved.
//

#import "NSObject+Association.h"
#import <objc/runtime.h>

@implementation NSObject (Association)

- (void)setAssociatedObject:(id)obj forKey:(NSString *)key{
    objc_setAssociatedObject(self, key.UTF8String, obj, OBJC_ASSOCIATION_RETAIN);
}

- (id)associatedObjectForKey:(NSString *)key{
    return objc_getAssociatedObject(self, key.UTF8String);
}

@end

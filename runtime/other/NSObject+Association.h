//
//  NSObject+Association.h
//  runtime
//
//  Created by long108 on 2018/6/29.
//  Copyright © 2018年 long108. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Association)
- (void)setAssociatedObject:(id)obj forKey:(NSString *)key;
- (id)associatedObjectForKey:(NSString *)key;
@end

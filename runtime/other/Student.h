//
//  Student.h
//  runtime
//
//  Created by long108 on 2018/7/1.
//  Copyright © 2018年 long108. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
@property (nonatomic, copy) NSString *name;
+ (instancetype)personWithDict:(NSDictionary *)dict;

@end

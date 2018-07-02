//
//  Person.h
//  runtime
//
//  Created by long108 on 2018/6/29.
//  Copyright © 2018年 long108. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

/** 姓名 */
@property (strong, nonatomic) NSString *name;

/** age */
@property (assign, nonatomic) int age;

/** weight */
@property (assign, nonatomic) double weight;

@end

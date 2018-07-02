//
//  UIImage+Image.m
//  runtime
//
//  Created by long108 on 2018/7/2.
//  Copyright © 2018年 long108. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/runtime.h>

@implementation UIImage (Image)

+ (void)load{
    Method method1 = class_getClassMethod(self, @selector(imageNamed:));
    Method method2 = class_getClassMethod(self, @selector(myImageNamed:));
    method_exchangeImplementations(method1, method2);
}

+ (UIImage *)myImageNamed:(NSString *)img{
    UIImage *image = [UIImage myImageNamed:img];
    if (image) {
        NSLog(@"图片加载成功");
    }else{
        NSLog(@"图片加载失败");
    }
    return image;
}

@end

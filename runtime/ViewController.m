//
//  ViewController.m
//  runtime
//
//  Created by long108 on 2018/6/29.
//  Copyright © 2018年 long108. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Person+Category.h"
#import "NSObject+Association.h"
#import <objc/runtime.h>
#import "Student.h"

@interface ViewController ()
@property (strong, nonatomic) Student *student;

@property (assign, nonatomic) int tickets;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIImage *image = [UIImage imageNamed:@"img"];
}

- (void)addMethod{
    Student *student = [[Student alloc] init];
    [student performSelector:@selector(study)];
}


- (void)arrangeTwoSales{
    self.tickets = 20;
    
    NSThread *t1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets2) object:nil];
    t1.name = @"售票员 A";
    [t1 start];
    
    NSThread *t2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets2) object:nil];
    t2.name = @"售票员 B";
    [t2 start];
}

- (void)saleTickets1 {
    while (YES) {
        // 模拟休眠
        [NSThread sleepForTimeInterval:1.0];
        
        if (self.tickets > 0) {
            self.tickets--;
            NSLog(@"剩余票数 %d %@", self.tickets, [NSThread currentThread]);
        } else {
            NSLog(@"没票了 %@", [NSThread currentThread]);
            break;
        }
    }
}


- (void)saleTickets2 {
    
    while (YES) {
        [NSThread sleepForTimeInterval:1.0];
        
        @synchronized(self) {
            if (self.tickets > 0) {
                self.tickets--;
                NSLog(@"剩余票数 %d %@", self.tickets, [NSThread currentThread]);
                continue;
            }
        }
        
        NSLog(@"没票了 %@", [NSThread currentThread]);
        break;
    }
}

- (void)threadDemo2{
    [self.student performSelectorInBackground:@selector(longOperation:) withObject:@"person"];
}

- (void)threadDemo1 {
    NSLog(@"before %@", [NSThread currentThread]);
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(longOperation:) object:@"THREAD"];
    
    [thread start];
    
    NSLog(@"after %@", [NSThread currentThread]);
}

- (void)longOperation:(NSThread *)thread{
    NSLog(@"%@", [NSThread currentThread]);
}

- (void)address{
    NSString *str1 = @"123";
    NSString *str2 = @"123";
    NSString *str3 = [[NSString alloc] initWithString:str1];
    NSString *str4 = [str1 stringByAppendingString:@""];
    NSLog(@"%p, %p", str1, str1.UTF8String);  // 0x100001050, 0x100000f4e
    NSLog(@"%p, %p", str2, str2.UTF8String);  // 0x100001050, 0x100000f4e
    NSLog(@"%p, %p", str3, str3.UTF8String);  // 0x100001050, 0x100000f4e
    NSLog(@"%p, %p", str4, str4.UTF8String);  // 0x100001050, 0x100000f4e
    
    char *cstr1 = "321";
    char *cstr2 = "321";
    printf("%p\n", cstr1);    // 0x100000f60
    printf("%p\n", cstr2);    // 0x100000f60
}

- (void)addProperty2{
    NSObject *obj = [NSObject new];
    NSString *nameForValue = @"Xcode";
    NSString *nameForCode = @"name";
    NSMutableString *nameForGet = @"name".mutableCopy;
    [obj setAssociatedObject:nameForValue forKey:nameForCode];
    NSLog(@"%@", [obj associatedObjectForKey:nameForGet]);
}

- (void)addProperty1{
    Person *person = [[Person alloc] init];
    person.categoryName = @"hhhhh";
    person.name = @"C";
    NSLog(@"%@=======%@", person.name, person.categoryName);
}

- (void)getList{
    unsigned int outCount = 0;
    
    // 获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([Person class], &outCount);
    
    NSLog(@"%d", outCount);
    
    for (NSInteger i = 0; i<outCount; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        NSLog(@"property-->%@", name);
    }
    
    // 获取方法列表
    Method *methodList = class_copyMethodList([Person class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methodList[i];
        NSLog(@"method-->%@", NSStringFromSelector(method_getName(method)));
    }
    
    // 获取成员变量列表
    Ivar *ivarList = class_copyIvarList([Person class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar-->%@", [NSString stringWithUTF8String:ivarName]);
    }
    
    // 获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([Person class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol-->%@", [NSString stringWithUTF8String:protocolName]);
    }
}

- (Student *)student{
    if (_student== nil) {
        _student = [Student personWithDict:@{@"name" : @"sunny"}];
    }
    return _student;
}
@end

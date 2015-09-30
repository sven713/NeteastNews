//
//  NSObject+Extension.m
//  9.29新闻
//
//  Created by sven on 15/9/30.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)



+(instancetype)objWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    //    [obj setValuesForKeysWithDictionary:dict]; // 为啥这样写会崩?属性少了,网络数据字典中的属性很多
    
    NSArray *arr = [self loadPorperty];
    for (NSString *str in arr) {
        if (dict[str] != nil) {
            [obj setValue:dict[str] forKey:str];
        }
    }
    return obj;
}

const char * kPropertyKey = "kPropetyKey";
// 用运行时动态获取类的属性->自己声明的属性
+ (NSArray *)loadPorperty { // 类方法
    // 参数1对象 参数2属性的key
    NSArray *arr = objc_getAssociatedObject(self, kPropertyKey);
    if (arr != nil) {
        return arr;
    }
    /*
     参数1.类
     参数2.属性计数
     */
    unsigned int count = 0;
    // list是数组
    objc_property_t *list =  class_copyPropertyList([self class], &count);
    
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i ++) {
        objc_property_t pty = list[i]; // 取出数组
        const char *pro = property_getName(pty); // pro:char   pty:结构体
        // 将字符串转换成OC属性
        [arrM addObject:[NSString stringWithUTF8String:pro]];
    }
    NSLog(@"%@",arrM);
    // c语言的对象要释放
    free(list);
    // 1关联对象 2key 3值 4策略
    objc_setAssociatedObject(self, kPropertyKey, arrM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return objc_getAssociatedObject(self, kPropertyKey);

}

@end

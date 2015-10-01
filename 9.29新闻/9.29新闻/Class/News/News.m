//
//  News.m
//  9.29新闻
//
//  Created by sven on 15/9/29.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import "News.h"
#import "NetWorkTools.h"
#import "AFNetworking.h"
#import "NSObject+Extension.h"

@implementation News



- (NSString *)description {
#warning 这啥意思?
    NSArray *arr = [self.class loadPorperty];
    // 把自定义对象转换成字典  kvc  self跟arr对应
    NSDictionary *dict = [self dictionaryWithValuesForKeys:arr];
    
    
    return [NSString stringWithFormat:@"<%@:%p>%@",self.class,self,dict];
}

+ (void)loadNewsWithURL:(NSString *)urlString finish:(void (^)(NSArray *))finish{ // 解析url对应的新闻
    // 单例
    [[NetWorkTools shareNetWorkTools] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        // 完成回调->block
        NSArray *arr = responseObject[responseObject.keyEnumerator.nextObject];
        // 从字典中取出数组好做字典转模型
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        for (NSDictionary *dict in arr) {
            [arrM addObject:[self objWithDict:dict]]; // 类似之前懒加载字典转模型,放到模型里面写的
        }
//        NSLog(@"%@",arrM);
        finish(arrM.copy);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
// 为啥用类方法:方便调用
// 如何验证VC viewDidLoad调用
// [obj setValuesForKeysWithDictionary:dict]; // 为啥这样写会崩?属性少了,网络数据字典中的属性很多
#warning 利用关联对象,不用每次都加载属性,提升性能就这作用? kPropetyKey能拿到key?
//
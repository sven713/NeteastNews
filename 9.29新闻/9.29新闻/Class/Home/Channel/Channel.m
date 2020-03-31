//
//  Channel.m
//  9.29新闻
//
//  Created by sven on 15/9/30.
//  Copyright (c) 2015年 sven. All rights reserved.
//

#import "Channel.h"
#import "NSObject+Extension.h"

@implementation Channel

-(void)setTid:(NSString *)tid { // "T1348647853363/0-20.html"
    _tid = tid;
    _urlString = [NSString stringWithFormat:@"%@/0-20.html",_tid];
}

+(NSArray *)channelList {
    // 1.本地json->二进制
    NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    // 2.json->dictonary(反序列化)
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    // 3.获取字典的数据 方块号里面是字典的key,keyEnumer遍历字典,nextObject取出第一个key
    NSArray *arr = dict[dict.keyEnumerator.nextObject];
    // 4.遍历数组,字典转模型
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        [arrM addObject:[self objWithDict:dict]]; // 字典转模型,模型是数组
    }
    
    // 利用tid给数组排序
    return [arrM sortedArrayUsingComparator:^NSComparisonResult(Channel *obj1, Channel *obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
//    return arrM.copy;
}

- (NSString *)description {
    NSArray *arr = [self.class loadPorperty];
    // 把自定义对象转换成字典
    NSDictionary *dict = [self dictionaryWithValuesForKeys:arr];
    return [NSString stringWithFormat:@"<%@:%p>%@",self.class,self,dict];
}

@end
#warning channelList不懂
//数据解析,拥抱五年前的自己 2020.3.31

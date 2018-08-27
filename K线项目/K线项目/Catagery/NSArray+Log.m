//
//  NSArray+Log.m
//  02.XML解析
//
//  Created by apple on 14-4-26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

// 专门针对中文编码不正确
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    
    return strM;
}

@end

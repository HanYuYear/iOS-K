//
//  HLTabulation.m
//  K线项目
//
//  Created by homilyiosfiveMac-mini on 2018/8/23.
//  Copyright © 2018年 com.homily. All rights reserved.
//

#import "HLTabulation.h"

@implementation HLTabulation
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ : %p> { name : %@, code : %@,price : %@,rate : %@,rise : %@,preClose : %@,vol : %@,amount : %@,open : %@,high : %@,low : %@ }",[self class],self,self.name,self.code,self.price,self.rate,self.rise,self.preClose,self.vol,self.amount,self.open,self.high,self.low ];
}
@end

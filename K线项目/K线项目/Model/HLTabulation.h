//
//  HLTabulation.h
//  K线项目
//
//  Created by homilyiosfiveMac-mini on 2018/8/23.
//  Copyright © 2018年 com.homily. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLTabulation : NSObject

/**
 股票名称
 */
@property (nonatomic,strong)NSString *name;

/**
 股票代码
 */
@property (nonatomic,strong)NSString *code;

/**
 最新价格
 */
@property (nonatomic,strong)NSString *price;

/**
 <#Description#>
 */
@property (nonatomic,strong)NSString *rate;

/**
 <#Description#>
 */
@property (nonatomic,strong)NSString *rise;

/**
 <#Description#>
 */
@property (nonatomic,strong)NSString *preClose;

/**
 成交量
 */
@property (nonatomic,strong)NSString *vol;

/**
 <#Description#>
 */
@property (nonatomic,strong)NSString *amount;

/**
 开盘价
 */
@property (nonatomic,strong)NSString *open;

/**
 最高价
 */
@property (nonatomic,strong)NSString *high;

/**
 最低价
 */
@property (nonatomic,strong)NSString *low;















@end

//
//  HLDetails.h
//  K线项目
//
//  Created by homilyiosfiveMac-mini on 2018/8/27.
//  Copyright © 2018年 com.homily. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLDetails : NSObject
/**
 总手
 */
@property (nonatomic,strong)NSString *volume;

/**
 开盘价
 */
@property (nonatomic,strong)NSString *open;

/**
 最高价格
 */
@property (nonatomic,strong)NSString *high;

/**
 最低
 */
@property (nonatomic,strong)NSString *low;

/**
 买价
 */
@property (nonatomic,strong)NSString *buyprice;

/**
 卖价
 */
@property (nonatomic,strong)NSString *sellprice;

/**
 成交量
 */
@property (nonatomic,strong)NSString *buycount;

/**
 
 */
@property (nonatomic,strong)NSString *sellcount;

/**
 最左边的大label
 */
@property (nonatomic,strong)NSString *latest;

/**
 时间
 */
@property (nonatomic,strong)NSString *time;

/**
 最左侧左边
 */
@property (nonatomic,strong)NSString *rate;
/**
 最左侧右边
 */
@property (nonatomic,strong)NSString *rise;


@end

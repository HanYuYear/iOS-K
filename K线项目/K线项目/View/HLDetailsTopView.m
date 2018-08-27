//
//  HLDetailsTopView.m
//  K线项目
//
//  Created by homilyiosfiveMac-mini on 2018/8/27.
//  Copyright © 2018年 com.homily. All rights reserved.
//

#import "HLDetailsTopView.h"
#import "HLDetails.h"
//屏幕大小
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


@interface HLDetailsTopView() <NSXMLParserDelegate>

@property (nonatomic,strong)UILabel *volume;

@property (nonatomic,strong)UILabel *open;

@property (nonatomic,strong)UILabel *high;

@property (nonatomic,strong)UILabel *low;

@property (nonatomic,strong)UILabel *buyprice;

@property (nonatomic,strong)UILabel *sellprice;

@property (nonatomic,strong)UILabel *buycount;

@property (nonatomic,strong)UILabel *sellcount;

@property (nonatomic,strong)UILabel *latest;

@property (nonatomic,strong)UILabel *time;


@property (nonatomic,strong)UILabel *rate;

@property (nonatomic,strong)UILabel *rise;

@property (nonatomic,strong)UILabel *TimeNow;
//下方5个按钮
@property (nonatomic,strong)UIButton *fenshiBtn;
@property (nonatomic,strong)UIButton *rixianBtn;
@property (nonatomic,strong)UIButton *zhouxianBtn;
@property (nonatomic,strong)UIButton *yuexianBtn;
@property (nonatomic,strong)UIButton *fenzhongBtn;

@end


@implementation HLDetailsTopView


- (UIView *)HLDetailsTopView{
  
    
    return self;
}
- (instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = [UIColor blackColor];
        CGFloat topW = SCREEN_WIDTH;
        CGFloat topH = (SCREEN_HEIGHT-64)/4;
        self.frame = CGRectMake(0, 64, topW, topH);
        [self addSubview:self.volume];
        [self addSubview:self.open];
        [self addSubview:self.high];
        [self addSubview:self.low];
        [self addSubview:self.buyprice];
        [self addSubview:self.sellprice];
        [self addSubview:self.buycount];
        [self addSubview:self.sellcount];
        [self addSubview:self.latest];
        [self addSubview:self.time];
        [self addSubview:self.rate];
        [self addSubview:self.rise];
        [self addSubview:self.TimeNow];
        [self addSubview:self.fenshiBtn];
        [self addSubview:self.rixianBtn];
        [self addSubview:self.zhouxianBtn];
        [self addSubview:self.yuexianBtn];
        [self addSubview:self.fenzhongBtn];
        
    }
    
    return self;
}



- (void)setT:(HLDetails *)t{
    _t = t;
    
    //设置最左侧第一个
    self.latest.text = t.latest;
    self.latest.textColor = [UIColor redColor];
    [self.latest.font fontWithSize:30];
    //设置最左侧下面第一个
    self.rate.text = t.rate;
    self.rate.textColor = [UIColor redColor];
    
    //设置最左侧下面第二个
    self.rise.text = t.rise;
    self.rise.textColor = [UIColor redColor];
    //中间第一个
    self.open.text = [NSString stringWithFormat:@"开盘:%@",t.open];
    self.open.textColor = [UIColor redColor];
    //中间第2个
    self.low.text = t.low;
    self.low.textColor = [UIColor redColor];
    //中间第3个
    self.buyprice.text = t.buyprice;
    self.buyprice.textColor = [UIColor redColor];
    //右边第一个
    self.high.text = t.high;
    self.high.textColor = [UIColor redColor];
    //右边第2个
    self.volume.text = t.volume;
    self.volume.textColor = [UIColor redColor];
    //右边第3个
    self.sellprice.text = t.sellprice;
    self.sellprice.textColor = [UIColor redColor];
    //TimeNow
    self.TimeNow.text = @"Time:";
    self.TimeNow.textColor = [UIColor whiteColor];
    //time
    self.time.text = t.time;
    self.time.textColor = [UIColor yellowColor];
    //109.6W
    self.buycount.text = t.buycount;
    self.buycount.textColor = [UIColor yellowColor];
    //4.0W
    self.sellcount.text = t.sellcount;
    self.sellcount.textColor = [UIColor yellowColor];
    //下方按钮
    [self.fenshiBtn setTitle:@"分时" forState:UIControlStateNormal];
    [self.fenshiBtn setBackgroundColor:[UIColor grayColor]];
    [self.fenshiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //下方2按钮
    [self.rixianBtn setTitle:@"日线" forState:UIControlStateNormal];
    [self.rixianBtn setBackgroundColor:[UIColor grayColor]];
    [self.rixianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    //下方3按
    [self.zhouxianBtn setTitle:@"周线" forState:UIControlStateNormal];
    [self.zhouxianBtn setBackgroundColor:[UIColor grayColor]];
    [self.zhouxianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    //下方4按钮
    [self.yuexianBtn setTitle:@"月线" forState:UIControlStateNormal];
    [self.yuexianBtn setBackgroundColor:[UIColor grayColor]];
    [self.zhouxianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //下方5按钮
    [self.fenzhongBtn setTitle:@"分钟" forState:UIControlStateNormal];
    [self.fenzhongBtn setBackgroundColor:[UIColor grayColor]];
    [self.fenzhongBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //设置最左侧第一个
    self.latest.frame = CGRectMake(0, 0, 140, 40);
    //设置最左侧下面第一个
    self.rate.frame = CGRectMake(0, 40, 70, 20);
    //设置最左侧下面第二个
    self.rise.frame = CGRectMake(70, 40, 70, 20);
    //中间第一个
    self.open.frame = CGRectMake(140, 0, 125, 20);
    //中间第2个
    self.low.frame = CGRectMake(140, 20, 125, 20);
    //中间第3个
    self.buyprice.frame = CGRectMake(140, 40, 125, 20);
    //右边第一个
    self.high.frame = CGRectMake(250, 0, 125, 20);
    //右边第2个
    self.volume.frame = CGRectMake(250, 20, 125, 20);
    //右边第3个
    self.sellprice.frame = CGRectMake(250, 40, 125, 20);
    //TimeNow
    self.TimeNow.frame = CGRectMake(0, 60, SCREEN_WIDTH/4, 30);
    //time
    self.time.frame = CGRectMake(SCREEN_WIDTH/4, 60, SCREEN_WIDTH/4, 30);
    //109.6W
    self.buycount.frame = CGRectMake(SCREEN_WIDTH/2, 60, SCREEN_WIDTH/4, 30);
    //4.0W
    self.sellcount.frame = CGRectMake((SCREEN_WIDTH/4)*3, 60, SCREEN_WIDTH/4, 30);
    //下方按钮
    self.fenshiBtn.frame = CGRectMake(0, 90, SCREEN_WIDTH/5, 40);
    //下方2按钮
    self.rixianBtn.frame = CGRectMake(SCREEN_WIDTH/5, 90, SCREEN_WIDTH/5, 40);
    //下方3按钮
    self.zhouxianBtn.frame = CGRectMake((SCREEN_WIDTH/5)*2, 90, SCREEN_WIDTH/5, 40);
    //下方4按钮
    self.yuexianBtn.frame = CGRectMake((SCREEN_WIDTH/5)*3, 90, SCREEN_WIDTH/5, 40);
    //下方5按钮
    self.fenzhongBtn.frame = CGRectMake((SCREEN_WIDTH/5)*4, 90, SCREEN_WIDTH/5, 40);
    
}



#pragma mark - 懒加载


-(UILabel *)volume{
    if (_volume==nil) {
        _volume = [[UILabel alloc]init];
    }
    return _volume;
}
-(UILabel *)open{
    if (_open==nil) {
        _open = [[UILabel alloc]init];
    }
    return _open;
}
-(UILabel *)high{
    if (_high==nil) {
        _high = [[UILabel alloc]init];
    }
    return _high;
}
-(UILabel *)low{
    if (_low==nil) {
        _low = [[UILabel alloc]init];
    }
    return _low;
}
-(UILabel *)buyprice{
    if (_buyprice==nil) {
        _buyprice = [[UILabel alloc]init];
    }
    return _buyprice;
}
-(UILabel *)sellprice{
    if (_sellprice==nil) {
        _sellprice = [[UILabel alloc]init];
    }
    return _sellprice;
}
-(UILabel *)buycount{
    if (_buycount==nil) {
        _buycount = [[UILabel alloc]init];
    }
    return _buycount;
}
-(UILabel *)sellcount{
    if (_sellcount==nil) {
        _sellcount = [[UILabel alloc]init];
    }
    return _sellcount;
}
-(UILabel *)latest{
    if (_latest==nil) {
        _latest = [[UILabel alloc]init];
    }
    return _latest;
}
-(UILabel *)time{
    if (_time==nil) {
        _time = [[UILabel alloc]init];
    }
    return _time;
}
- (UILabel *)TimeNow{
    if (_TimeNow==nil) {
        _TimeNow = [[UILabel alloc]init];
    }
    return _TimeNow;
}
-(UILabel *)rate{
    if (_rate==nil) {
        _rate = [[UILabel alloc]init];
    }
    return _rate;
}
-(UILabel *)rise{
    if (_rise==nil) {
        _rise = [[UILabel alloc]init];
    }
    return _rise;
}
-(UIButton *)fenshiBtn{
    if (_fenshiBtn==nil) {
        _fenshiBtn = [[UIButton alloc]init];
    }
    return _fenshiBtn;
}
-(UIButton *)rixianBtn{
    if (_rixianBtn==nil) {
        _rixianBtn = [[UIButton alloc]init];
    }
    return _rixianBtn;
}
-(UIButton *)zhouxianBtn{
    if (_zhouxianBtn==nil) {
        _zhouxianBtn = [[UIButton alloc]init];
    }
    return _zhouxianBtn;
}
-(UIButton *)yuexianBtn{
    if (_yuexianBtn==nil) {
        _yuexianBtn = [[UIButton alloc]init];
    }
    return _yuexianBtn;
}
-(UIButton *)fenzhongBtn{
    if (_fenzhongBtn==nil) {
        _fenzhongBtn = [[UIButton alloc]init];
    }
    return _fenzhongBtn;
}
@end

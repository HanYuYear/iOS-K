//
//  HLKLineDraw.m
//  K线项目
//
//  Created by homilyiosfiveMac-mini on 2018/8/28.
//  Copyright © 2018年 com.homily. All rights reserved.
//

#import "HLKLineDraw.h"
#import "HLKLines.h"

//屏幕大小
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface HLKLineDraw()
//定义屏幕要展示的数量
@property (nonatomic,assign)CGFloat allNum;
//定义一个可变数组用来存储当前界面的K线数组
@property (nonatomic,strong)NSArray *nowKLineArray;
//定义一个可变数组用来储存所有的K线
@property (nonatomic,strong)NSMutableArray *allKLineArray;

//定义一个系数，用来定义K线的Y值,例如此时最大为250000，那么系数就是（屏幕宽度/200000）每一个指数，代表屏幕中的多少
@property (nonatomic,assign)CGFloat XiS;
//当前屏幕的最高值，用于改变这个系数
@property (nonatomic,assign)CGFloat MaxKLineH;
//当前屏幕的最低值，用于一起改变这个系数,
@property (nonatomic,assign)CGFloat MinKLineH;
//当滑动的时候，计算一个偏移量
@property (nonatomic,assign)CGFloat contentX;
//顶一个数量，用来保存左侧隐藏的根数
@property (nonatomic,strong)NSNumber *leftNum;

@end



@implementation HLKLineDraw

-(instancetype)initWithFrame:(CGRect)frame
{
    if( self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor blackColor];//设置后无重叠
        //创建一个监听事件
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        //注册一个监听事件
        [center addObserver:self selector:@selector(move:) name:@"moveKLines" object:nil];
        //给这个View添加左边的几个label
        
    }
    
    return self;
    
}
- (void)move:(NSNotification *)note{
    NSDictionary *dict=note.userInfo;
    NSString *moveX = dict[@"moveX"];
    self.contentX = self.contentX - [moveX floatValue];
    if (self.contentX<0) {
        self.contentX = 0;
    }
    NSLog(@"此时的偏移量为%f",self.contentX);
    
    self.MinKLineH = self.MaxKLineH;
    self.MaxKLineH = 0;
    //当屏幕中的最高开盘价比屏幕中的最高价高的时候应该考虑进去
    for (HLKLines *KL in self.nowKLineArray) {
        int MAXhigh = KL.high;
        int MAXOpen = KL.open;
        int MINhigh = KL.low;
        int MINclose = KL.close;
        //判断最高的是哪个
        if (MAXhigh>self.MaxKLineH) {
            self.MaxKLineH = MAXhigh;
            if (MAXOpen>self.MaxKLineH) {
                self.MaxKLineH = MAXOpen;
            }
        }
        if (MINhigh<self.MinKLineH) {
            self.MinKLineH = MINhigh;
            if (MINclose<self.MinKLineH) {
                self.MinKLineH = MINclose;
            }
        }
    }
    [self setNeedsDisplay];
    
    
}

//赋值时会调用的set方法
- (void)setKLine:(HLKLines *)KLine{
    
    _KLine = KLine;
    self.KLine.open = KLine.open;
    self.KLine.close = KLine.close;
    self.KLine.high = KLine.high;
    self.KLine.low = KLine.low;
    //将模型赋值给数组
    [self.allKLineArray addObject:self.KLine];
    [self setNeedsDisplay];
    
//    //找到当前屏幕的最高价，根据这个最高价，设置那个系数

//
}

#pragma mark - 绘图方法
- (void)drawRect:(CGRect)rect {

    //设置偏移后左侧隐藏的根数
    int leftNum = self.contentX/(SCREEN_WIDTH/self.allNum);
    //设置约束方法，当根数<0的时候不可以，当根数>所有的时候也不行
    if (leftNum>=0 && leftNum<=self.allKLineArray.count - self.allNum) {
        self.nowKLineArray = [self.allKLineArray subarrayWithRange:NSMakeRange(leftNum, self.allNum)];
        //判断当前数组中个数是否为0
        if (self.nowKLineArray.count>0) {
            for (int i = 0; i<self.nowKLineArray.count; i++) {
                //将当前的模型赋值给self的模型
                self.KLine = self.nowKLineArray[i];
                
                //如果开盘价大于收盘价
                if (self.KLine.open>self.KLine.close) {
                    /********************************************绘制阴K线**************************************************/
                    
                    //此时为绿线下跌K线
                    CGFloat KLineX = i * (SCREEN_WIDTH/self.allNum);
                    CGFloat KLineY = (self.MaxKLineH - self.KLine.open)/(self.MaxKLineH-self.MinKLineH)*self.frame.size.height;
                    CGFloat KLineW = SCREEN_WIDTH/self.allNum;
                    CGFloat KLineH = (self.KLine.open - self.KLine.close)/(self.MaxKLineH - self.MinKLineH)*self.frame.size.height;
                    //拿到上下文
                    CGContextRef ctx = UIGraphicsGetCurrentContext();
                    
                    //画一个矩形
                    CGContextAddRect(ctx,CGRectMake(KLineX, KLineY, KLineW, KLineH));
                    //设置颜色
                    [[UIColor greenColor] set];
                    //渲染显示到view上面
                    CGContextFillPath(ctx);
                    
                    /********************************************绘制上下阴线**************************************************/
                    
                    CGContextSaveGState(ctx);
                    //画一根线,上影线
                    CGFloat upLineX = KLineX + KLineW * 0.5;
                    CGFloat upLineY = KLineY - (self.KLine.high - self.KLine.open)/(self.MaxKLineH - self.MinKLineH)* self.frame.size.height;
                    //设置下影线的X值
                    CGFloat downLineX = upLineX;
                    CGFloat downLineY = KLineY + (self.KLine.close - self.KLine.low)/(self.MaxKLineH - self.MinKLineH)* self.frame.size.height;
                    //画线
                    CGContextMoveToPoint(ctx,upLineX , upLineY);
                    CGContextAddLineToPoint(ctx, downLineX, downLineY);
                    //设置显得宽度
                    CGContextSetLineWidth(ctx, 1);
                    //设置颜色
                    [[UIColor greenColor]set];
                    //渲染到上下文
                    CGContextStrokePath(ctx);
                    CGContextRestoreGState(ctx);
                    
                }else if (self.KLine.open<self.KLine.close){//如果收盘价大于开盘价
                    /********************************************绘制阳K线**************************************************/
                    //此时为红线上升K线
                    CGFloat KLineX = i * (SCREEN_WIDTH/self.allNum);
                    CGFloat KLineY = (self.MaxKLineH - self.KLine.close)/(self.MaxKLineH-self.MinKLineH)*self.frame.size.height;
                    CGFloat KLineW = SCREEN_WIDTH/self.allNum;
                    CGFloat KLineH = (self.KLine.close - self.KLine.open)/(self.MaxKLineH - self.MinKLineH)*self.frame.size.height;
                    CGContextRef ctx = UIGraphicsGetCurrentContext();
                    //画一个矩形
                    CGContextAddRect(ctx,CGRectMake(KLineX, KLineY, KLineW, KLineH));
                    //设置颜色
                    [[UIColor redColor]set];
                    //绘制图形
                    CGContextFillPath(ctx);
                    /********************************************绘制上下阳线**************************************************/
                    
                    CGContextSaveGState(ctx);
                    //画一根线,上影线
                    CGFloat upLineX = KLineX + KLineW * 0.5;
                    CGFloat upLineY = KLineY - (self.KLine.high - self.KLine.close)/(self.MaxKLineH - self.MinKLineH)* self.frame.size.height;
                    //设置下影线的X值
                    CGFloat downLineX = upLineX;
                    CGFloat downLineY = KLineY + (self.KLine.open - self.KLine.low)/(self.MaxKLineH - self.MinKLineH)* self.frame.size.height;
                    //画线
                    CGContextMoveToPoint(ctx,upLineX , upLineY);
                    CGContextAddLineToPoint(ctx, downLineX, downLineY);
                    //设置显得宽度
                    CGContextSetLineWidth(ctx, 1);
                    //设置颜色
                    [[UIColor redColor]set];
                    //渲染到上下文
                    CGContextStrokePath(ctx);
                    CGContextRestoreGState(ctx);
                    
                }
            }
        }
    }
}



//懒加载
- (CGFloat)allNum{
    //也就是说没有给这个东西赋值的时候，屏幕的初始值就是100根
    if (_allNum == 0) {
        _allNum = 30;
    }
    
    return _allNum;
}
-(NSArray *)nowKLineArray{
    if (_nowKLineArray == nil) {
        _nowKLineArray = [NSArray array];
    }
    return _nowKLineArray;
}

-(CGFloat)XiS{
    _XiS = self.frame.size.height/(self.MaxKLineH-self.MinKLineH);
    
    return _XiS;
}
- (CGFloat)contentX{

    return _contentX;
}
- (NSMutableArray *)allKLineArray{
    if (_allKLineArray == nil) {
        _allKLineArray = [NSMutableArray array];
    }
    return _allKLineArray;
}
-(NSNumber *)leftNum{
    if (_leftNum == nil) {
        _leftNum = [[NSNumber alloc]init];
    }
    return _leftNum;
}
@end

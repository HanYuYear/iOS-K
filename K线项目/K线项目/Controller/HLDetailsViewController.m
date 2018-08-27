//
//  HLDetailsViewController.m
//  K线项目
//
//  Created by homilyiosfiveMac-mini on 2018/8/27.
//  Copyright © 2018年 com.homily. All rights reserved.
//

#import "HLDetailsViewController.h"
#import "HLDetailsTopView.h"
#import "HLDetails.h"
@interface HLDetailsViewController ()<NSXMLParserDelegate,HLDetailsTopViewDelegate>
//上方的视图
@property (nonatomic,strong)HLDetailsTopView *topView;
//存放上方数据的数组
@property (nonatomic,strong)NSMutableArray *topList;
//用于拼接上方数据的字符串
@property (nonatomic,strong)NSMutableString *topStr;
//上方数组模型
@property (nonatomic,strong)HLDetails *t;
//结构体用来调用.day中的文件
struct StockDay
{
    int m_lDate;              //日期
    
    unsigned int    m_lOpenPrice;    //开
    unsigned int    m_lMaxPrice;        //高
    unsigned int    m_lMinPrice;        //低
    unsigned int    m_lClosePrice;    //收
    
    int            m_lMoney;    //成交金额
    unsigned int    m_lTotal;        //成交量   单位：百股（手）
    
    unsigned int            m_lNoUse1;  //未使用
    unsigned int            m_lNoUse2;  //未使用
    unsigned int            m_lNoUse3;  //未使用
};
@end

@implementation HLDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self loadData];
    self.topView.t = self.t;
    [self.view addSubview:self.topView];
    
    [self getStockDayData];
    
    

}

#pragma mark - 懒加载
-(NSMutableArray *)topList{
    if (_topList == nil) {
        _topList = [[NSMutableArray alloc]init];
    }
    return _topList;
}
-(NSMutableString *)topStr{
    if (_topStr == nil) {
        _topStr = [NSMutableString string];
    }
    return _topStr;
}
- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[HLDetailsTopView alloc]init];
    }
    return _topView;
}

//将XML文件中的数据赋值到数组
- (void)loadData{
    //URL
    NSURL *url = [NSURL URLWithString:@"file:///Users/homilyiosfivemac-mini/Desktop/IOS%E5%85%A5%E8%81%8C%E6%B5%8B%E8%AF%95%E9%A2%98-%E4%B8%AD%E7%BA%A7/Detail.xml"];
    //request
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10];
    //发送请求
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *data = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //1、
        NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
        //2、设置代理
        parser.delegate = self;
        //3、开始解析
        [parser parse];
    }];
    [data resume];
}



#pragma mark - xml解析代理方法
//1开始
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    //    NSLog(@"开始解析文档");
    //1、懒加载数组
    if (!self.topList) {
        self.topList = [NSMutableArray array];
    }else{
        [self.topList removeAllObjects];
    }
    //初始化字符串elementString
    if (!self.topStr) {
        self.topStr = [NSMutableString string];
    }else{
        [self.topStr setString:@""];
    }
    
}

//2开始一个节点 <element> 是一个节点名称
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    if ([elementName isEqualToString:@"volume"]) {
        
        self.t = [[HLDetails alloc]init];
    }
    //每一个新节点之前都清空elementString
    //避免每一次的结果被重复拼接
    self.topStr = [NSMutableString string];
}

//3查找内容,可能会重复多次
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //拼接
    [self.topStr appendString:string];
}

//4节点结束 </element>
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"rise"]) {
        NSString *str = [self.topStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *str2 = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        [self.t setValue:str2 forKey:elementName];
        [self.topList addObject:self.t];
    }else if (![elementName isEqualToString:@"datas"]){
        NSString *str = [self.topStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *str2 = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        [self.t setValue:str2 forKey:elementName];
    }
}

//5文档结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
}
//6出错处理
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
}



#pragma mark - 解析.day文件数据
void OnReadDay()
{
    FILE *pfDay;
    if((pfDay =fopen("/600617.day","rb"))==NULL)
    {
        return;
    }
    int Header;
    int Unused;
    int DateField;
    unsigned int Open,High,Low,ClosePrice,Volume,Money;
    int i;
    fread(&Header,sizeof(int),1,pfDay);     //读取文件头的内容，开始,具体内容不重要
    for(i=1;i<16;i++)
        fread(&Unused,sizeof(int),1,pfDay);    //读取文件头共计64字节，结束
    
    fread(&DateField,sizeof(int),1,pfDay);    //读取记录的开始，日期
    //    m_strDate.Format("%d",DateField);
    fread(&Open,sizeof(unsigned int),1,pfDay);   //开盘价
    fread(&High,sizeof(unsigned int),1,pfDay);   //最高价
    fread(&Low,sizeof(unsigned int),1,pfDay);   //最低价
    fread(&ClosePrice,sizeof(unsigned int),1,pfDay); //收盘价
    fread(&Money,sizeof(int),1,pfDay);     //成交金额
    fread(&Volume,sizeof(unsigned int),1,pfDay);  //成交量
    for(i=1;i<6;i++)
        fread(&Unused,sizeof(unsigned int),1,pfDay); //无用
    ///////////第一笔记录全部读取完毕/////////////////////////////////////
    double fOpen,fHigh,fLow,fClose,fVol,fMoney;
    //把读取数据转换成为保留两位小数的单价。
    ConvertPrice(Open,&fOpen);
    ConvertPrice(High,&fHigh);
    ConvertPrice(Low,&fLow);
    ConvertPrice(ClosePrice,&fClose);
    //显示在EDIT控件中
    //    m_strOpen.Format("%.2f元",fOpen);
    //    m_strHigh.Format("%.2f元",fHigh);
    //    m_strLow.Format("%.2f元",fLow);
    //    m_strClose.Format("%.2f元",fClose);
    fVol = Volume/100.0;        //把成交量换算为手数
    fMoney=Money/10000.0;        //把成交金额换算为万元
    //    m_strVolume.Format("%.0f手",fVol);
    //    m_strMoney.Format("%.0f万元",fMoney);
    //    UpdateData(false);
}
BOOL ConvertPrice(int price, double *fPrice)
{
    double dbl;
    int uTemp;
    const int  baseNumber=0xb0000000;
    const double Thousand = 1000.0;
    uTemp = price ^ baseNumber;
    dbl = uTemp / Thousand;
    *fPrice = dbl;
    return TRUE;
}
#pragma mark 获取股票数据
-(void)getStockDayData{
    
    OnReadDay();
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"600617" ofType:@".day"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    struct   StockDay day;
    
    long count = [data length]/sizeof(day);
    
    
    for (int i = 0; i<count; i++) {
        
        [data getBytes:&day range:NSMakeRange(0+sizeof(day)*i, sizeof(day))];
        
    }
    
    
}
@end

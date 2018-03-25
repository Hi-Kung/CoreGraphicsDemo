//
//  CGView.m
//  CoreGraphicsDemo
//
//  Created by HK on 18/3/21.
//  Copyright © 2018年 HK. All rights reserved.
//

#import "CGView.h"

#define RadiusOfDegree(x) (x*M_PI/180.0)

@implementation CGView

-(instancetype)initWithFrame:(CGRect)frame type:(CGViewType)type{
    if (self = [super initWithFrame:frame]) {
//        NSLog(@"------> %s",__func__);
        _type = type;
        _xSpeed = 2.0;
        
    }
    return self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//    NSLog(@"------> %s",__func__);
    [super drawLayer:layer inContext:ctx];
}

// 绘图只能在此方法中调用，否则无法得到当前图形上下文

- (void)drawRect:(CGRect)rect{
//    NSLog(@"------> %s",__func__);
    switch (self.type) {
        case CGViewTypeOrigin:
            // 方法1
            [self originMethod];
            break;
        case CGViewTypeCoreGpaphics:{
            // 方法2
            [self drawLine];
            //    [self drawRect];
        }
            break;
        case CGViewTypeUIKit:{
            // 方法3
//            [self drawRectByUIKit];
            // 方法4
            [self drawWithBezierPath];
        }
            break;
        case CGViewTypeText:
            [self drawText];
            break;
        case CGViewTypeSmileFace:
            [self drawSmileFace];
            break;
        case CGViewTypeParabola:
            [self drawParabola];
            break;
        case CGViewTypePee:
            [self drawPee];
            break;
        default:
            break;
    }
}


- (void)originMethod{
    //1. 取得图形上下文对象
    CGContextRef context = UIGraphicsGetCurrentContext();

//    //** 存储图形上下文当前旧的状态
//    CGContextSaveGState(context);

    //2.创建路径对象
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 20, 50);//移动到指定位置（设置路径起点）
    CGPathAddLineToPoint(path, nil, 20, 100);//绘制直线（从起始位置开始）
    CGPathAddLineToPoint(path, nil, 300, 100);//绘制另外一条直线（从上一直线终点开始绘制）
    
    
    //3.添加路径到图形上下文
    CGContextAddPath(context, path);
    
    //4.设置图形上下文状态属性
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1);//设置笔触颜色
    CGContextSetRGBFillColor(context, 0, 1.0, 0, 1);//设置填充色
    CGContextSetLineWidth(context, 2.0);//设置线条宽度
    CGContextSetLineCap(context, kCGLineCapRound);//设置顶点样式,（20,50）和（300,100）是顶点
    CGContextSetLineJoin(context, kCGLineJoinRound);//设置连接点样式，(20,100)是连接点
    /*设置线段样式
     phase:虚线开始的位置
     lengths:数组， 如果交替绘制 @{10,10}， 这意思就是先绘制10个点， 再跳过10个点的实现，以此类推， 如果是@{10，50，20}， 则意思变成 先绘制10个点， 再跳过50个点，再绘制20个点， 在跳过10个点，再绘制50个点，以此类推
     count:lengths数组长度
     */
    CGFloat lengths[2] = { 9, 6 };
    CGContextSetLineDash(context, 0, lengths, 2);
    /*设置阴影
     context:图形上下文
     offset:偏移量
     blur:模糊度
     color:阴影颜色
     */
    CGColorRef color = [UIColor grayColor].CGColor;//颜色转化，由于Quartz 2D跨平台，所以其中不能使用UIKit中的对象，但是UIkit提供了转化方法
    CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0.8, color);
    
    //5.绘制图像到指定图形上下文
    /*CGPathDrawingMode是填充方式,枚举类型
     kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
     kCGPathStroke:只有边框
     kCGPathFillStroke：既有边框又有填充
     kCGPathEOFillStroke：奇偶填充并绘制边框
     */
    CGContextDrawPath(context, kCGPathFillStroke);//最后一个参数是填充类型
    
    //6.释放对象
    CGPathRelease(path);
    
//    //** 恢复到之前保存的图形状态
//    CGContextRestoreGState(context);
}

// 方法2：Core Graphics 内部对创建对象添加到上下文这两步操作进行了封装，可以一步完成。另外前面也说过UIKit内部其实封装了一些以“UI”开头的方法帮助大家进行图形绘制

-(void)drawLine{
    //1.获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.绘制路径（相当于前面创建路径并添加路径到图形上下文两步操作）
    CGContextMoveToPoint(context, 20, 50);
    CGContextAddLineToPoint(context, 20, 100);
    CGContextAddLineToPoint(context, 300, 100);
    //封闭路径:a.创建一条起点和终点的线,不推荐
    //CGPathAddLineToPoint(path, nil, 20, 50);
    //封闭路径:b.直接调用路径封闭方法
    CGContextClosePath(context);
    
    //3.设置图形上下文属性
    [[UIColor redColor]setStroke];//设置红色边框
    [[UIColor greenColor]setFill];//设置绿色填充
    //[[UIColor blueColor]set];//同时设置填充和边框色
    
    //4.绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
}

// 方法2：

-(void)drawRect{
    // 取得图形上下文对象
    CGContextRef context = UIGraphicsGetCurrentContext();

    //添加矩形对象
    CGRect rect=CGRectMake(20, 50, 280.0, 50.0);
    CGContextAddRect(context,rect);
    //设置属性
    [[UIColor blueColor]set];
    //绘制
    CGContextDrawPath(context, kCGPathFillStroke);
}

// 方法3：利用UIKit的封装方法

-(void)drawRectByUIKit{

    CGRect rect= CGRectMake(20, 150, 280.0, 50.0);
    CGRect rect2=CGRectMake(20, 250, 280.0, 50.0);
    //设置属性
    [[UIColor yellowColor]set];
    //绘制矩形,相当于创建对象、添加对象到上下文、绘制三个步骤
    UIRectFill(rect);//绘制矩形（只有填充）
    
    [[UIColor redColor]setStroke];
    UIRectFrame(rect2);//绘制矩形(只有边框)
}

// 方法4：UIBezierPath
- (void)drawWithBezierPath{

    // 1.创建路径对象
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 2.添加路径
    [path moveToPoint:CGPointMake(20, 150)];
    [path addLineToPoint:CGPointMake(20, 200)];
    [path addLineToPoint:CGPointMake(300, 200)];
    // 3.设置属性
    path.lineWidth = 2;
    CGFloat lengths[2] = { 9, 6 };
    [path setLineDash:lengths count:2 phase:0];
    
    [[UIColor redColor] setStroke];
    [[UIColor blueColor] setFill];
//    [[UIColor redColor] set];

    
    // 4.绘制路径
    [path fill];
    [path stroke];
    
}

// 绘制文字
-(void)drawText{
    //绘制到指定的区域内容
    NSString *str=@"Star Walk is the most beautiful stargazing app you’ve ever seen on a mobile device. It will become your go-to interactive astro guide to the night sky, following your every movement in real-time and allowing you to explore over 200, 000 celestial bodies with extensive information about stars and constellations that you find.";
    CGRect rect= CGRectMake(20, 50, 280, 300);
    UIFont *font=[UIFont systemFontOfSize:18];//设置字体
    UIColor *color=[UIColor redColor];//字体颜色
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];//段落样式
    NSTextAlignment align=NSTextAlignmentLeft;//对齐方式
    style.alignment=align;
    [str drawInRect:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:style}];
}

- (void)drawSmileFace{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat faceR = 60,mouthR = 36,eyeW = 15,eyeH = 10;
    CGFloat start = -M_PI_2, end = start+2*M_PI*self.progress;

    // 轮廓
    CGContextAddArc(context, self.center.x, self.center.y, faceR, start, end, NO);

    // 左眼睛
    CGContextMoveToPoint(context, self.center.x-eyeW*2, self.center.y);
    CGContextAddLineToPoint(context, self.center.x-eyeW*1.5, self.center.y-eyeH);
    CGContextAddLineToPoint(context, self.center.x-eyeW, self.center.y);

    // 右眼
    CGContextMoveToPoint(context, self.center.x+eyeW*2, self.center.y);
    CGContextAddLineToPoint(context, self.center.x+eyeW*1.5, self.center.y-eyeH);
    CGContextAddLineToPoint(context, self.center.x+eyeW, self.center.y);
    
    // 属性
    [[UIColor greenColor] setStroke];
    CGContextSetLineWidth(context, 2);
    
    // 渲染路径
    //    CGContextDrawPath(context, kCGPathStroke);
    CGContextStrokePath(context);

    CGContextSaveGState(context);
//    CGContextBeginPath(context);
    // 嘴巴
    CGFloat mouthAngel = 80*self.progress;
    CGContextAddArc(context, self.center.x, self.center.y+10, mouthR, M_PI_2+RadiusOfDegree(mouthAngel), M_PI_2-RadiusOfDegree(mouthAngel), YES);
    [[UIColor redColor] setStroke];
    CGContextSetLineWidth(context, 2);
    
    CGContextStrokePath(context);

    CGContextRestoreGState(context);
    
}

// 抛物线
- (void)drawParabola {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat maxW = self.bounds.size.width, originY = 100, g = 0.05;
    CGFloat distance = maxW*self.progress;
    CGContextMoveToPoint(context, 0, originY);
    for (NSInteger x = 0; x < distance; x++) {
        CGFloat t = x /self.xSpeed, y = originY+g*t*t*0.5;
        CGContextAddLineToPoint(context, x, y);
    }
    CGContextSetLineWidth(context, 2);
    [[UIColor blueColor] setStroke];
    CGContextStrokePath(context);

}

- (void)drawPee {
//     UIBezierPath
    
    CGFloat maxW = self.bounds.size.width, originY = 100, g = 0.05;
    
    CGFloat boyH = 60;
    
    CGFloat x = 0.6*boyH + maxW*self.progress, t = x/self.xSpeed, y = originY+g*t*t*0.5;

    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0.6*boyH; i < x; i=i+4) {
        t = i/self.xSpeed, y = originY+g*t*t*0.5;
        [path moveToPoint:CGPointMake(i, y)];
        [path addArcWithCenter:CGPointMake(i, y) radius:2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    }
    [[UIColor orangeColor] setStroke];
    [path stroke];
    
    UIImage *boy = [UIImage imageNamed:@"pee"];
    [boy drawInRect:CGRectMake(0, originY-boyH/3.0*2, boyH, boyH)];

}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}

@end

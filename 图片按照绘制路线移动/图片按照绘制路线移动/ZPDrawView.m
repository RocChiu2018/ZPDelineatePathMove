//
//  ZPDrawView.m
//  图片按照绘制路线移动
//
//  Created by 赵鹏 on 2019/1/12.
//  Copyright © 2019 赵鹏. All rights reserved.
//

/**
 首先要在storyboard文件中把视图控制器的View的Class由UIView类改为本类。
 */
#import "ZPDrawView.h"

@interface ZPDrawView ()

@property (nonatomic, strong) UIBezierPath *bezierPath;

@end

@implementation ZPDrawView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    //获取当前手指的触摸点
    CGPoint cutPoint = [touch locationInView:self];
    
    //创建贝塞尔路径
    self.bezierPath = [UIBezierPath bezierPath];
    
    //设置路径的起点
    [self.bezierPath moveToPoint:cutPoint];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint cutPoint = [touch locationInView:self];
    
    [self.bezierPath addLineToPoint:cutPoint];
    
    //重绘
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"position";
    animation.path = self.bezierPath.CGPath;
    animation.duration = 2.0;
    animation.repeatCount = MAXFLOAT;
    
    //获取图片
    UIImageView *imageView = [self.subviews firstObject];
    
    //用户在绘制完路径之后，在即将抬手的时候给图片添加动画并立即执行
    [imageView.layer addAnimation:animation forKey:nil];
}

- (void)drawRect:(CGRect)rect
{
    [self.bezierPath stroke];
}

@end

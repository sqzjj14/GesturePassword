//
//  GesPasswordView.m
//  GesturePassword
//
//  Created by 吴凡 on 16/9/12.
//  Copyright © 2016年 吴凡. All rights reserved.
//
#import "GesPasswordView.h"

#define Margin_SuperView 15.f
#define Spacing_Btn 25.f

@implementation GesPasswordView
{
    CGFloat BtnWH;//(btn的宽高，宽高相等)
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        BtnWH = (frame.size.width - 2 * Margin_SuperView - 2 * Spacing_Btn)/3;
        _AmountArr = [[NSMutableArray alloc]init];
        _selectArr = [[NSMutableArray alloc]init];
        _PasswordArr = [[NSMutableArray alloc]init];
        _BgImageView = [[UIImageView alloc]initWithFrame:frame];
        [self addSubview:_BgImageView];
        
        for (int i = 0;i < 3; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(Margin_SuperView, Margin_SuperView + (BtnWH + Spacing_Btn)  * i, BtnWH, BtnWH);
            [btn setImage:[UIImage imageNamed:@"ges_background"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"ges_left"] forState:UIControlStateHighlighted];
            btn.userInteractionEnabled = NO;
            btn.tag = 1 + i*3;  // 1 4 7
            [self.AmountArr addObject:btn];
            [self.BgImageView addSubview:btn];
        }
        
        for (int i = 0;i < 3; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(Margin_SuperView + BtnWH + Spacing_Btn, Margin_SuperView + (BtnWH + Spacing_Btn) * i, BtnWH, BtnWH);
            [btn setImage:[UIImage imageNamed:@"ges_background"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"ges_middle"] forState:UIControlStateHighlighted];
            btn.userInteractionEnabled = NO;
            btn.tag = 2 + i*3; //2 5 8
            [self.AmountArr addObject:btn];
            [self.BgImageView addSubview:btn];
        }
        
        for (int i = 0;i < 3; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(Margin_SuperView + 2 * (Spacing_Btn + BtnWH), Margin_SuperView + (BtnWH + Spacing_Btn) * i, BtnWH, BtnWH);
            [btn setImage:[UIImage imageNamed:@"ges_background"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"ges_right"] forState:UIControlStateHighlighted];
            btn.userInteractionEnabled = NO;
            btn.tag = 3 + i*3; // 3 6 9
            [self.AmountArr addObject:btn];
            [self.BgImageView addSubview:btn];
        }

    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch) {
        for (UIButton *btn in self.AmountArr) {
            
            CGPoint point = [touch locationInView:btn];
            
            if ([btn pointInside:point withEvent:nil]) {
                
                [self.selectArr addObject:btn];
                [self.PasswordArr addObject:@(btn.tag)];
                btn.highlighted = YES;
                self.StartPoint = btn.center;
                
            }
            
        }
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch) {
        
        self.EndPoint = [touch locationInView:self.BgImageView];
        for (UIButton *btn in self.AmountArr) {
            
            CGPoint point = [touch locationInView:btn];//相对btn图层的坐标
            
            if ([btn pointInside:point withEvent:nil]) {
                
                BOOL isAdd = YES;
                
                for (UIButton *reBtn in self.selectArr) {
                    if (reBtn == btn) {
                        isAdd = NO;
                        break;
                    }
                }
                
                if (isAdd) {
                    [self.selectArr addObject:btn];
                    [self.PasswordArr addObject:@(btn.tag)];
                    btn.highlighted = YES;
                }
            }
        }
        
    }
    self.BgImageView.image = [self drawLine];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *PasswordStr = @"";
    for (NSNumber *num in self.PasswordArr) {
        NSString *str = [NSString stringWithFormat:@"%@",num];
        PasswordStr = [PasswordStr stringByAppendingString:str];
    }
    NSLog(@"password = %@",PasswordStr);
    
    self.BgImageView.image = nil;
    [self.selectArr removeAllObjects];
    [self.PasswordArr removeAllObjects];
    for (UIButton *btn in self.AmountArr) {
        btn.highlighted = NO;
    }
}


-(UIImage *)drawLine
{
    UIImage *image = nil;
    
    UIColor *color = [UIColor colorWithRed:36/255.0 green:123/255.0 blue:197/255.0 alpha:1];
    UIGraphicsBeginImageContext(self.BgImageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextMoveToPoint(context, self.StartPoint.x, self.StartPoint.y);
    
    if (_selectArr.count == 0) {
        return nil;
    }
    else{
        for (UIButton *btn in _selectArr) {
            CGPoint point = btn.center;
            CGContextAddLineToPoint(context, point.x, point.y);
            CGContextMoveToPoint(context, point.x, point.y);
        }
    }
    
    CGContextAddLineToPoint(context, self.EndPoint.x,self.EndPoint.y);
    CGContextStrokePath(context);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}









@end

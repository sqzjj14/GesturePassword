//
//  GesPasswordView.h
//  GesturePassword
//
//  Created by 吴凡 on 16/9/12.
//  Copyright © 2016年 吴凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GesPasswordView : UIView
@property (nonatomic,strong)UIImageView *BgImageView;
@property (nonatomic,strong)NSMutableArray *AmountArr;
@property (nonatomic,strong)NSMutableArray *selectArr;
@property (nonatomic,assign)CGPoint StartPoint;
@property (nonatomic,assign)CGPoint EndPoint;
@property (nonatomic,strong)NSMutableArray *PasswordArr;
@end

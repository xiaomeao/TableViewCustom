//
//  TranslateBubbleView.h
//
//  Created by 杜 on 2018/7/03.
//  Copyright © 2018年 杜. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TranslateModel;
@interface TranslateBubbleView : UIButton


/**
 点播正文译文  10000正文  20000译文
 */
@property (nonatomic, strong) void (^playBtnBlock)(NSInteger);

/**
 赋值
 */
- (void)setupBubbleData:(TranslateModel *)model;

/**
 设置frame
 */
- (void)updateBubbleFrame:(TranslateModel *)model;

@end

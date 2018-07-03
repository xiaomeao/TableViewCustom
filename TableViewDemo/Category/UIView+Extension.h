//
//  UIView+Extension.h
//
//  Created by 杜 on 2018/7/03.
//  Copyright © 2018年 杜. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIViewCategoryNormalBlock)(UIView *view);

@interface UIView (Extension)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/** 添加圆角 */
- (void)roundedRectWithRadius:(CGFloat)radius;

/** 添加边框 */
- (void)borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

/** 增加手势 */
- (void)addTapGestureWithBlock:(UIViewCategoryNormalBlock)aBlock;

@end














//
//  TranslateModel.h
//
//  Created by 杜 on 2018/7/03.
//  Copyright © 2018年 杜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommonConfig.h"
#import "TranslateEnum.h"

#define maxBubbleWidth (IPHONE_WIDTH - 105)  //泡泡占屏幕最大宽
#define PaddingSpacing 15      //垂直间距
#define HorizontalSpacing 10   //水平间距

@interface TranslateModel : NSObject

///左或右消息  默认左 NO
@property (nonatomic, assign) BOOL isSend;
///中文
@property (nonatomic, copy) NSString *originalText;
///英文
@property (nonatomic, copy) NSString *translationText;
///时间戳
@property (nonatomic, copy) NSString *timestamp;
///cell高度
@property (nonatomic, assign) CGFloat cellHeight;
///泡泡宽度
@property (nonatomic, assign) CGFloat bubbleWidth;
///正文高度
@property (nonatomic, assign) CGFloat originalHeight;
///英文高度
@property (nonatomic, assign) CGFloat translationHeight;
///文本类型
@property (nonatomic, assign) TranslateCharacterType textType;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

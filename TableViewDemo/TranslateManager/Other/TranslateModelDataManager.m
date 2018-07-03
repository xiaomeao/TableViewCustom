//
//  TranslateModelDataManager.m
//
//  Created by 杜 on 2018/7/03.
//  Copyright © 2018年 杜. All rights reserved.
//

#import "TranslateModelDataManager.h"

@implementation TranslateModelDataManager

- (void)dealloc
{
    NSLog(@"TranslateModelDataManager dealloc");
}

#pragma mark - 提示语
+ (TranslateModel *)obtainTipMessWith:(TranslateCharacterType)type
{
    NSString *originalText = @"";
    NSString *translationText = @"";
    switch (type) {
        case sTranslateCharacterTypeNormal:
            originalText = @"您想说点什么，我来帮您";
            translationText = @"Just say anything and I will translate it!";
            break;
        case sTranslateCharacterTypeNetworkError:
            originalText = @"糟糕，网络不给力";
            translationText = @"Network Error. Please check your network and try again.";
            break;
        case sTranslateCharacterTypeConnection:
            originalText = @"连接成功！您想说点什么，我来帮您";
            translationText = @"Connection successful! Just say anything and I will translate it!";
            break;
        case sTranslateCharacterTypeAuto:
            originalText = @"接下来会自动识别您说的语种";
            translationText = @"Listen to both lanuages now";
            break;
        case sTranslateCharacterTypeChinese:
            originalText = @"接下来只会识别您说的中文哦";
            translationText = @"Please speak Chinese";
            break;
        case sTranslateCharacterTypeEnglish:
            originalText = @"接下来只会识别您说的英文哦";
            translationText = @"Please speak English";
            break;
        default:
            break;
    }
    NSString *timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    TranslateModel *model = [[TranslateModel alloc] init];
    model.isSend = NO;
    model.textType = type;
    model.timestamp = timestamp;
    model.originalText = originalText;
    model.translationText = translationText;
    [TranslateModelDataManager caculateValue:model];
    return model;
}

#pragma mark - 用户消息
+ (TranslateModel *)obtainUserMessWithOriginalText:(NSString *)originalText translationText:(NSString *)translationText
{
    NSString *timestamp = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970] * 1000];
    TranslateModel *model = [[TranslateModel alloc] init];
    model.isSend = YES;
    model.textType = sTranslateCharacterTypeUserText;
    model.timestamp = timestamp;
    model.originalText = StringIsNullOrEmpty(originalText) ? @"连接成功！您想说点什么，我来帮您" : originalText;
    model.translationText = StringIsNullOrEmpty(translationText) ? @"Connection successful! Just say anything and I will translate it!" : translationText;
    [TranslateModelDataManager caculateValue:model];
    return model;
}

#pragma mark - private
#pragma mark - 计算文本宽高
+ (void)caculateValue:(TranslateModel *)model
{
    /*
     ———————————————————— ->cell顶部
     10
      ——————————————
     |              |
     |  bubbleView  |  
     |              |
      ——————————————
     10
     ———————————————————— —>cell底部
     */
    
    CGSize originalSize = [TranslateModelDataManager getTextSizeWithText:model.originalText isSend:model.isSend];
    CGSize translateSize = [TranslateModelDataManager getTextSizeWithText:model.translationText isSend:model.isSend];
    //正文译文宽度对比 取最大宽度
    CGFloat textMaxWith = MAX(originalSize.width, translateSize.width);
    //泡泡宽度
    CGFloat bubbleWidth = (PaddingSpacing * 2) + textMaxWith;
    //泡泡高度
    CGFloat maxBubbleHeight = originalSize.height + translateSize.height + (HorizontalSpacing * 4);
    //cell高度 = 泡泡高度 + 20   加20是因为 ： 泡泡y轴从10开始
    CGFloat cellHeitht = maxBubbleHeight + (HorizontalSpacing * 2);
    
    model.bubbleWidth = bubbleWidth;
    model.originalHeight = originalSize.height;
    model.translationHeight = translateSize.height;
    model.cellHeight = cellHeitht;
}

#pragma mark 计算正、译文的宽高
+ (CGSize)getTextSizeWithText:(NSString *)text isSend:(BOOL)isSend
{
    //文本占泡泡的最大宽
    CGFloat textMaxWidth = maxBubbleWidth - (PaddingSpacing * 2);
    CGSize textSize = [TranslateModelDataManager sizeWithString:text size:CGSizeMake(textMaxWidth, 1000) font:[UIFont systemFontOfSize:15]];
    textSize.width = MAX(15, textSize.width);
    textSize.height = MAX(22, textSize.height);
    return textSize;
}

+ (CGSize)sizeWithString:(NSString *)string size:(CGSize)size font:(UIFont *)font
{
    CGSize requiredSize;
    CGRect rect = [string boundingRectWithSize:size
                                       options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading
                                    attributes:@{NSFontAttributeName:font}
                                       context:nil];
    requiredSize = rect.size;
    return requiredSize;
}

@end

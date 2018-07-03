//
//  TranslateToolbarView.h
//
//  Created by 杜 on 2018/7/03.
//  Copyright © 2018年 杜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TranslateEnum.h"

@protocol TranslateToolbarViewDelegate;
@interface TranslateToolbarView : UIView

@property (weak, nonatomic) id<TranslateToolbarViewDelegate> delegate;

- (void)clearText;

@end

@protocol TranslateToolbarViewDelegate <NSObject>

@required
- (void)didReturnText:(NSString *)text;

/**
 语音识别类型切换

 @param type 识别类型 sTranslateLanguageTypeAuto
 */
- (void)languageChangeType:(TranslateLanguageType)type;

/**
 键盘高度变化

 @param toHeight 键盘高度
 @param appear 键盘显示隐藏布尔值
 */
- (void)toolbarDidChangeFrameToHeight:(CGFloat)toHeight isAppear:(BOOL)appear;

@end

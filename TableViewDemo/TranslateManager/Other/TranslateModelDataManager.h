//
//  TranslateModelDataManager.h
//
//  Created by 杜 on 2018/7/03.
//  Copyright © 2018年 杜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TranslateEnum.h"
#import "TranslateModel.h"

@interface TranslateModelDataManager : NSObject

/**
 提示语

 @param type 提示类型
 @return 消息结构
 */
+ (TranslateModel *)obtainTipMessWith:(TranslateCharacterType)type;

/**
 用户消息

 @param originalText 中午
 @param translationText 英文
 @return 消息结构
 */
+ (TranslateModel *)obtainUserMessWithOriginalText:(NSString *)originalText translationText:(NSString *)translationText;

@end

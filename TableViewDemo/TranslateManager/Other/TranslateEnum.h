//
//  TranslateEnum.h
//
//  Created by 杜 on 2018/7/03.
//  Copyright © 2018年 杜. All rights reserved.
//

///提示类型
typedef NS_ENUM(NSInteger, TranslateCharacterType) {
    sTranslateCharacterTypeNormal = 0,     //您想说点什么，我来帮您
    sTranslateCharacterTypeNetworkError,   //糟糕，网络不给力
    sTranslateCharacterTypeConnection,     //连接成功！您想说点什么，我来帮您
    sTranslateCharacterTypeAuto,           //接下来会自动识别您说的语种
    sTranslateCharacterTypeChinese,        //接下来只会识别您说的中文哦
    sTranslateCharacterTypeEnglish,        //接下来只会识别您说的英文哦
    sTranslateCharacterTypeMic,            //为保证同传效果请尽量靠近麦克风说话
    sTranslateCharacterTypeUserText        //用户的消息类型
};

///语言类型
typedef NS_ENUM(NSInteger, TranslateLanguageType) {
    sTranslateLanguageTypeAuto = 0,       //接下来会自动识别您说的语种
    sTranslateLanguageTypeChinese,        //接下来只会识别您说的中文哦
    sTranslateLanguageTypeEnglish         //接下来只会识别您说的英文哦
};

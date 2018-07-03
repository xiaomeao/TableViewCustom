//
//  CommonConfig.h
//
//  Created by 杜 on 2018/7/03.
//  Copyright © 2018年 杜. All rights reserved.
//

#define IPHONE_X    ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812) //判断是否为iPhoneX

//动态获取设备宽度
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width
#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height

//状态栏高度
#define StatusBar_Height    ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0)
//底部Tabbar高度
#define Tabbar_Height       (IPHONE_X ? (49 + 34) : 49)
//iPhone X底部高度
#define Tabbar_Bottom_Margin  (IPHONE_X ? 34 : 0)

//设置颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//设置颜色与透明度
#define UIColorFromRGBWithAlpha(rgbValue, al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]

#define TEXTCOLOR_BLACK     UIColorFromRGB(0x202020)
//  灰色字体颜色
#define TEXTCOLOR_GRAY      UIColorFromRGB(0x909090)

//使用8.2以上字体接口
#define WEIGHT_FONT(_size, _weight) IOS8_2 ? [UIFont systemFontOfSize:_size weight:_weight] : [UIFont systemFontOfSize:_size]

//字条串是否为空
#define StringIsNullOrEmpty(__string)             !(__string && __string.length > 0)

#define WEAKSELF                    __weak typeof(self) weakSelf = self;
#define WEAKSELFBY(__view)          __weak typeof(__view) weak_##__view = __view;

//根目录
#define ROOTPATH        NSHomeDirectory()

//获取Tmp目录路径
#define TMPPATH         NSTemporaryDirectory()

//获取Documents目录路径
#define DOCUMENTSPATH   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//获取Library目录路径
#define LIBRARYPATH     [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//获取Cache目录路径
#define CACHEPATH       [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define TranslatePath           [DOCUMENTSPATH stringByAppendingPathComponent:@"Translate"]
#define FMDB_TranslatePath      [TranslatePath stringByAppendingPathComponent:@"Translate.sqlite"]

// 全球翻译正文语音路径
#define TranslateDirectory_original(timestamp)  [DOCUMENTSPATH stringByAppendingPathComponent:[NSString stringWithFormat:@"Translate/Original/%@", timestamp]]
// 全球翻译译文语音路径
#define TranslateDirectory_translation(timestamp)  [DOCUMENTSPATH stringByAppendingPathComponent:[NSString stringWithFormat:@"Translate/Translation/%@", timestamp]]




//
//  UtilsHeader.h
//  FastCounter
//
//  Created by LiuYong on 2018/4/12.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#ifndef UtilsHeader_h
#define UtilsHeader_h

#pragma mark Utils

#pragma mark Size 尺寸

#define AppWidth [UIScreen mainScreen].bounds.size.width
#define AppHeight  [UIScreen mainScreen].bounds.size.height
#define TabbarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define NavgationBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64)

/*手机型号iphoneX*/
#define iPhoneX ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)
#define IPHONE_6P_6PS ([UIScreen mainScreen].bounds.size.width == 414 && [UIScreen mainScreen].bounds.size.height == 736)
#define IPHONE_6_6S ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 568)
#define IPHONE_5_5S ([UIScreen mainScreen].bounds.size.width == 320 && [UIScreen mainScreen].bounds.size.height == 568)
#define IPHONE_4_4S  [@(Screenwidth) compare:@(480)] == NSOrderedSame

#define kNavigationBarHeight 44
#define kStatusBarHeight 20
#define kTopBarHeight 64
#define kToolBarHeight 44
#define kTabBarHeight 49
#define kiPhone4_W 320
#define kiPhone4_H 480
#define kiPhone5_W 320
#define kiPhone5_H 568
#define kiPhone6_W 375
#define kiPhone6_H 667
#define kiPhone6P_W 414
#define kiPhone6P_H 736


#pragma mark Color 颜色

#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kGrayColor [UIColor grayColor]
#define kRedColor [UIColor redColor]
#define kGreenColor [UIColor greenColor]
#define kBlueColor [UIColor blueColor]
#define kCyanColor [UIColor cyanColor]
#define kYellowColor [UIColor yellowColor]
#define kMagentaColor [UIColor magentaColor]
#define kOrangeColor [UIColor orangeColor]
#define kPurpleColor [UIColor purpleColor]
#define kBrownColor [UIColor brownColor]
#define kClearColor [UIColor clearColor]
#define kColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define kCommonBgColor kColorWithRGB(44,197,94)
#define kRandomColor  kColorWithRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define MainColor kColorWithRGB(123,74,157)

#pragma mark Color 字体大小
#define kSfont(size) [UIFont systemFontOfSize:size]
#define kBfont(size) [UIFont boldSystemFontOfSize:size]


#endif /* UtilsHeader_h */

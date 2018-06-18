//
//  UIViewController+Addition.h
//  DBZY
//
//  Created by 刘勇 on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Addition)

/**
 *  判断是否是正在显示的控制器
 */
- (BOOL)isCurrentAndVisibleViewController;
/**
 跳转时隐藏Tabbar
 */
- (void)pushToNextViewController:(UIViewController *)nextVC;

/**
 跳到前一个页面
 */
-(void)popToFrontVc;

/*
 跳到根页面
 */
-(void)popToRootVc;


/*
 跳到制定页面
 */
-(void)popToController:(UIViewController*)Vc;










@end

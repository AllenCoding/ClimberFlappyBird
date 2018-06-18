//
//  UIViewController+Addition.m
//  DBZY
//
//  Created by 刘勇 on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIViewController+Addition.h"

@implementation UIViewController (Addition)

- (BOOL)isCurrentAndVisibleViewController {
    return self.isViewLoaded && self.view.window;
}

- (void)pushToNextViewController:(UIViewController *)nextVC {
    if (nextVC.hidesBottomBarWhenPushed==NO) {
        nextVC.hidesBottomBarWhenPushed=YES;
    }
    [self.navigationController pushViewController:nextVC animated:YES];
}

-(void)popToFrontVc{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)popToRootVc{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)popToController:(UIViewController *)Vc{
    for (UIViewController*cv in self.navigationController.viewControllers) {
        if ([cv isEqual:Vc]) {
            [self.navigationController popToViewController:Vc animated:YES];
        }
    }
}






@end

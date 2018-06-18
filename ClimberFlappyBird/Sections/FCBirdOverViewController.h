//
//  FCBirdOverViewController.h
//  FastCounter
//
//  Created by LiuYong on 2018/4/17.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnBlock)(void);
typedef void(^ReplayBlock)(void);

@protocol FCBirdOverDelegate <NSObject>
@required
-(void)didClickReplay;
-(void)didClickReturn;
@end

@interface FCBirdOverViewController : UIViewController

@property(nonatomic,copy)ReplayBlock replay;
@property(nonatomic,copy)ReturnBlock returnBlock;
@property(nonatomic,weak)id<FCBirdOverDelegate>delegate;

@end
